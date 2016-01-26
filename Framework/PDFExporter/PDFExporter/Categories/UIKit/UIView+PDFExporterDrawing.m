//
//  UIView+Extension.m
//  PDFExporter
//
//  Copyright © 2015 3Pillar Global. All rights reserved.
//

#import "UIView+PDFExporterDrawing.h"
#import "UIView+PDFExporterViewSlicing.h"
#import "UIView+PDFExporterPageInformation.h"
#import "UIView+PDFExporterStatePersistance.h"

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
        CGRect intersection = [self subviewIntersection:subview pageRect:rect];
        if (CGRectIsNull(intersection)) { // do not draw invisible views
            continue;
        }
        if ([self.renderingDelegate viewCanRequestOffsetForDrawing:self] &&             // if can be drawn on the next page and
            CGRectGetHeight(subview.drawingFrame) < CGRectGetHeight(rect) &&            // view can fit in the page and
            ![self shouldSliceSubviews] &&                                              // it is allowed to move view and
            CGRectGetHeight(subview.drawingFrame) != CGRectGetHeight(intersection)) {   // view cannot be drawn on this page
            CGPoint offset = CGPointZero;
            offset.y = CGRectGetHeight(intersection);
            [self.renderingDelegate view:self requiresOffsetDrawing:offset];
            continue;
        }
        [subview drawViewWithinPageRect:rect];
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
