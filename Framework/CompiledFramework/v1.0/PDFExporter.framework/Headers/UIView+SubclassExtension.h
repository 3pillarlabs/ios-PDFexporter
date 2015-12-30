//
//  UIView+PrivateExtension.h
//  PDFExporter
//
//  Copyright © 2015 3Pillar Global. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 *  Drawing override for subclasses.
 */
@interface UIView (SubclassExtension)

- (void)drawBackgroundWithPath:(UIBezierPath *)path;
- (void)drawContentWithPath:(UIBezierPath *)path;
- (void)drawBorderWithPath:(UIBezierPath *)path;

@end
