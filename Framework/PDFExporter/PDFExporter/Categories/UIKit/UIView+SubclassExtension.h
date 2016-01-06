//
//  UIView+PrivateExtension.h
//  PDFExporter
//
//  Copyright © 2015 3Pillar Global. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/**
 *  Drawing override for subclasses.
 */
@interface UIView (SubclassExtension)

- (void)drawBackgroundWithPath:(UIBezierPath *)path;
- (void)drawContentWithPath:(UIBezierPath *)path;
- (void)drawBorderWithPath:(UIBezierPath *)path;

@end

NS_ASSUME_NONNULL_END
