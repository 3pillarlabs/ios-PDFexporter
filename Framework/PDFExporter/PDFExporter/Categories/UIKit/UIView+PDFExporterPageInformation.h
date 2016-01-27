//
//  UIView+PDFExporterPageInformation.h
//  PDFExporter
//
//  Copyright © 2016 3Pillar Global. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (PDFExporterPageInformation)

// set YES to UIView; set NO for the following basic views: UIButton, UIControl, UIImageView, UIInputView, UILabel, UICollectionReuseableView, UITableViewCell, UITableViewHeaderFooterView
@property (nonatomic, readonly) BOOL askSubviewsRenderingOffset;

- (BOOL)canLayoutSubview:(UIView *)subview intersection:(CGRect)intersection;

- (CGPoint)renderingOffsetForPageRect:(CGRect)rect;

- (CGRect)subviewRect:(UIView *)subview layoutPageRect:(CGRect)rect;
- (CGRect)subviewIntersection:(UIView *)subview layoutPageRect:(CGRect)rect;

@end

NS_ASSUME_NONNULL_END
