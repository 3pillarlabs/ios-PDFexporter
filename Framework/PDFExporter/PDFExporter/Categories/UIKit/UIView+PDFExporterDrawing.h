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
@property (nonatomic, getter=shouldCreateMetadata) BOOL createMetadata; // superview's value takes priority, default value is NO
@property (nonatomic, readonly) CGRect drawingFrame;

- (void)prepareForDrawingWithPageSize:(CGSize)size rootView:(UIView *)rootView NS_REQUIRES_SUPER;
- (void)cleanAfterDrawing NS_REQUIRES_SUPER;

- (void)drawViewWithinPageRect:(CGRect)rect;
- (void)drawBackgroundWithPath:(UIBezierPath *)path;
- (void)drawContentWithPath:(UIBezierPath *)path;
- (void)drawSubviewsWithPath:(UIBezierPath *)path withinPageRect:(CGRect)rect;
- (void)drawBorderWithPath:(UIBezierPath *)path;

- (NSMutableArray *)subviewsForPageRect:(CGRect)rect;

@end

NS_ASSUME_NONNULL_END
