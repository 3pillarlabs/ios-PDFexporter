//
//  PDFPrintPageRenderer.h
//  PDFExporter
//
//  Copyright © 2015 3Pillar Global. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <PDFExporter/PDFHeaderFooterPaging.h>

NS_ASSUME_NONNULL_BEGIN

/**
 Paging option to receive page number and total number of pages of the pdf.

 - PDFPagingOptionNone: callbacks are not send on either the header or footer.
 - PDFPagingOptionFooter: callbacks are sent to the footer.
 - PDFPagingOptionHeader: callbacks are sent to the header.
 */
typedef NS_OPTIONS(NSUInteger, PDFPagingOptions) {
    PDFPagingOptionNone = 0,
    PDFPagingOptionFooter = 1 << 0,
    PDFPagingOptionHeader = 1 << 1
};

/**
 The page orientation.

 - PDFPageOrientationPortrait: portrait orientation of the page.
 - PDFPageOrientationLandscape: landscape orientation of the page.
 */
typedef NS_ENUM(NSUInteger, PDFPageOrientation) {
    PDFPageOrientationPortrait,
    PDFPageOrientationLandscape
};

@interface PDFPrintPageRenderer : UIPrintPageRenderer

/**
 If pagingMask contains PDFPagingOptionHeader, the view will used as header for each page.
 The view may implement PDFHeaderFooterPaging to display the page number.
 */
@property (nonatomic, nullable) UIView<PDFHeaderFooterPaging> *headerView;
/**
 The the view will drawn on the pdf. Depending on the view and the settings(paperSize, paperInset),
 the pdf might have more than 1 more page.
 */
@property (nonatomic) UIView *contentView;
/**
 If pagingMask contains PDFPagingOptionFooter, the view will used as footer for each page.
 The view may implement PDFHeaderFooterPaging to display the page number.
 */
@property (nonatomic, nullable) UIView<PDFHeaderFooterPaging> *footerView;
/**
 A mask which tells the renderer on which view to call paging methods if PDFHeaderFooterPaging is implemented.
 Default value is PDFPagingOptionNone.
 */
@property (nonatomic) PDFPagingOptions pagingMask;
/**
 Change the page orientation of pdf.
 Default is PDFPageOrientationPortrait.
 */
@property (nonatomic) PDFPageOrientation pageOrientation;

/**
 The insets of content (header, contentView's data and footer) on page.
 Default is {30, 30, 30, 30}.
 */
@property (nonatomic) UIEdgeInsets paperInset;
/**
 The paper's size.
 Default is PDFPaperSizeUSLetter.
 */
@property (nonatomic) CGSize paperSize;
/**
 The computed rect of header on each page.
 */
@property (nonatomic, readonly) CGRect headerRect;
/**
 The computed rect of content on each page.
 */
@property (nonatomic, readonly) CGRect contentRect;
/**
 The computed rect of footer on each page.
 */
@property (nonatomic, readonly) CGRect footerRect;

// By default nothing is scaled, i.e. properties are set to NO.
/**
 Scale the content of the header.
 Default value is NO.
 */
@property (nonatomic, getter=isScalingHeader) BOOL scaleHeader;
/**
 Scale the content provided by contentView on each page.
 Default value is NO.
 */
@property (nonatomic, getter=isScalingContent) BOOL scaleContent;
/**
 Scale the content of the footer.
 Default value is NO.
 */
@property (nonatomic, getter=isScalingFooter) BOOL scaleFooter;

/**
 Slice the subviews of contentView between pages.
 Default value is NO.
 */
@property (nonatomic, getter=shouldSliceViews) BOOL sliceViews;

/**
 Draws content. Drawing may be performed only on the main thread.

 @return the pdf as NSData.
 */
- (NSData *)drawPagesToPDFData;

@end

NS_ASSUME_NONNULL_END
