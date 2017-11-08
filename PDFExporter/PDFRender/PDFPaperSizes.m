//
//  PDFPaperSizes.m
//  PDFExporter
//
//  Copyright © 2015 3Pillar Global. All rights reserved.
//

#import "PDFPaperSizes.h"
#import <math.h>

CGSize const PDFPaperSizeUSLetter = {612.f, 792.f};
CGSize const PDFPaperSizeUSGovernmentLetter = {576.f, 756.f};
CGSize const PDFPaperSizeUSLegal = {612.f, 1008.f};
CGSize const PDFPaperSizeUSJuniorLegal = {576.f, 360.f};
CGSize const PDFPaperSizeUSLedger = {792.f, 1224.f};
CGSize const PDFPaperSizeUSTabloid = {1224.f, 792.f};
CGSize const PDFPaperSizeUSExecutive = {522.f, 756.f};

CGSize const PDFPaperSizeUKMetricCrownQuatro = {536.f, 697.f};
CGSize const PDFPaperSizeUKMetricCrownOctavo = {349.f, 527.f};
CGSize const PDFPaperSizeUKMetricLargeCrownQuatro = {570.f, 731.f};
CGSize const PDFPaperSizeUKMetricLargeCrownOctavo = {366.f, 561.f};
CGSize const PDFPaperSizeUKMetricDemyQuatro = {621.f, 782.f};
CGSize const PDFPaperSizeUKMetricDemyOctavo = {391.f, 612.f};
CGSize const PDFPaperSizeUKMetricRoyalQuatro = {672.f, 884.f};
CGSize const PDFPaperSizeUKMetricRoyalOctavo = {366.f, 561.f};

CGSize const PDFPaperSizeEnglishSmallRoyal = {1368.f, 1728.f};
CGSize const PDFPaperSizeEnglishRoyal = {1440.f, 1800.f};
CGSize const PDFPaperSizeEnglishImperial = {1584.f, 2160.f};

CGSize const PDFPaperSizeISOA0 = {2384.f, 3370.f};
CGSize const PDFPaperSizeISOA1 = {1684.f, 2384.f};
CGSize const PDFPaperSizeISOA2 = {1190.f, 1684.f};
CGSize const PDFPaperSizeISOA3 = {842.f, 1190.f};
CGSize const PDFPaperSizeISOA4 = {595.f, 842.f};
CGSize const PDFPaperSizeISOA5 = {420.f, 595.f};
CGSize const PDFPaperSizeISOA6 = {298.f, 420.f};
CGSize const PDFPaperSizeISOA7 = {210.f, 298.f};
CGSize const PDFPaperSizeISOA8 = {148.f, 210.f};

CGSize const PDFPaperSizeISOB0 = {2835.f, 4008.f};
CGSize const PDFPaperSizeISOB1 = {2004.f, 2835.f};
CGSize const PDFPaperSizeISOB2 = {1417.f, 2004.f};
CGSize const PDFPaperSizeISOB3 = {1001.f, 1417.f};
CGSize const PDFPaperSizeISOB4 = {709.f, 1001.f};
CGSize const PDFPaperSizeISOB5 = {499.f, 709.f};
CGSize const PDFPaperSizeISOB6 = {354.f, 499.f};
CGSize const PDFPaperSizeISOB7 = {249.f, 354.f};
CGSize const PDFPaperSizeISOB8 = {176.f, 249.f};
CGSize const PDFPaperSizeISOB9 = {125.f, 176.f};
CGSize const PDFPaperSizeISOB10 = {88.f, 125.f};

CGSize const PDFPaperSizeNewsMidi = {893.f, 1332.f};
CGSize const PDFPaperSizeNewsBroadsheet = {1692.f, 2124.f};
CGSize const PDFPaperSizeNewsTabloid = {792.f, 1217.f};
CGSize const PDFPaperSizeNewsRhenish = {1006.f, 1474.f};

CGFloat _PDFPaperConvertMMToInch(CGFloat milimeters)
{
    return milimeters / 25.4f;
}

CGFloat PDFPaperConvertInchToPoint(CGFloat inches)
{
    return ceilf(inches * 72);
}

CGFloat PDFPaperConvertMMToPoint(CGFloat milimeters)
{
    CGFloat inches = _PDFPaperConvertMMToInch(milimeters);
    return PDFPaperConvertInchToPoint(inches);
}

CGSize PDFPaperSizeMakeUsingMM(CGFloat widthUsingMM, CGFloat heightUsingMM)
{
    return CGSizeMake(PDFPaperConvertMMToPoint(widthUsingMM), PDFPaperConvertMMToPoint(heightUsingMM));
}

CGSize PDFPaperSizeMakeUsingInch(CGFloat widthUsingInch, CGFloat heightUsingInch)
{
    return CGSizeMake(PDFPaperConvertInchToPoint(widthUsingInch), PDFPaperConvertInchToPoint(heightUsingInch));
}
