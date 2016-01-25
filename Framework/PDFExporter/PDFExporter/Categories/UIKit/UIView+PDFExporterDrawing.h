//
//  UIView+Extension.h
//  PDFExporter
//
//  Copyright © 2015 3Pillar Global. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol PDFRenderingDelegate <NSObject>

- (void)view:(UIView *)view requiresOffsetDrawing:(CGPoint)offset;
- (CGRect)view:(UIView *)view convertRectToContentView:(CGRect)rect;
- (BOOL)viewCanRequestOffsetForDrawing:(UIView *)view;

@end

@interface UIView (PDFExporterDrawing)

@property (nonatomic, readonly, getter=isDrawable) BOOL drawable;
@property (nonatomic, readonly, getter=shouldDrawSubviews) BOOL drawSubviews;
@property (nonatomic, readonly) CGRect drawingFrame;

// content views and subviews that do not fit on one page are sliced
// a subview is a view just contains other views with no custom drawing
@property (nonatomic, getter=shouldSliceSubviews) BOOL sliceSubviews;
@property (nonatomic, weak) id<PDFRenderingDelegate> renderingDelegate;

- (void)prepareForDrawingWithPageSize:(CGSize)size NS_REQUIRES_SUPER;
- (void)cleanAfterDrawing NS_REQUIRES_SUPER;

- (void)drawViewWithinPageRect:(CGRect)rect;
- (void)drawBackgroundWithPath:(UIBezierPath *)path;
- (void)drawContentWithPath:(UIBezierPath *)path;
- (void)drawSubviewsWithPath:(UIBezierPath *)path withinPageRect:(CGRect)rect;
- (void)drawBorderWithPath:(UIBezierPath *)path;

@end

@interface UIView (PDFExpoterPageInformation)

- (CGPoint)renderingOffsetForPageRect:(CGRect)rect;

- (CGRect)subviewRect:(UIView *)subview;
- (CGRect)subviewIntersection:(UIView *)subview rect:(CGRect)rect;

@end

NS_ASSUME_NONNULL_END
