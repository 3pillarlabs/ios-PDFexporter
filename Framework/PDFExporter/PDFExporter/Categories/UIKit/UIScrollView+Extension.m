//
//  UIScrollView+Extension.m
//  PDFExporter
//
//  Copyright © 2016 3Pillar Global. All rights reserved.
//

#import "UIScrollView+Extension.h"

@implementation UIScrollView (Extension)

- (CGRect)drawingFrame {
    CGRect drawingFrame = CGRectZero;
    drawingFrame.size.width = CGRectGetWidth(self.bounds);
    drawingFrame.size.height = self.contentSize.height;
    return  drawingFrame;
}

@end
