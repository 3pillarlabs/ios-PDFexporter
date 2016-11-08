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

typedef NS_ENUM(NSUInteger, PDFPageOrientation) {
    PDFPageOrientationPortrait,
    PDFPageOrientationLandscape
};

@interface PDFPrintPageRenderer : UIPrintPageRenderer

@property (nonatomic, nullable) UIView<PDFHeaderFooterPaging> *headerView; // if pagingMask && PDFPagingOptionHeader, headerView should implement the optional method from the protocol
@property (nonatomic) UIView *contentView;
@property (nonatomic, nullable) UIView<PDFHeaderFooterPaging> *footerView; // if pagingMask && PDFPagingOptionFooter, footerView should implement the optional method from the protocol
@property (nonatomic) PDFPagingOptions pagingMask; // default is PDFPagingOptionNone
@property (nonatomic) PDFPageOrientation pageOrientation; // default is PDFPageOrientationPortrait

@property (nonatomic) UIEdgeInsets paperInset; // default is {30, 30, 30, 30}
@property (nonatomic) CGSize paperSize; // default is PDFPaperSizeUSLetter, size should be provided for portrait orientation
@property (nonatomic, readonly) CGRect headerRect;
@property (nonatomic, readonly) CGRect contentRect;
@property (nonatomic, readonly) CGRect footerRect;

// By default nothing is scaled, i.e. properties are set to NO.
@property (nonatomic, getter=isScalingHeader) BOOL scaleHeader;
@property (nonatomic, getter=isScalingContent) BOOL scaleContent;
@property (nonatomic, getter=isScalingFooter) BOOL scaleFooter;

@property (nonatomic, getter=shouldSliceViews) BOOL sliceViews; // default is NO

// Draws content. Drawing may be performed on any queue. View's layout will be synchronized on main queue when and if needed.
// Method may be wrapped within an operation which may be cancelled.
- (NSData *)drawPagesToPDFData;

@end

NS_ASSUME_NONNULL_END
