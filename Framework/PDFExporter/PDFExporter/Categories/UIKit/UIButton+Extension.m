//
//  UIButton+Extension.m
//  PDFExporter
//
//  Copyright © 2015 3Pillar Global. All rights reserved.
//

#import "UIButton+Extension.h"
#import "UIView+SubclassExtension.h"
#import "UILabel+Extension.h"

@implementation UIButton (Extension)

- (void)drawContentWithPath:(UIBezierPath *)path {
    [super drawContentWithPath:path];
    
    [self drawTextInsideRect:path.bounds];
}

- (void)drawTextInsideRect:(CGRect)rect {
    [self.titleLabel drawViewWithRect:CGRectOffset(self.titleLabel.frame, rect.origin.x, rect.origin.y)];
}

@end
