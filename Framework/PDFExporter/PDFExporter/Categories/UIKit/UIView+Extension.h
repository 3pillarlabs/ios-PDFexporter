//
//  UIView+Extension.h
//  PDFExporter
//
//  Copyright © 2015 3Pillar Global. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (Extension)

@property (nonatomic, readonly, getter=isDrawable) BOOL drawable;
@property (nonatomic, readonly) CGRect drawingFrame;

- (NSArray *)drawingSubviewsForRect:(CGRect)rect;
- (void)drawViewWithPageRect:(CGRect)pageRect;

@end

NS_ASSUME_NONNULL_END
