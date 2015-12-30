//
//  PDFPrintPageRenderer.h
//  PDFExporter
//
//  Copyright © 2015 3Pillar Global. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <PDFExporter/PDFHeaderFooterPaging.h>

@interface PDFPrintPageRenderer : UIPrintPageRenderer

@property (nonatomic) UIView *headerView;
@property (nonatomic) UIView *contentView;
@property (nonatomic) UIView<PDFHeaderFooterPaging> *footerView;

@property (nonatomic) UIEdgeInsets paperInsets; // default is {30, 30, 30, 30}
@property (nonatomic) CGSize paperSize; // default is PDFPaperSizeUSLetter
@property (nonatomic, readonly) CGRect contentRect;

- (NSData *)drawPagesToPDFData;

@end
