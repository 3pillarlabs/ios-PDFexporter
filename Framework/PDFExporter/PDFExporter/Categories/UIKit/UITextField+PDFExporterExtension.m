//
//  UITextField+Extension.m
//  PDFExporter
//
//  Copyright © 2015 3Pillar Global. All rights reserved.
//

#import "UITextField+PDFExporterExtension.h"

@implementation UITextField (PDFExporterExtension)

- (BOOL)handlesSubviewsDrawing {
    return YES;
}

- (void)drawBackgroundWithPath:(UIBezierPath *)path {
    // don't draw background, there is a subview as background
}

- (void)drawContentWithPath:(UIBezierPath *)path {
    [super drawContentWithPath:path];
    
    CGRect rect = path.bounds;
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSaveGState(context);
    CGContextTranslateCTM(context, rect.origin.x, rect.origin.y);
    
    for (UIView *view in self.subviews) {
        CGPoint viewOrigin = view.frame.origin;
        if (!CGPointEqualToPoint(viewOrigin, CGPointZero)) { // without context translation, subviews would draw at wrong origin
            CGContextSaveGState(context);
            CGContextTranslateCTM(context, viewOrigin.x, viewOrigin.y);
        }
        [view drawRect:view.frame];
        if (!CGPointEqualToPoint(viewOrigin, CGPointZero)) {
            CGContextRestoreGState(context);
        }
    }
    CGContextRestoreGState(context);
}

@end
