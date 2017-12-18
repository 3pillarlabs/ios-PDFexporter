//
//  PDFPaperSizes.h
//  PDFExporter
//
//  Copyright © 2015 3Pillar Global. All rights reserved.
//

#import <CoreGraphics/CGBase.h>
#import <CoreGraphics/CGGeometry.h>

// References for paper size: http://www.prepressure.com/library/paper-size , https://en.wikipedia.org/wiki/Paper_size

CF_ASSUME_NONNULL_BEGIN

CG_EXTERN CGSize const PDFPaperSizeUSLetter;
CG_EXTERN CGSize const PDFPaperSizeUSGovernmentLetter;
CG_EXTERN CGSize const PDFPaperSizeUSLegal;
CG_EXTERN CGSize const PDFPaperSizeUSJuniorLegal;
CG_EXTERN CGSize const PDFPaperSizeUSLedger;
CG_EXTERN CGSize const PDFPaperSizeUSTabloid;
CG_EXTERN CGSize const PDFPaperSizeUSExecutive;

CG_EXTERN CGSize const PDFPaperSizeUKMetricCrownQuatro;
CG_EXTERN CGSize const PDFPaperSizeUKMetricCrownOctavo;
CG_EXTERN CGSize const PDFPaperSizeUKMetricLargeCrownQuatro;
CG_EXTERN CGSize const PDFPaperSizeUKMetricLargeCrownOctavo;
CG_EXTERN CGSize const PDFPaperSizeUKMetricDemyQuatro;
CG_EXTERN CGSize const PDFPaperSizeUKMetricDemyOctavo;
CG_EXTERN CGSize const PDFPaperSizeUKMetricRoyalQuatro;
CG_EXTERN CGSize const PDFPaperSizeUKMetricRoyalOctavo;

CG_EXTERN CGSize const PDFPaperSizeEnglishSmallRoyal;
CG_EXTERN CGSize const PDFPaperSizeEnglishRoyal;
CG_EXTERN CGSize const PDFPaperSizeEnglishImperial;

CG_EXTERN CGSize const PDFPaperSizeISOA0;
CG_EXTERN CGSize const PDFPaperSizeISOA1;
CG_EXTERN CGSize const PDFPaperSizeISOA2;
CG_EXTERN CGSize const PDFPaperSizeISOA3;
CG_EXTERN CGSize const PDFPaperSizeISOA4;
CG_EXTERN CGSize const PDFPaperSizeISOA5;
CG_EXTERN CGSize const PDFPaperSizeISOA6;
CG_EXTERN CGSize const PDFPaperSizeISOA7;
CG_EXTERN CGSize const PDFPaperSizeISOA8;

CG_EXTERN CGSize const PDFPaperSizeISOB0;
CG_EXTERN CGSize const PDFPaperSizeISOB1;
CG_EXTERN CGSize const PDFPaperSizeISOB2;
CG_EXTERN CGSize const PDFPaperSizeISOB3;
CG_EXTERN CGSize const PDFPaperSizeISOB4;
CG_EXTERN CGSize const PDFPaperSizeISOB5;
CG_EXTERN CGSize const PDFPaperSizeISOB6;
CG_EXTERN CGSize const PDFPaperSizeISOB7;
CG_EXTERN CGSize const PDFPaperSizeISOB8;
CG_EXTERN CGSize const PDFPaperSizeISOB9;
CG_EXTERN CGSize const PDFPaperSizeISOB10;

// Average sizes for newspaper
CG_EXTERN CGSize const PDFPaperSizeNewsMidi;
CG_EXTERN CGSize const PDFPaperSizeNewsBroadsheet;
CG_EXTERN CGSize const PDFPaperSizeNewsTabloid;
CG_EXTERN CGSize const PDFPaperSizeNewsRhenish;

// Utilities
/**
 Converts a papper inch into a point on the page from pdf document.

 @param inches the physical measument of paper.
 @return the digital measurement of paper.
 */
CG_EXTERN CGFloat PDFPaperConvertInchToPoint(CGFloat inches);
/**
 Converts a papper inch into a point on the page from pdf document.

 @param milimeters the physical measument of paper.
 @return the digital measurement of paper.
 */
CG_EXTERN CGFloat PDFPaperConvertMMToPoint(CGFloat millimeters);
/**
 Create a paper size by providing the width and height in milimeters.

 @param widthUsingMM paper's width in millimeters.
 @param heightUsingMM paper's height in millimeters.
 @return paper's size as CGSize.
 */
CG_EXTERN CGSize PDFPaperSizeMakeUsingMM(CGFloat widthUsingMM, CGFloat heightUsingMM);
/**
 Create a paper size by providing the width and height using inches.

 @param widthUsingInch paper's width using inch.
 @param heightUsingInch paper's height using inch.
 @return paper's size as CGSize.
 */
CG_EXTERN CGSize PDFPaperSizeMakeUsingInch(CGFloat widthUsingInch, CGFloat heightUsingInch);

CF_ASSUME_NONNULL_END
