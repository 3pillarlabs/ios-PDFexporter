//
//  PDFRenderingDelegate.h
//  PDFExporter
//
//  Copyright © 2016 3Pillar Global. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol PDFRenderingDelegate <NSObject>

- (CGRect)view:(UIView *)view convertRectToRootView:(CGRect)rect;
- (BOOL)viewShouldSliceSubviews:(UIView *)view;

@end

NS_ASSUME_NONNULL_END
