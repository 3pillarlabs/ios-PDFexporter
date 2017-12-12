//
//  PDFRenderingDelegate.h
//  PDFExporter
//
//  Copyright © 2016 3Pillar Global. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/**
 The interface for customizing the rendering.
 */
@protocol PDFRenderingDelegate <NSObject>

/**
 Computes the rectangle area from view to root view.

 @param view the view for which the rect is needed.
 @param rect the rect which needs to be converted.
 @return the converted rectangle.
 */
- (CGRect)view:(UIView *)view convertRectToRootView:(CGRect)rect;
/**
 Asks the delegate if views should be sliced.

 @param view the view which should be sliced.
 @return YES if the views should be sliced, NO otherwise.
 */
- (BOOL)viewShouldSliceSubviews:(UIView *)view;

@end

NS_ASSUME_NONNULL_END
