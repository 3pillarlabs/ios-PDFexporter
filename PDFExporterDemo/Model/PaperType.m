//
//  PaperType.m
//  PDFExporterDemo
//
//  Copyright © 2015 3Pillar Global. All rights reserved.
//

@import PDFExporter;
#import "PaperType.h"

@interface PaperType ()

@property (nonatomic, readwrite) NSString *name;
@property (nonatomic, readwrite) CGSize size;

@end

@implementation PaperType

+ (NSArray<PaperType *> *)allPaperTypes {
    static NSMutableArray<PaperType *> *allPaperTypes = nil;
    
    if (!allPaperTypes) {
        allPaperTypes = [NSMutableArray new];
        
        PaperType *paperType = [PaperType new];
        paperType.name = @"US Letter";
        paperType.size = PDFPaperSizeUSLetter;
        [allPaperTypes addObject:paperType];
        paperType = [PaperType new];
        paperType.name = @"US Government Letter";
        paperType.size = PDFPaperSizeUSGovernmentLetter;
        [allPaperTypes addObject:paperType];
        paperType = [PaperType new];
        paperType.name = @"US Legal";
        paperType.size = PDFPaperSizeUSLegal;
        [allPaperTypes addObject:paperType];
        paperType = [PaperType new];
        paperType.name = @"US Junior Legal";
        paperType.size = PDFPaperSizeUSJuniorLegal;
        [allPaperTypes addObject:paperType];
        paperType = [PaperType new];
        paperType.name = @"US Ledger";
        paperType.size = PDFPaperSizeUSLedger;
        [allPaperTypes addObject:paperType];
        paperType = [PaperType new];
        paperType.name = @"US Tabloid";
        paperType.size = PDFPaperSizeUSTabloid;
        [allPaperTypes addObject:paperType];
        paperType = [PaperType new];
        paperType.name = @"US Executive";
        paperType.size = PDFPaperSizeUSExecutive;
        [allPaperTypes addObject:paperType];
        
        paperType = [PaperType new];
        paperType.name = @"UK Metric Crown Quatro";
        paperType.size = PDFPaperSizeUKMetricCrownQuatro;
        [allPaperTypes addObject:paperType];
        paperType = [PaperType new];
        paperType.name = @"UK Metric Crown Octavo";
        paperType.size = PDFPaperSizeUKMetricCrownOctavo;
        [allPaperTypes addObject:paperType];
        paperType = [PaperType new];
        paperType.name = @"UK Metric Lager Crown Quatro";
        paperType.size = PDFPaperSizeUKMetricLargeCrownQuatro;
        [allPaperTypes addObject:paperType];
        paperType = [PaperType new];
        paperType.name = @"UK Metric Lager Crown Octavo";
        paperType.size = PDFPaperSizeUKMetricLargeCrownOctavo;
        [allPaperTypes addObject:paperType];
        paperType = [PaperType new];
        paperType.name = @"UK Metric Demy Quatro";
        paperType.size = PDFPaperSizeUKMetricDemyQuatro;
        [allPaperTypes addObject:paperType];
        paperType = [PaperType new];
        paperType.name = @"UK Metric Demy Octavo";
        paperType.size = PDFPaperSizeUKMetricDemyOctavo;
        [allPaperTypes addObject:paperType];
        paperType = [PaperType new];
        paperType.name = @"UK Metric Royal Quatro";
        paperType.size = PDFPaperSizeUKMetricRoyalQuatro;
        [allPaperTypes addObject:paperType];
        paperType = [PaperType new];
        paperType.name = @"UK Metric Royal Octavo";
        paperType.size = PDFPaperSizeUKMetricRoyalOctavo;
        [allPaperTypes addObject:paperType];
        
        paperType = [PaperType new];
        paperType.name = @"English Small Royal";
        paperType.size = PDFPaperSizeEnglishSmallRoyal;
        [allPaperTypes addObject:paperType];
        paperType = [PaperType new];
        paperType.name = @"English Royal";
        paperType.size = PDFPaperSizeEnglishRoyal;
        [allPaperTypes addObject:paperType];
        paperType = [PaperType new];
        paperType.name = @"English Imperial";
        paperType.size = PDFPaperSizeEnglishImperial;
        [allPaperTypes addObject:paperType];
        
        paperType = [PaperType new];
        paperType.name = @"ISO A0";
        paperType.size = PDFPaperSizeISOA0;
        [allPaperTypes addObject:paperType];
        paperType = [PaperType new];
        paperType.name = @"ISO A1";
        paperType.size = PDFPaperSizeISOA1;
        [allPaperTypes addObject:paperType];
        paperType = [PaperType new];
        paperType.name = @"ISO A2";
        paperType.size = PDFPaperSizeISOA2;
        [allPaperTypes addObject:paperType];
        paperType = [PaperType new];
        paperType.name = @"ISO A3";
        paperType.size = PDFPaperSizeISOA3;
        [allPaperTypes addObject:paperType];
        paperType = [PaperType new];
        paperType.name = @"ISO A4";
        paperType.size = PDFPaperSizeISOA4;
        [allPaperTypes addObject:paperType];
        paperType = [PaperType new];
        paperType.name = @"ISO A5";
        paperType.size = PDFPaperSizeISOA5;
        [allPaperTypes addObject:paperType];
        paperType = [PaperType new];
        paperType.name = @"ISO A6";
        paperType.size = PDFPaperSizeISOA6;
        [allPaperTypes addObject:paperType];
        paperType = [PaperType new];
        paperType.name = @"ISO A7";
        paperType.size = PDFPaperSizeISOA7;
        [allPaperTypes addObject:paperType];
        paperType = [PaperType new];
        paperType.name = @"ISO A8";
        paperType.size = PDFPaperSizeISOA8;
        [allPaperTypes addObject:paperType];
        
        paperType = [PaperType new];
        paperType.name = @"ISO B0";
        paperType.size = PDFPaperSizeISOB0;
        [allPaperTypes addObject:paperType];
        paperType = [PaperType new];
        paperType.name = @"ISO B1";
        paperType.size = PDFPaperSizeISOB1;
        [allPaperTypes addObject:paperType];
        paperType = [PaperType new];
        paperType.name = @"ISO B2";
        paperType.size = PDFPaperSizeISOB2;
        [allPaperTypes addObject:paperType];
        paperType = [PaperType new];
        paperType.name = @"ISO B3";
        paperType.size = PDFPaperSizeISOB3;
        [allPaperTypes addObject:paperType];
        paperType = [PaperType new];
        paperType.name = @"ISO B4";
        paperType.size = PDFPaperSizeISOB4;
        [allPaperTypes addObject:paperType];
        paperType = [PaperType new];
        paperType.name = @"ISO B5";
        paperType.size = PDFPaperSizeISOB5;
        [allPaperTypes addObject:paperType];
        paperType = [PaperType new];
        paperType.name = @"ISO B6";
        paperType.size = PDFPaperSizeISOB6;
        [allPaperTypes addObject:paperType];
        paperType = [PaperType new];
        paperType.name = @"ISO B7";
        paperType.size = PDFPaperSizeISOB7;
        [allPaperTypes addObject:paperType];
        paperType = [PaperType new];
        paperType.name = @"ISO B8";
        paperType.size = PDFPaperSizeISOB8;
        [allPaperTypes addObject:paperType];
        paperType = [PaperType new];
        paperType.name = @"ISO B9";
        paperType.size = PDFPaperSizeISOB9;
        [allPaperTypes addObject:paperType];
        paperType = [PaperType new];
        paperType.name = @"ISO B10";
        paperType.size = PDFPaperSizeISOB10;
        [allPaperTypes addObject:paperType];
        
        paperType = [PaperType new];
        paperType.name = @"News Midi";
        paperType.size = PDFPaperSizeNewsMidi;
        [allPaperTypes addObject:paperType];
        paperType = [PaperType new];
        paperType.name = @"News Broadsheet";
        paperType.size = PDFPaperSizeNewsBroadsheet;
        [allPaperTypes addObject:paperType];
        paperType = [PaperType new];
        paperType.name = @"News Tabloid";
        paperType.size = PDFPaperSizeNewsTabloid;
        [allPaperTypes addObject:paperType];
        paperType = [PaperType new];
        paperType.name = @"News Rhenish";
        paperType.size = PDFPaperSizeNewsRhenish;
        [allPaperTypes addObject:paperType];
    }
    
    return allPaperTypes;
}

@end
