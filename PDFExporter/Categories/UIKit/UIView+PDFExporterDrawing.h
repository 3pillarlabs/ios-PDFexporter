//
//  UIView+Extension.h
//  PDFExporter
//
//  Copyright © 2015 3Pillar Global. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (PDFExporterDrawing)

@property (nonatomic, readonly, getter=isDrawable) BOOL drawable;
@property (nonatomic, readonly, getter=shouldDrawSubviews) BOOL drawSubviews;
@property (nonatomic, readonly) CGRect drawingFrame;

- (void)prepareForDrawingWithPageSize:(CGSize)size NS_REQUIRES_SUPER;
- (void)cleanAfterDrawing NS_REQUIRES_SUPER;

- (void)drawViewWithinPageRect:(CGRect)rect;
- (void)drawBackgroundWithPath:(UIBezierPath *)path;
- (void)drawContentWithPath:(UIBezierPath *)path;
- (void)drawSubviewsWithPath:(UIBezierPath *)path withinPageRect:(CGRect)rect;
- (void)drawBorderWithPath:(UIBezierPath *)path;

- (BOOL)canDrawSubview:(UIView *)subview intersection:(CGRect)intersection;

- (CGRect)subviewRect:(UIView *)subview drawingPageRect:(CGRect)rect;
- (CGRect)subviewIntersection:(UIView *)subview drawingPageRect:(CGRect)rect;

@end

NS_ASSUME_NONNULL_END