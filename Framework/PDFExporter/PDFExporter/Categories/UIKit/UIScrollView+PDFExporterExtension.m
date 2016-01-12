//
//  UIScrollView+Extension.m
//  PDFExporter
//
//  Copyright © 2016 3Pillar Global. All rights reserved.
//

#import "UIScrollView+PDFExporterExtension.h"

@implementation UIScrollView (PDFExporterExtension)

- (CGRect)drawingFrame {
    CGRect drawingFrame = self.frame;
    drawingFrame.size.height = self.contentSize.height;
    return  drawingFrame;
}

@end
