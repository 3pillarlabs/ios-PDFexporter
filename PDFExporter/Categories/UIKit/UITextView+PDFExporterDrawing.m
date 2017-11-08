//
//  UITextView+PDFExporterDrawing.m
//  PDFExporter
//
//  Copyright © 2016 3Pillar Global. All rights reserved.
//

#import "UITextView+PDFExporterDrawing.h"

@implementation UITextView (PDFExporterDrawing)

- (BOOL)canDrawSubview:(UIView *)subview intersection:(CGRect)intersection {
    return YES;
}

@end
