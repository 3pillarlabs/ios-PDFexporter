//
//  FooterView.h
//  PDFExporterDemo
//
//  Copyright © 2015 3Pillar Global. All rights reserved.
//

#import <UIKit/UIKit.h>
@import PDFExporter;

@interface FooterView : UIView <PDFHeaderFooterPaging>

- (instancetype)initFromXib;

@end
