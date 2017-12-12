//
//  PDFPrintPageRenderer.m
//  PDFExporter
//
//  Copyright © 2015 3Pillar Global. All rights reserved.
//

#import "PDFPrintPageRenderer.h"
#import <objc/runtime.h>
#import "PDFPaperSizes.h"
#import "PDFRenderingDelegate.h"
#import "UIView+PDFExporterDrawing.h"
#import "UIView+PDFExporterViewSlicing.h"
#import "UIView+PDFExporterPageInformation.h"
#import "UIView+PDFExporterStatePersistance.h"
#import "UIScrollView+PDFExporterDrawing.h"
#import "PDFDispatchQueueExtension.h"
#import "CGGeometry+Additions.h"
#import "PDFMemoryCleanerObject.h"

static UIEdgeInsets const kDefaultPaperInsets = {30.f, 30.f, 30.f, 30.f};

@interface NSArray (PDFPrintPageRendererPrivate)

- (BOOL)hasObjectAtIndex:(NSUInteger)index;

@end

@interface PDFPrintPageRenderer () <PDFRenderingDelegate>

@property (nonatomic) CGFloat contentViewScale;
@property (nonatomic) CGFloat contentRectScale;

@property (nonatomic, readonly) CGRect renderingRect;

@property (nonatomic, readwrite) CGRect headerRect;
@property (nonatomic, readwrite) CGRect contentRect;
@property (nonatomic, readwrite) CGRect footerRect;

@property (nonatomic) NSUInteger internalNumberOfPages;

@property (nonatomic) NSMutableArray<NSValue *> *pageRects;

@end

@implementation PDFPrintPageRenderer

- (instancetype)init {
    if (self = [super init]) {
        self.paperSize = PDFPaperSizeUSLetter;
        self.pageOrientation = PDFPageOrientationPortrait;
        self.paperInset = kDefaultPaperInsets;
        self.pagingMask = PDFPagingOptionNone;
    }
    
    return self;
}

- (void)drawPages:(CGRect)inBounds {
    [self layoutViews];
    PDFMemoryCleanerObject __attribute__((unused)) *layout = [PDFMemoryCleanerObject memoryCleanerWithConstructBlock:^{
        [self preparePersistance];
    } deallocationBlock:^{
        [self cleanPersistance];
    }];
    [self computeGeometry];
    [self computeNumberOfPages];
    PDFMemoryCleanerObject __attribute__((unused)) *drawing = [PDFMemoryCleanerObject memoryCleanerWithConstructBlock:^{
        [self prepareContentForDrawing];
    } deallocationBlock:^{
        [self cleanContentAfterDrawing];
    }];
	for (NSInteger pageNumber = 0; pageNumber < self.numberOfPages; pageNumber++) {
		UIGraphicsBeginPDFPage();
		[self drawPageAtIndex:pageNumber inRect:self.printableRect];
	}
}

- (NSData *)drawPagesToPDFData {
	NSMutableData *pdfData = [NSMutableData data];
    PDFMemoryCleanerObject __attribute__((unused)) *drawing = [PDFMemoryCleanerObject memoryCleanerWithConstructBlock:^{
        UIGraphicsBeginPDFContextToData(pdfData, self.paperRect, nil);
    } deallocationBlock:^{
        UIGraphicsEndPDFContext();
    }];
	CGRect bounds = UIGraphicsGetPDFContextBounds();
	[self drawPages:bounds];
	return pdfData;
}

#pragma mark - Getters and Setters

- (CGRect)paperRect {
    CGRect paperRect = CGRectZero;
    switch (self.pageOrientation) {
        case PDFPageOrientationLandscape:
            paperRect.size = CGSizeMake(self.paperSize.height, self.paperSize.width);
            break;
        case PDFPageOrientationPortrait:
        default:
            paperRect.size = self.paperSize;
            break;
    }
    return paperRect;
}

- (CGRect)printableRect {
    return UIEdgeInsetsInsetRect(self.paperRect, self.paperInset);
}

- (NSInteger)numberOfPages {
    return self.internalNumberOfPages;
}

- (CGRect)renderingRect {
    return ([self isScalingContent]) ? CGRectCeil(CGRectScaleByFactor(self.contentRect, self.contentRectScale)) : self.contentRect;
}

- (CGFloat)headerHeight {
    if (!self.headerView) {
        return 0.f;
    }
    
    if ([self isScalingHeader]) {
        CGFloat headerScaleFactor = self.printableRect.size.width / self.headerView.drawingFrame.size.width;
        return ceilf(CGRectGetHeight(self.headerView.drawingFrame) * headerScaleFactor);
    } else {
        return CGRectGetHeight(self.headerView.drawingFrame);
    }
}

- (CGRect)headerRect {
    CGRect headerRect = self.printableRect;
    headerRect.size.height = self.headerHeight;
    return headerRect;
}

- (CGRect)contentRect {
    return CGRectMake(CGRectGetMinX(self.printableRect),
                      CGRectGetMaxY(self.headerRect),
                      CGRectGetWidth(self.printableRect),
                      CGRectGetMinY(self.footerRect) - CGRectGetMaxY(self.headerRect));
}

- (CGRect)footerRect {
    return CGRectMake(CGRectGetMinX(self.printableRect),
                      CGRectGetMaxY(self.printableRect) - self.footerHeight,
                      CGRectGetWidth(self.printableRect),
                      self.footerHeight);;
}

- (void)setHeaderHeight:(CGFloat)headerHeight {
    // Do nothing.
}

- (CGFloat)footerHeight {
    if (!self.footerView) {
        return 0.f;
    }
    
    if ([self isScalingFooter]) {
        CGFloat footerScaleFactor = self.printableRect.size.width / self.footerView.drawingFrame.size.width;
        return ceilf(CGRectGetHeight(self.footerView.drawingFrame) * footerScaleFactor);
    } else {
        return CGRectGetHeight(self.footerView.drawingFrame);
    }
}

- (void)setFooterHeight:(CGFloat)footerHeight {
    // Do nothing.
}

#pragma mark - Overriden

- (void)drawPageAtIndex:(NSInteger)pageIndex inRect:(CGRect)printableRect {
    [self drawContentForPageAtIndex:pageIndex inRect:self.contentRect];
    [self drawHeaderForPageAtIndex:pageIndex inRect:self.headerRect];
    [self drawFooterForPageAtIndex:pageIndex inRect:self.footerRect];
}

- (void)drawHeaderForPageAtIndex:(NSInteger)pageIndex inRect:(CGRect)headerRect {
    [super drawHeaderForPageAtIndex:pageIndex inRect:headerRect];
    
    if ((self.pagingMask & PDFPagingOptionHeader) == PDFPagingOptionHeader) {
        NSAssert([self.headerView respondsToSelector:@selector(updatePageNumber:totalPages:)], @"Header view doesn't implement selector (updatePageNumber:totalPages:).");
        [self.headerView updatePageNumber:pageIndex totalPages:self.numberOfPages];
    }
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSaveGState(context);
    UIBezierPath *headerPath = [UIBezierPath bezierPathWithRect:headerRect];
    CGContextAddPath(context, headerPath.CGPath);
    CGContextClip(context);
    CGContextTranslateCTM(context, headerRect.origin.x, headerRect.origin.y);
    if ([self isScalingHeader]) {
        CGFloat headerScaleFactor = self.printableRect.size.width / self.headerView.drawingFrame.size.width;
        CGFloat heightHeaderScaleFactor = self.headerRect.size.height / self.headerView.drawingFrame.size.height;
        CGContextScaleCTM(context, headerScaleFactor, heightHeaderScaleFactor);
    }
    
    [self.headerView drawViewWithinPageRect:self.headerView.bounds];
    
    CGContextRestoreGState(context);
}

- (void)drawFooterForPageAtIndex:(NSInteger)pageIndex inRect:(CGRect)footerRect {
    [super drawFooterForPageAtIndex:pageIndex inRect:footerRect];
    
    if ((self.pagingMask & PDFPagingOptionFooter) == PDFPagingOptionFooter) {
        NSAssert([self.footerView respondsToSelector:@selector(updatePageNumber:totalPages:)], @"Footer view doesn't implement selector (updatePageNumber:totalPages:).");
        [self.footerView updatePageNumber:(pageIndex + 1) totalPages:self.numberOfPages];
    }
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSaveGState(context);
    UIBezierPath *footerPath = [UIBezierPath bezierPathWithRect:footerRect];
    CGContextAddPath(context, footerPath.CGPath);
    CGContextClip(context);
    CGContextTranslateCTM(context, footerRect.origin.x, footerRect.origin.y);
    if ([self isScalingFooter]) {
        CGFloat footerScaleFactor = self.printableRect.size.width / self.footerView.drawingFrame.size.width;
        CGFloat heightFooterScaleFactor = self.footerRect.size.height / self.footerView.drawingFrame.size.height;
        CGContextScaleCTM(context, footerScaleFactor, heightFooterScaleFactor);
    }
    
    [self.footerView drawViewWithinPageRect:self.footerView.bounds];
    
    CGContextRestoreGState(context);
}

- (void)drawContentForPageAtIndex:(NSInteger)pageIndex inRect:(CGRect)contentRect {
    [super drawContentForPageAtIndex:pageIndex inRect:contentRect];
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSaveGState(context);
    UIBezierPath *contentPath = [UIBezierPath bezierPathWithRect:contentRect];
    CGContextAddPath(context, contentPath.CGPath);
    CGContextClip(context);
    CGContextTranslateCTM(context, contentRect.origin.x, contentRect.origin.y);
    if ([self isScalingContent]) {
        CGContextScaleCTM(context, self.contentViewScale, self.contentViewScale);
    }
    
    [self.contentView drawViewWithinPageRect:[self scaledPageRectOffsetForIndex:pageIndex]];
    
    CGContextRestoreGState(context);
}

#pragma mark - Private

- (void)computeGeometry {
    NSAssert(CGRectGetWidth(self.contentRect) >= 10.f && CGRectGetHeight(self.contentRect) >= 10.f,
             @"Invalid paperInsets or paperSize. Content rectangle should have at least 10 points width and height");
    
    self.contentViewScale = self.contentRect.size.width / self.contentView.bounds.size.width;
    self.contentRectScale = self.contentView.bounds.size.width / self.contentRect.size.width;
}

- (void)layoutViews {
    PDFExporter_dispatch_sync_main_queue(^{
        [self.headerView layoutIfNeeded];
        [self.contentView layoutIfNeeded];
        [self.footerView layoutIfNeeded];
    });
}

- (void)preparePersistance {
    self.headerView.persistState = YES;
    self.contentView.persistState = YES;
    if ([self.contentView isKindOfClass:[UIScrollView class]]) {
        UIScrollView *scrollView = (UIScrollView *)self.contentView;
        scrollView.drawEntireContentSize = YES;
    }
    self.footerView.persistState = YES;
}

- (void)prepareContentForDrawing {
    [self.headerView prepareForDrawingWithPageSize:self.headerView.bounds.size];
    CGRect scaledPageRect = [self scaledPageRectOffsetForIndex:0];
    [self.contentView prepareForDrawingWithPageSize:scaledPageRect.size];
    [self.footerView prepareForDrawingWithPageSize:self.footerView.bounds.size];
    
    CGRect viewFrame = self.headerView.frame;
    viewFrame.origin = CGPointZero;
    self.headerView.frame = viewFrame;
    viewFrame = self.contentView.frame;
    viewFrame.origin = CGPointZero;
    self.contentView.frame = viewFrame;
    viewFrame = self.footerView.frame;
    viewFrame.origin = CGPointZero;
    self.footerView.frame = viewFrame;
    
    self.contentView.renderingDelegate = self;
    self.headerView.renderingDelegate = self;
    self.footerView.renderingDelegate = self;
}

- (void)cleanPersistance {
    self.headerView.persistState = NO;
    self.contentView.persistState = NO;
    if ([self.contentView isKindOfClass:[UIScrollView class]]) {
        UIScrollView *scrollView = (UIScrollView *)self.contentView;
        scrollView.drawEntireContentSize = NO;
    }
    self.footerView.persistState = NO;
}

- (void)cleanContentAfterDrawing {
    [self.headerView cleanAfterDrawing];
    [self.contentView cleanAfterDrawing];
    [self.footerView cleanAfterDrawing];
}

- (void)computeNumberOfPages {
    if ([self shouldSliceViews]) {
        NSUInteger renderingHeight = MAX(CGRectGetHeight(self.renderingRect), 1);
        self.internalNumberOfPages = ceilf(CGRectGetHeight(self.contentView.drawingFrame) / renderingHeight);
        self.internalNumberOfPages = MAX(self.internalNumberOfPages, 1);
    } else {
        self.pageRects = [NSMutableArray new];
        NSUInteger pageIndex = 0;
        CGRect pageOffset = [self scaledPageRectOffsetForIndex:pageIndex];
        CGPoint renderingOffset = CGPointZero;
        while (CGRectGetMaxY(pageOffset) < CGRectGetHeight(self.contentView.drawingFrame)) {
            renderingOffset = [self.contentView renderingOffsetForPageRect:pageOffset];
            [self createPageRectWithRect:pageOffset offset:renderingOffset];
            ++pageIndex;
            pageOffset = [self scaledPageRectOffsetForIndex:pageIndex];
            renderingOffset = CGPointZero;
        }
        [self createPageRectWithRect:pageOffset offset:renderingOffset];
        self.internalNumberOfPages = pageIndex + 1;
    }
}

- (void)createPageRectWithRect:(CGRect)rect offset:(CGPoint)offset {
    CGRect pageRect = CGRectResizeWithOffset(rect, CGPointMinus(offset));
    [self.pageRects addObject:[NSValue valueWithCGRect:pageRect]];
}

- (CGRect)scaledPageRectOffsetForIndex:(NSUInteger)index {
    if ([self.pageRects hasObjectAtIndex:index]) {
        return [self.pageRects[index] CGRectValue];
    }
    CGRect pageOffset = CGRectZero;
    if ([self isScalingContent]) {
        pageOffset.size = CGSizeCeil(CGSizeScaleByFactor(self.contentRect.size, self.contentRectScale));
    } else {
        pageOffset.size = self.contentRect.size;
    }
    pageOffset.origin.x = 0.f;
    if ([self.pageRects hasObjectAtIndex:index - 1]) {
        CGRect previousPageRect = [self.pageRects[index - 1] CGRectValue];
        pageOffset.origin.y = CGRectGetMaxY(previousPageRect);
    } else {
        pageOffset.origin.y = index * CGRectGetHeight(pageOffset);
    }
    return pageOffset;
}

#pragma mark - PDFRenderingDelegate

- (CGRect)view:(UIView *)view convertRectToRootView:(CGRect)rect {
    UIView *rootView = nil;
    if ([view isDescendantOfView:self.contentView]) {
        rootView = self.contentView;
    } else if ([view isDescendantOfView:self.headerView]) {
        rootView = self.headerView;
    } else if ([view isDescendantOfView:self.footerView]) {
        rootView = self.footerView;
    }
    return [view convertRect:rect toView:rootView];
}

- (BOOL)viewShouldSliceSubviews:(UIView *)view {
    return self.shouldSliceViews;
}

@end

@implementation NSArray (PDFPrintPageRendererPrivate)

- (BOOL)hasObjectAtIndex:(NSUInteger)index {
    return index < self.count;
}

@end
