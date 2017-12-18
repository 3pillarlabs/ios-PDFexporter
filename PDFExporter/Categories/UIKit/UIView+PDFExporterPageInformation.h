//
//  UIView+PDFExporterPageInformation.h
//  PDFExporter
//
//  Copyright © 2016 3Pillar Global. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (PDFExporterPageInformation)

/**
 Property which provides control over rendering offset.
 If set to NO, the view will compute the rendering offset based on the information it has.

 Default value for UIView is YES. NO is default for following view types: UIButton, UIControl, UIImageView, UIInputView,
 UITextView, UILabel, UICollectionReuseableView, UITableViewCell, UITableViewHeaderFooterView.
 */
@property (nonatomic, readonly) BOOL askSubviewsRenderingOffset;

/**
 Tells if a subview should be rendered.

 @param subview The subview which to render.
 @param intersection The intersection of subview's drawing frame and page rect.
 @return YES if subview should be rendered, NO otherwise.
 */
- (BOOL)canLayoutSubview:(UIView *)subview intersection:(CGRect)intersection;
/**
 Tells if a subview should be rendered. The check is called after asking the rendering offset from subview.

 @param subview The subview which to render.
 @param intersection The intersection of subview's drawing frame and page rect.
 @return YES if subview should be rendered, NO otherwise.
 */
- (BOOL)shouldConsiderLayoutSubview:(UIView *)subview intersection:(CGRect)intersection;

/**
 Computes the offset which is needed in order to not split views.

 @param rect The rect of the current page. The rect is contained in renderer's content view bounds.
 @return The offset.
 */
- (CGPoint)renderingOffsetForPageRect:(CGRect)rect;

/**
 Computes the frame of the subview in the page rect.

 @param subview The subview for which the frame of computed.
 @param rect The rect of the current page. The rect is contained in renderer's content view bounds.
 @return The frame.
 */
- (CGRect)subviewRect:(UIView *)subview layoutPageRect:(CGRect)rect;
/**
 Computes the intersection between subview's drawing frame and the page rect.

 @param subview The subview for which the intersection of computed.
 @param rect The rect of the current page. The rect is contained in renderer's content view bounds.
 @return The intersection.
 */
- (CGRect)subviewIntersection:(UIView *)subview layoutPageRect:(CGRect)rect;

@end

NS_ASSUME_NONNULL_END
