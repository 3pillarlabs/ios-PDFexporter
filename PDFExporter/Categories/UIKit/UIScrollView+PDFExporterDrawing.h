//
//  UIScrollView+Extension.h
//  PDFExporter
//
//  Copyright © 2016 3Pillar Global. All rights reserved.
//

#import <PDFExporter/UIView+PDFExporterDrawing.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIScrollView (PDFExporterDrawing)

/**
 Default is NO.
 */
@property (nonatomic, getter=isDrawingEntireContentSize) BOOL drawEntireContentSize;

@end

NS_ASSUME_NONNULL_END
