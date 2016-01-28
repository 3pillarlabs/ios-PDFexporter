//
//  FooterView.h
//  PDFExporterDemo
//
//  Copyright © 2015 3Pillar Global. All rights reserved.
//

#import <UIKit/UIKit.h>
@import PDFExporter;

NS_ASSUME_NONNULL_BEGIN

@interface FooterView : UIView <PDFHeaderFooterPaging>

@property (nonatomic) CGFloat drawingWidth;

- (instancetype)initFromXib;

@end

NS_ASSUME_NONNULL_END
