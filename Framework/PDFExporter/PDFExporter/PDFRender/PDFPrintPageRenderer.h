//
//  PDFPrintPageRenderer.h
//  PDFExporter
//
//  Copyright © 2015 3Pillar Global. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <PDFExporter/PDFHeaderFooterPaging.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_OPTIONS(NSUInteger, PDFPagingOptions) {
    PDFPagingOptionNone = 0,
    PDFPagingOptionFooter = 1 << 0,
    PDFPagingOptionHeader = 1 << 1
};

@interface PDFPrintPageRenderer : UIPrintPageRenderer

@property (nonatomic, nullable) UIView<PDFHeaderFooterPaging> *headerView; // if pagingMask && PDFPagingOptionHeader, headerView should implement protocol
@property (nonatomic) UIView *contentView;
@property (nonatomic, nullable) UIView<PDFHeaderFooterPaging> *footerView; // if pagingMask && PDFPagingOptionFooter, footerView should implement protocol
@property (nonatomic) PDFPagingOptions pagingMask; // default is PDFPagingOptionNone

@property (nonatomic) UIEdgeInsets paperInsets; // default is {30, 30, 30, 30}
@property (nonatomic) CGSize paperSize; // default is PDFPaperSizeUSLetter
@property (nonatomic, readonly) CGRect contentRect;

- (NSData *)drawPagesToPDFData;

@end

NS_ASSUME_NONNULL_END
