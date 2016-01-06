//
//  PDFPrintPageRenderer.m
//  PDFExporter
//
//  Copyright © 2015 3Pillar Global. All rights reserved.
//

#import "PDFPrintPageRenderer.h"
#import "PDFPaperSizes.h"
#import "UIView+Extension.h"
#import "UIView+StatePersistance.h"
#import "CGGeometry+Additions.h"

@interface UIView (PDFPrintPageRendererPrivate)

- (CGRect)convertRectToRootView:(UIView *)rootView;

@end

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
        self.paperInsets = kDefaultPaperInsets;
    }
    
    return self;
}

- (void)drawPages:(CGRect)inBounds {
    if ([self.contentView isKindOfClass:[UITableView class]]) {
        UITableView *tableView = (UITableView *)self.contentView;
        [tableView saveState];
    }
    
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
    NSAssert(CGRectGetWidth(self.contentRect) >= 10.f && CGRectGetHeight(self.contentRect) >= 10.f, @"Invalid paperInsets or paperSize. Content rectangle should have at least 10 points width and height");
    
    self.contentViewScale = self.contentRect.size.width / self.contentView.bounds.size.width;
    self.contentRectScale = self.contentView.bounds.size.width / self.contentRect.size.width;

	for (NSInteger pageNumber = 0; pageNumber < self.numberOfPages; pageNumber++) {
		UIGraphicsBeginPDFPage();
		[self drawPageAtIndex:pageNumber inRect:self.printableRect];
	}
    
    if ([self.contentView isKindOfClass:[UITableView class]]) {
        UITableView *tableView = (UITableView *)self.contentView;
        [tableView restoreState];
    }
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
    return UIEdgeInsetsInsetRect(self.paperRect, self.paperInsets);
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
    
    NSArray *printableViews = [self viewHierarchy:self.headerView rootView:self.headerView containedInRect:self.headerView.bounds]; // get all the views that are contained by the header
    
    CGFloat headerScaleFactor = self.printableRect.size.width / self.headerView.drawingFrame.size.width;
    CGFloat heightHeaderScaleFactor = self.headerRect.size.height / self.headerView.drawingFrame.size.height;
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSaveGState(context);
    CGContextTranslateCTM(context, headerRect.origin.x, headerRect.origin.y);
    CGContextScaleCTM(context, headerScaleFactor, heightHeaderScaleFactor);
    
    for (UIView *view in printableViews) {
        // convert view frame to the content view coordinates and offset based on header height and the page that's being drawn
        CGRect drawRect = [view convertRectToRootView:self.headerView];
        [view drawViewWithPageRect:drawRect];
    }
    
    CGContextRestoreGState(context);
}

- (void)drawFooterForPageAtIndex:(NSInteger)pageIndex inRect:(CGRect)footerRect {
    [super drawFooterForPageAtIndex:pageIndex inRect:footerRect];
    
    [self.footerView updatePageNumber:(pageIndex + 1) totalPages:self.numberOfPages];
    NSArray *printableViews = [self viewHierarchy:self.footerView rootView:self.footerView containedInRect:self.footerView.bounds]; // get all the views that are contained by the footer
    
    CGFloat footerScaleFactor = self.printableRect.size.width / self.footerView.drawingFrame.size.width;
    CGFloat heightFooterScaleFactor = self.footerRect.size.height / self.footerView.drawingFrame.size.height;
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSaveGState(context);
    CGContextTranslateCTM(context, footerRect.origin.x, footerRect.origin.y);
    CGContextScaleCTM(context, footerScaleFactor, heightFooterScaleFactor);
    
    for (UIView *view in printableViews) {
        // convert view frame to the content view coordinates and offset based on header height and the page that's being drawn
        CGRect drawRect = [view convertRectToRootView:self.footerView];
        [view drawViewWithPageRect:drawRect];
    }
    
    CGContextRestoreGState(context);
}

- (void)drawContentForPageAtIndex:(NSInteger)pageIndex inRect:(CGRect)contentRect {
    [super drawContentForPageAtIndex:pageIndex inRect:contentRect];
    
    CGFloat pageHeightOffset = pageIndex * CGRectGetHeight(self.contentRect);
    CGRect pageOffset = contentRect;
    pageOffset.origin.x = 0.f;
    pageOffset.origin.y = pageHeightOffset;
    CGRect scaledPageOffset = CGRectScaleByFactor(pageOffset, self.contentRectScale);
    scaledPageOffset.origin.y = pageIndex * CGRectGetHeight(scaledPageOffset);
    
    NSArray *printableViews = [self viewHierarchy:self.contentView rootView:self.contentView containedInRect:scaledPageOffset]; // get all the views that are contained by the page
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSaveGState(context);
    UIBezierPath *contentPath = [UIBezierPath bezierPathWithRect:contentRect];
    CGContextAddPath(context, contentPath.CGPath);
    CGContextClip(context);
    CGContextTranslateCTM(context, contentRect.origin.x, contentRect.origin.y);
    CGContextScaleCTM(context, self.contentViewScale, self.contentViewScale);
    
    for (UIView *view in printableViews) {
        // convert view frame to the content view coordinates and offset based on header height and the page that's being drawn
        CGRect drawRect = [view convertRectToRootView:self.contentView];
        drawRect = [self drawRectWithOriginalRect:drawRect pageRect:scaledPageOffset];
        [view drawViewWithPageRect:drawRect];
    }
    
    CGContextRestoreGState(context);
}

#pragma mark - Private

- (NSArray *)viewHierarchy:(UIView *)view rootView:(UIView *)rootView containedInRect:(CGRect)rect {
    NSMutableArray *views = [NSMutableArray array];
    
    CGRect translatedViewFrame = [view convertRectToRootView:rootView];
    if ([view isDrawable] && CGRectIntersectsRect(translatedViewFrame, rect)) {
        [views addObject:view];
        
        if ([view isKindOfClass:[UITextField class]]) { // UITextField will handle its subviews
            return views;
        }
        
        for (UIView *subView in [view drawingSubviewsForRect:[self.contentView convertRect:rect toView:view]]) {
            [views addObjectsFromArray:[self viewHierarchy:subView rootView:rootView containedInRect:rect]];
        }
    }
    
    return views;
}

- (CGRect)drawRectWithOriginalRect:(CGRect)originalRect pageRect:(CGRect)pageRect {
    if (CGRectGetMinY(pageRect) == 0) { // if it is first page
        return originalRect;            // don't modify it
    } else {
        CGFloat drawHeight = CGRectGetMinY(originalRect) - CGRectGetMinY(pageRect);
        if (drawHeight < 0) {
            originalRect.origin.y = drawHeight; // change y in order to draw what's left
        } else {
            originalRect.origin.y -= CGRectGetMinY(pageRect); // normalize rect
        }
        return originalRect;
    }
}

@end

@implementation UIView (PDFPrintPageRendererPrivate)

- (CGRect)convertRectToRootView:(UIView *)rootView {
    if (self == rootView) {
        return self.drawingFrame;
    } else {
        return [self.superview convertRect:self.drawingFrame toView:rootView];
    }
}

@end
