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

@property (nonatomic, nullable) UIView<PDFHeaderFooterPaging> *headerView; // if pagingMask && PDFPagingOptionHeader, headerView should implement the optional method from the protocol
@property (nonatomic) UIView *contentView;
@property (nonatomic, nullable) UIView<PDFHeaderFooterPaging> *footerView; // if pagingMask && PDFPagingOptionFooter, footerView should implement the optional method from the protocol
@property (nonatomic) PDFPagingOptions pagingMask; // default is PDFPagingOptionNone

@property (nonatomic) UIEdgeInsets paperInset; // default is {30, 30, 30, 30}
@property (nonatomic) CGSize paperSize; // default is PDFPaperSizeUSLetter
@property (nonatomic, readonly) CGRect headerRect;
@property (nonatomic, readonly) CGRect contentRect;
@property (nonatomic, readonly) CGRect footerRect;

// By default nothing is scaled, i.e. properties are set to NO.
@property (nonatomic, getter=isScalingHeader) BOOL scaleHeader;
@property (nonatomic, getter=isScalingContent) BOOL scaleContent;
@property (nonatomic, getter=isScalingFooter) BOOL scaleFooter;

@property (nonatomic, getter=shouldSliceViews) BOOL sliceViews; // default is NO

// Draws content. As any drawing method should be called only on main queue.
- (NSData *)drawPagesToPDFData;

@end

NS_ASSUME_NONNULL_END
