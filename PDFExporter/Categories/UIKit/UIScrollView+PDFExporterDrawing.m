//
//  UIScrollView+Extension.m
//  PDFExporter
//
//  Copyright © 2016 3Pillar Global. All rights reserved.
//

#import "UIScrollView+PDFExporterDrawing.h"
#import <objc/runtime.h>

static void * const kUIScrollViewDrawEntireContentSizeAssociatedStorageKey =
(void *)&kUIScrollViewDrawEntireContentSizeAssociatedStorageKey;

@implementation UIScrollView (PDFExporterDrawing)

- (CGRect)drawingFrame {
    CGRect drawingFrame = self.frame;
    if ([self isDrawingEntireContentSize]) {
        drawingFrame.size.height = fmaxf(self.contentSize.height, CGRectGetHeight(self.frame));
    }
    return drawingFrame;
}

- (BOOL)isDrawingEntireContentSize {
    NSNumber *drawEntireContentSizeNumber =
    objc_getAssociatedObject(self, kUIScrollViewDrawEntireContentSizeAssociatedStorageKey);
    return [drawEntireContentSizeNumber boolValue];
}

- (void)setDrawEntireContentSize:(BOOL)drawEntireContentSize {
    NSNumber *drawEntireContentSizeNumber = nil;
    if (drawEntireContentSize) {
        drawEntireContentSizeNumber = @(drawEntireContentSize);
    }
    objc_setAssociatedObject(self, kUIScrollViewDrawEntireContentSizeAssociatedStorageKey, drawEntireContentSizeNumber,
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end
