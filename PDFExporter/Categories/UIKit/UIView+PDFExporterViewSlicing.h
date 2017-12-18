//
//  UIView+PDFExporterViewSlicing.h
//  PDFExporter
//
//  Copyright © 2016 3Pillar Global. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol PDFRenderingDelegate;

NS_ASSUME_NONNULL_BEGIN

@interface UIView (PDFExporterViewSlicing)

/**
 Content views's subviews that do not fit on one page are sliced.
 A subview is positioned in such way that might be sliced between pages even if fits on a page.
 The property provides control for such subviews.
 */
@property (nonatomic, readonly, getter=shouldSliceSubviews) BOOL sliceSubviews;
/**
 Rendering delegate is the same within a view hierarchy.
 i.e. if a view has a set a rendering delegate, then all the views contained in the view has the same delegate.
 */
@property (nonatomic, weak, nullable) id<PDFRenderingDelegate> renderingDelegate;

@end

NS_ASSUME_NONNULL_END
