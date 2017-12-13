//
//  UIScrollView+PDFExporterPageInformation.m
//  PDFExporter
//
//  Created by David Livadaru on 13/12/2017.
//  Copyright © 2017 3Pillar Global. All rights reserved.
//

#import "UIScrollView+PDFExporterPageInformation.h"
#import "UIView+PDFExporterPageInformation.h"

@implementation UIScrollView (PDFExporterPageInformation)

- (CGRect)subviewRect:(UIView *)subview layoutPageRect:(CGRect)rect {
    if ([subview isKindOfClass:[UITableViewCell class]]) {  // UITableView's cells are wrapped inside a UIScrollView
        return [self.superview subviewRect:subview layoutPageRect:rect];
    } else {
        return [super subviewRect:subview layoutPageRect:rect];
    }
}

@end
