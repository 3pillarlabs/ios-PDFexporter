//
//  PDFRenderingDelegate.h
//  PDFExporter
//
//  Copyright © 2016 3Pillar Global. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol PDFRenderingDelegate <NSObject>

//- (void)view:(UIView *)view requiresOffsetDrawing:(CGPoint)offset;
- (CGRect)view:(UIView *)view convertRectToContentView:(CGRect)rect;
//- (BOOL)viewCanRequestOffsetForDrawing:(UIView *)view;
- (BOOL)viewShouldSliceSubviews:(UIView *)view;

@end

NS_ASSUME_NONNULL_END
