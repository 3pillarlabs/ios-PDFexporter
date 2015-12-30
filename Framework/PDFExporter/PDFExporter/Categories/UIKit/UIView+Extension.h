//
//  UIView+Extension.h
//  PDFExporter
//
//  Copyright © 2015 3Pillar Global. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Extension)

@property (nonatomic, readonly, getter=isDrawable) BOOL drawable;

- (void)drawViewWithRect:(CGRect)rect;

@end
