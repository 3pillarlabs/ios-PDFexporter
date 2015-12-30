//
//  UIView+PrivateExtension.m
//  PDFExporter
//
//  Copyright © 2015 3Pillar Global. All rights reserved.
//

#import "UIView+SubclassExtension.h"

@implementation UIView (SubclassExtension)

- (void)drawBackgroundWithPath:(UIBezierPath *)path {
    if (!self.backgroundColor || self.backgroundColor == [UIColor clearColor]) {
        return;
    }
    [self.backgroundColor setFill];
    [path fill];
}

- (void)drawContentWithPath:(UIBezierPath *)path {
    // UIView doesn't have content to draw.
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
