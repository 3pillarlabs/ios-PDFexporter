//
//  UIView+Extension.m
//  PDFExporter
//
//  Copyright © 2015 3Pillar Global. All rights reserved.
//

#import "UIView+PDFExporterDrawing.h"
#import <objc/runtime.h>
#import "UIView+PDFExporterStatePersistance.h"

static void * const kUIViewSliceSubviewsAssociatedStorageKey = (void *)&kUIViewSliceSubviewsAssociatedStorageKey;
static void * const kUIViewRenderingDelegateAssociatedStorageKey = (void *)&kUIViewRenderingDelegateAssociatedStorageKey;

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

- (BOOL)shouldSliceSubviews {
    NSNumber *sliceSubviewsNumber = objc_getAssociatedObject(self, kUIViewSliceSubviewsAssociatedStorageKey);
    return [sliceSubviewsNumber boolValue];
}

- (void)setSliceSubviews:(BOOL)sliceSubviews {
    NSNumber *sliceSubviewsNumber = nil;
    if (sliceSubviews) {
        sliceSubviewsNumber = @(sliceSubviews);
    }
    objc_setAssociatedObject(self, kUIViewSliceSubviewsAssociatedStorageKey, sliceSubviewsNumber, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (id<PDFRenderingDelegate>)renderingDelegate {
    id<PDFRenderingDelegate> renderingDelegate = objc_getAssociatedObject(self, kUIViewRenderingDelegateAssociatedStorageKey);
    return renderingDelegate ? : [self.superview renderingDelegate];
}

- (void)setRenderingDelegate:(id<PDFRenderingDelegate>)renderingDelegate {
    if (self.renderingDelegate != renderingDelegate) {
        objc_setAssociatedObject(self, kUIViewRenderingDelegateAssociatedStorageKey, renderingDelegate, OBJC_ASSOCIATION_ASSIGN);
    }
}

#pragma mark - Drawing Setup

- (void)prepareForDrawingWithPageSize:(CGSize)size {
    [self saveState];
    for (UIView *view in self.subviews) {
        [view prepareForDrawingWithPageSize:size];
    }
}

- (void)cleanAfterDrawing {
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
    rect.origin = CGPointZero; // context was translated, there is no need for origin
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
    for (UIView *subview in self.subviews) {
        if (![subview isDrawable]) {
            continue;
        }
        CGRect subviewRectInPage = [self.renderingDelegate view:self convertRectToContentView:subview.drawingFrame];//[self subviewRect:subview]];// subview.drawingFrame];
        CGRect intersection = CGRectIntersection(subviewRectInPage, rect);// [self subviewIntersection:subview rect:rect];
        if (CGRectIsNull(intersection)) {
            continue;
        }
        if ([self.renderingDelegate viewCanRequestOffsetForDrawing:self] &&
            CGRectGetHeight(subviewRectInPage) < CGRectGetHeight(rect) &&
            ![self shouldSliceSubviews] &&
            CGRectGetHeight(subviewRectInPage) != CGRectGetHeight(intersection)) {
            CGPoint offset = CGPointZero;
            offset.y = CGRectGetHeight(rect) - CGRectGetMinY(subviewRectInPage);// CGRectGetHeight(subviewRectInPage);
            [self.renderingDelegate view:self requiresOffsetDrawing:offset];
            continue;
        }
#warning test if CGRectIntersectsRect still allows subview to be drawn
        if (CGRectIntersectsRect(subviewRectInPage, rect)) {
//            CGRect pageRect = [self convertRect:rect toView:subview];
            [subview drawViewWithinPageRect:rect];
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

#pragma mark - PDFExpoterPageInformation

- (CGPoint)renderingOffsetForPageRect:(CGRect)rect {
    CGPoint renderingOffset = CGPointZero;
    for (UIView *subview in self.subviews) {
        if ([subview isDrawable]) {
            CGRect intersection = [self subviewIntersection:subview rect:rect];
            if (CGRectIsNull(intersection) ||
                CGRectGetHeight(intersection) == CGRectGetHeight([self subviewRect:subview])) { // skip subviews that are not visible or it is possible to draw them entirely
                continue;
            }
            CGRect pageRect = [self convertRect:rect toView:subview];
            CGPoint subviewRenderingOffset = [subview renderingOffsetForPageRect:pageRect];
            CGFloat subviewYOffset = (subviewRenderingOffset.y) ? fminf(CGRectGetHeight(intersection), subviewRenderingOffset.y) : CGRectGetHeight(intersection);
            if (CGRectGetHeight(rect) == subviewYOffset) { // views that has equal or greater height than the page will not be moved to the next page
                continue;
            }
            renderingOffset.y = fmaxf(renderingOffset.y, subviewYOffset);
        }
    }
    return renderingOffset;
}

- (CGRect)subviewRect:(UIView *)subview {
    return subview.drawingFrame;
}

- (CGRect)subviewIntersection:(UIView *)subview rect:(CGRect)rect {
    CGRect subviewRect = [self subviewRect:subview];
    return CGRectIntersection(subviewRect, rect);
}

@end
