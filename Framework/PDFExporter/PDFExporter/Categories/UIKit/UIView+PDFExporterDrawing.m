//
//  UIView+Extension.m
//  PDFExporter
//
//  Copyright © 2015 3Pillar Global. All rights reserved.
//

#import "UIView+PDFExporterDrawing.h"
#import <objc/runtime.h>
#import "UIView+PDFExporterStatePersistance.h"

static void * const kUIViewPageViewsAssociatedStorageKey = (void *)&kUIViewPageViewsAssociatedStorageKey;

@interface UIView (PDFExporterMetadata)

@property (nonatomic) NSMutableDictionary *pageViews;

- (NSMutableArray *)subviewsForPageRect:(CGRect)rect;
- (void)createMetadataWithPageSize:(CGSize)size;
- (void)removeMetadata;

@end

@implementation UIView (PDFExporterDrawing)

- (BOOL)isDrawable {
    return !self.hidden && self.alpha > 0;
}

- (BOOL)shouldDrawSubviews {
    return YES;
}

- (CGRect)drawingFrame {
    return self.frame;
}

#pragma mark - Drawing Setup

- (void)prepareForDrawingWithPageSize:(CGSize)size {
    [self createMetadataWithPageSize:size];
    [self saveState];
    for (UIView *view in self.subviews) {
        [view prepareForDrawingWithPageSize:size];
    }
}

- (void)cleanAfterDrawing {
    [self removeMetadata];
    [self restoreState];
    for (UIView *view in self.subviews) {
        [view cleanAfterDrawing];
    }
}

#pragma mark - Drawing

- (void)drawViewWithinPageRect:(CGRect)rect {
    CGRect drawingFrame = self.drawingFrame;
    drawingFrame.origin.y -= CGRectGetMinY(rect); // draw only what is left
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:drawingFrame cornerRadius:self.layer.cornerRadius];
    
    [self drawBackgroundWithPath:path];
    [self drawContentWithPath:path];
    [self drawSubviewsWithPath:path withinPageRect:rect];
    if (self.layer.borderWidth != 0) {
        [self drawBorderWithPath:path];
    }
}

- (void)drawBackgroundWithPath:(UIBezierPath *)path {
    if (!self.backgroundColor || self.backgroundColor == [UIColor clearColor]) {
        return;
    }
    [self.backgroundColor setFill];
    [path fill];
}

- (void)drawContentWithPath:(UIBezierPath *)path {
    CGRect rect = path.bounds;
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSaveGState(context);
    CGContextTranslateCTM(context, rect.origin.x, rect.origin.y);
    [self drawRect:rect];
    CGContextRestoreGState(context);
}

- (void)drawSubviewsWithPath:(UIBezierPath *)path withinPageRect:(CGRect)rect {
    if (![self shouldDrawSubviews]) {
        return;
    }
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSaveGState(context);
    if (self.clipsToBounds) {
        CGContextAddPath(context, path.CGPath);
        CGContextClip(context);
    }
    CGContextTranslateCTM(context, self.drawingFrame.origin.x, self.drawingFrame.origin.y);
    NSArray *subviews = [self subviewsForPageRect:rect] ? : self.subviews;
    for (UIView *view in subviews) {
        if ([view isDrawable]) {
            [view drawViewWithinPageRect:rect];
        }
    }
    CGContextRestoreGState(context);
}

- (void)drawBorderWithPath:(UIBezierPath *)path {
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSaveGState(context);
    CGContextAddPath(context, path.CGPath);
    CGContextClip(context);
    CAShapeLayer *shapeLayer = [[CAShapeLayer alloc] init];
    shapeLayer.path = path.CGPath;
    shapeLayer.fillColor = [UIColor clearColor].CGColor;
    shapeLayer.strokeColor = self.layer.borderColor;
    shapeLayer.lineWidth = self.layer.borderWidth * 2; // the stroke is draw half inside, half outside
    [shapeLayer renderInContext:context];
    CGContextRestoreGState(context);
}

@end

@implementation UIView (PDFExporterMetadata)

- (NSMutableDictionary *)pageViews {
    NSMutableDictionary *_pageViews = objc_getAssociatedObject(self, kUIViewPageViewsAssociatedStorageKey);
    if (!_pageViews) {
        _pageViews = [NSMutableDictionary new];
        self.pageViews = _pageViews;
    }
    return _pageViews;
}

- (void)setPageViews:(NSMutableDictionary *)pageViews {
    objc_setAssociatedObject(self, kUIViewPageViewsAssociatedStorageKey, pageViews, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

#pragma mark - Interface

- (NSMutableArray *)subviewsForPageRect:(CGRect)rect {
    NSUInteger page = floorf(CGRectGetMinY(rect) / CGRectGetMaxY(rect));
    return self.pageViews[@(page)];
}

- (void)createMetadataWithPageSize:(CGSize)size {
    for (UIView *view in self.subviews) {
        NSUInteger firstPage = floorf(CGRectGetMinY(view.drawingFrame) / size.height);
        NSUInteger lastPage = floorf(CGRectGetMaxY(view.drawingFrame) / size.height);
        for (NSUInteger pageIndex = firstPage; pageIndex <= lastPage; ++pageIndex) {
            NSMutableArray *pageSubviews = self.pageViews[@(pageIndex)];
            if (!pageSubviews) {
                pageSubviews = [NSMutableArray new];
                self.pageViews[@(pageIndex)] = pageSubviews;
            }
            [pageSubviews addObject:view];
        }
    }
}

- (void)removeMetadata {
    self.pageViews = nil;
}

@end
