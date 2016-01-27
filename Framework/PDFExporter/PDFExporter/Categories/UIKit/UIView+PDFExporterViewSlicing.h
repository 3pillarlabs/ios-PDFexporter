//
//  UIView+PDFExporterViewSlicing.h
//  PDFExporter
//
//  Copyright © 2016 3Pillar Global. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <PDFExporter/PDFRenderingDelegate.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (PDFExporterViewSlicing)

// content views and subviews that do not fit on one page are sliced
// a subview is a view just contains other views with no custom drawing
@property (nonatomic, getter=shouldSliceSubviews, readonly) BOOL sliceSubviews;
// rendering delegate is the same within a view hierarchy
@property (nonatomic, weak, nullable) id<PDFRenderingDelegate> renderingDelegate;

@end

NS_ASSUME_NONNULL_END
