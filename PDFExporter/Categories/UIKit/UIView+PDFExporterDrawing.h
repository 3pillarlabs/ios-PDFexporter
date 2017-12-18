//
//  UIView+Extension.h
//  PDFExporter
//
//  Copyright © 2015 3Pillar Global. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (PDFExporterDrawing)

/**
 A view is drawable if is not hidden and opaque (alpha is greater than 0.0).
 */
@property (nonatomic, readonly, getter=isDrawable) BOOL drawable;
/**
 Configuration point which provide control over subviews' drawing.
 Default value is YES.
 */
@property (nonatomic, readonly, getter=shouldDrawSubviews) BOOL drawSubviews;
/**
 The frame which can be used for drawing the view in the pdf.
 */
@property (nonatomic, readonly) CGRect drawingFrame;

/**
 Prepare the view for drawing.
 */
- (void)prepareForDrawing NS_REQUIRES_SUPER;
/**
 Cleans the preparation previously performed in prepareForDrawing.
 */
- (void)cleanAfterDrawing NS_REQUIRES_SUPER;

/**
 Draws the view's within the rect of current page.

 @param rect The rect of the current page.
 */
- (void)drawViewWithinPageRect:(CGRect)rect;
/**
 Draws the view's background using the provided path.

 @param path The path which is computed from bounds and layer's corner radius.
 */
- (void)drawBackgroundWithPath:(UIBezierPath *)path;
/**
 Draws the view's content using the provided path.

 @param path The path which is computed from bounds and layer's corner radius.
 */
- (void)drawContentWithPath:(UIBezierPath *)path;
/**
 Draws the subivews,

 @param path The path which is computed from bounds and layer's corner radius.
 @param rect The rect of the current page.
 */
- (void)drawSubviewsWithPath:(UIBezierPath *)path withinPageRect:(CGRect)rect;
/**
 Draws the view's border using the provided path.

 @param path The path which is computed from bounds and layer's corner radius.
 */
- (void)drawBorderWithPath:(UIBezierPath *)path;

/**
 A subview can be rendered if is not sliced.
 A view is not sliced if the intersection's height is the same as drawing rect's height.

 @param subview The subview to render.
 @param intersection The intersection of subview's drawing frame and page rect.
 @return YES if subviews can be rendered, NO otherwise.
 */
- (BOOL)canDrawSubview:(UIView *)subview intersection:(CGRect)intersection;

/**
 The rectangle used for drawing the subview.

 @param subview The subview to render.
 @param rect The rect of the current page.
 @return The drawing rect.
 */
- (CGRect)subviewRect:(UIView *)subview drawingPageRect:(CGRect)rect;
/**
 Compute intersection of drawing frame and the provided page rect.

 @param rect The page rect.
 @return The intersection rect.
 */
- (CGRect)intersectionRectForDrawingPageRect:(CGRect)rect;
/**
 Computes the intersection between drawing rect and the bounds for page's rect.

 @param subview The subview to render.
 @param rect The rect of the current page.
 @return The intersection.
 */
- (CGRect)subviewIntersection:(UIView *)subview drawingPageRect:(CGRect)rect;

@end

NS_ASSUME_NONNULL_END
