//
//  UIView+Extension.h
//  PDFExporter
//
//  Copyright © 2015 3Pillar Global. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (PDFExporterExtension)

@property (nonatomic, readonly, getter=isDrawable) BOOL drawable;
@property (nonatomic, readonly) CGRect drawingFrame;

- (BOOL)handlesSubviewsDrawing; //  by default returns NO.

- (NSArray *)drawingSubviewsForRect:(CGRect)rect;

- (void)drawViewWithRect:(CGRect)rect;
- (void)drawBackgroundWithPath:(UIBezierPath *)path;
- (void)drawContentWithPath:(UIBezierPath *)path;
- (void)drawBorderWithPath:(UIBezierPath *)path;

@end

NS_ASSUME_NONNULL_END
