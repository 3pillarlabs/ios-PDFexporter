//
//  UIView+Extension.m
//  PDFExporter
//
//  Copyright © 2015 3Pillar Global. All rights reserved.
//

#import "UIView+Extension.h"
#import "UIView+SubclassExtension.h"

@implementation UIView (Extension)

- (BOOL)isDrawable {
    return !self.hidden && self.alpha > 0;
}

- (void)drawViewWithRect:(CGRect)rect {
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:rect cornerRadius:self.layer.cornerRadius];
    
    [self drawBackgroundWithPath:path];
    [self drawContentWithPath:path];
    if (self.layer.borderWidth != 0) {
        [self drawBorderWithPath:path];
    }
}

@end
