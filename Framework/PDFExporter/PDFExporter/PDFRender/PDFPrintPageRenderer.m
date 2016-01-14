//
//  PDFPrintPageRenderer.m
//  PDFExporter
//
//  Copyright © 2015 3Pillar Global. All rights reserved.
//

#import "PDFPrintPageRenderer.h"
#import "PDFPaperSizes.h"
#import "UIView+PDFExporterDrawing.h"
#import "UIView+PDFExporterStatePersistance.h"
#import "UIScrollView+PDFExporterDrawing.h"
#import "CGGeometry+Additions.h"

static UIEdgeInsets const kDefaultPaperInsets = {30.f, 30.f, 30.f, 30.f};

@interface PDFPrintPageRenderer ()

@property (nonatomic) CGFloat contentViewScale;
@property (nonatomic) CGFloat contentRectScale;

@property (nonatomic) CGRect headerRect;
@property (nonatomic) CGRect footerRect;
@property (nonatomic, readwrite) CGRect contentRect;

@end

@implementation PDFPrintPageRenderer

- (instancetype)init {
    if (self = [super init]) {
        self.paperSize = PDFPaperSizeUSLetter;
        self.paperInset = kDefaultPaperInsets;
        self.pagingMask = PDFPagingOptionNone;
    }
    
    return self;
}

- (void)drawPages:(CGRect)inBounds {
    [self calculateGeometry];
    [self prepareContentForDrawing];
	for (NSInteger pageNumber = 0; pageNumber < self.numberOfPages; pageNumber++) {
		UIGraphicsBeginPDFPage();
		[self drawPageAtIndex:pageNumber inRect:self.printableRect];
	}
    [self cleanContentAfterDrawing];
}

- (NSData *)drawPagesToPDFData {
	NSMutableData *pdfData = [NSMutableData data];
	UIGraphicsBeginPDFContextToData(pdfData, self.paperRect, nil);
	CGRect bounds = UIGraphicsGetPDFContextBounds();
	[self drawPages:bounds];
	UIGraphicsEndPDFContext();
	return pdfData.copy;
}

#pragma mark - Getters and Setters

- (CGRect)paperRect {
    CGRect paperRect = CGRectZero;
    paperRect.size = self.paperSize;
    return paperRect;
}

- (CGRect)printableRect {
    return UIEdgeInsetsInsetRect(self.paperRect, self.paperInset);
}

- (NSInteger)numberOfPages {
    CGRect scaledContentRect = CGRectScaleByFactor(self.contentRect, self.contentRectScale);
    return ceilf(CGRectGetHeight(self.contentView.drawingFrame) / CGRectGetHeight(scaledContentRect));
}

- (CGFloat)headerHeight {
    if (self.headerView) {
        return [self headerFrame].size.height;
    } else {
        return 0.f;
    }
}

- (void)setHeaderHeight:(CGFloat)headerHeight {
    // Do nothing here.
}

- (CGRect)headerFrame {
    CGFloat headerScaleFactor = self.printableRect.size.width / self.headerView.drawingFrame.size.width;
    return CGRectScaleByFactor(self.headerView.drawingFrame, headerScaleFactor);
}

- (CGFloat)footerHeight {
    if (self.footerView) {
        return [self footerFrame].size.height;
    } else {
        return 0.f;
    }
}

- (void)setFooterHeight:(CGFloat)footerHeight {
    // Do nothing.
}

- (CGRect)footerFrame {
    CGFloat footerScaleFactor = self.printableRect.size.width / self.footerView.drawingFrame.size.width;
    return CGRectScaleByFactor(self.footerView.drawingFrame, footerScaleFactor);
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
    
    CGFloat headerScaleFactor = self.printableRect.size.width / self.headerView.drawingFrame.size.width;
    CGFloat heightHeaderScaleFactor = self.headerRect.size.height / self.headerView.drawingFrame.size.height;
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSaveGState(context);
    CGContextTranslateCTM(context, headerRect.origin.x, headerRect.origin.y);
    CGContextScaleCTM(context, headerScaleFactor, heightHeaderScaleFactor);
    
    [self.headerView drawViewWithinPageRect:self.headerView.bounds];
    
    CGContextRestoreGState(context);
}

- (void)drawFooterForPageAtIndex:(NSInteger)pageIndex inRect:(CGRect)footerRect {
    [super drawFooterForPageAtIndex:pageIndex inRect:footerRect];
    
    if ((self.pagingMask & PDFPagingOptionFooter) == PDFPagingOptionFooter) {
        NSAssert([self.footerView respondsToSelector:@selector(updatePageNumber:totalPages:)], @"Footer view doesn't implement selector (updatePageNumber:totalPages:).");
        [self.footerView updatePageNumber:(pageIndex + 1) totalPages:self.numberOfPages];
    }
    
    CGFloat footerScaleFactor = self.printableRect.size.width / self.footerView.drawingFrame.size.width;
    CGFloat heightFooterScaleFactor = self.footerRect.size.height / self.footerView.drawingFrame.size.height;
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSaveGState(context);
    CGContextTranslateCTM(context, footerRect.origin.x, footerRect.origin.y);
    CGContextScaleCTM(context, footerScaleFactor, heightFooterScaleFactor);
    
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
    CGContextScaleCTM(context, self.contentViewScale, self.contentViewScale);
    
    CGRect scaledPageRect = [self scaledPageRectOffsetForIndex:pageIndex];
    [self.contentView drawViewWithinPageRect:scaledPageRect];
    
    CGContextRestoreGState(context);
}

- (CGRect)scaledPageRectOffsetForIndex:(NSUInteger)index {
    CGFloat pageHeightOffset = index * CGRectGetHeight(self.contentRect);
    CGRect pageOffset = self.contentRect;
    pageOffset.origin.x = 0.f;
    pageOffset.origin.y = pageHeightOffset;
    CGRect scaledPageOffset = CGRectScaleByFactor(pageOffset, self.contentRectScale);
    scaledPageOffset.origin.y = index * CGRectGetHeight(scaledPageOffset);
    return scaledPageOffset;
}

#pragma mark - Private

- (void)calculateGeometry {
    CGRect headerRect = self.printableRect;
    headerRect.size.height = self.headerHeight;
    self.headerRect = headerRect;
    self.footerRect = CGRectMake(CGRectGetMinX(self.printableRect),
                                 CGRectGetMaxY(self.printableRect) - self.footerHeight,
                                 CGRectGetWidth(self.printableRect),
                                 self.footerHeight);
    self.contentRect = CGRectMake(CGRectGetMinX(self.printableRect),
                                  CGRectGetMaxY(self.headerRect),
                                  CGRectGetWidth(self.printableRect),
                                  CGRectGetMinY(self.footerRect) - CGRectGetMaxY(self.headerRect));
    NSAssert(CGRectGetWidth(self.contentRect) >= 10.f && CGRectGetHeight(self.contentRect) >= 10.f,
             @"Invalid paperInsets or paperSize. Content rectangle should have at least 10 points width and height");
    
    self.contentViewScale = self.contentRect.size.width / self.contentView.bounds.size.width;
    self.contentRectScale = self.contentView.bounds.size.width / self.contentRect.size.width;
    
    
}

- (void)prepareContentForDrawing {
    self.headerView.persistState = YES;
    self.contentView.persistState = YES;
    if ([self.contentView isKindOfClass:[UIScrollView class]]) {
        UIScrollView *scrollView = (UIScrollView *)self.contentView;
        scrollView.drawEntireContentSize = YES;
    }
    self.footerView.persistState = YES;
    
    [self.headerView prepareForDrawingWithPageSize:self.headerView.bounds.size];
    CGRect scaledPageRect = [self scaledPageRectOffsetForIndex:0];
    [self.contentView prepareForDrawingWithPageSize:scaledPageRect.size];
    [self.footerView prepareForDrawingWithPageSize:self.footerView.bounds.size];
    
    [self.headerView layoutIfNeeded];
    [self.contentView layoutIfNeeded];
    [self.footerView layoutIfNeeded];
    CGRect viewFrame = self.headerView.frame;
    viewFrame.origin = CGPointZero;
    self.headerView.frame = viewFrame;
    viewFrame = self.contentView.frame;
    viewFrame.origin = CGPointZero;
    self.contentView.frame = viewFrame;
    viewFrame = self.footerView.frame;
    viewFrame.origin = CGPointZero;
    self.footerView.frame = viewFrame;
}

- (void)cleanContentAfterDrawing {
    [self.headerView cleanAfterDrawing];
    [self.contentView cleanAfterDrawing];
    [self.footerView cleanAfterDrawing];
    
    self.headerView.persistState = NO;
    self.contentView.persistState = NO;
    if ([self.contentView isKindOfClass:[UIScrollView class]]) {
        UIScrollView *scrollView = (UIScrollView *)self.contentView;
        scrollView.drawEntireContentSize = NO;
    }
    self.footerView.persistState = NO;
}

@end
