//
//  HeaderView.h
//  PDFExporterDemo
//
//  Copyright © 2015 3Pillar Global. All rights reserved.
//

#import <UIKit/UIKit.h>
@import PDFExporter;

@interface HeaderView : UIView <PDFHeaderFooterPaging>

- (instancetype)initFromXib;

@end
