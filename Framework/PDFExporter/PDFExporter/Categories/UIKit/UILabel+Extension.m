//
//  UILabel+Extension.m
//  PDFExporter
//
//  Copyright © 2015 3Pillar Global. All rights reserved.
//

#import "UILabel+Extension.h"
#import "UIView+SubclassExtension.h"

@implementation UILabel (Extension)

- (void)drawBackgroundWithPath:(UIBezierPath *)path {
    // the layer will draw the background as well
}

- (void)drawContentWithPath:(UIBezierPath *)path {
    [super drawContentWithPath:path];
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSaveGState(context);
    CGPoint origin = path.bounds.origin;
    CGContextTranslateCTM(context, origin.x, origin.y);
    [self drawLayer:self.layer inContext:context];
    CGContextRestoreGState(context);
}

@end
