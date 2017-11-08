//
//  PaperType.h
//  PDFExporterDemo
//
//  Copyright © 2015 3Pillar Global. All rights reserved.
//

#import <CoreGraphics/CGGeometry.h>
#import <Foundation/Foundation.h>

@interface PaperType : NSObject

@property (nonatomic, readonly) NSString *name;
@property (nonatomic, readonly) CGSize size;

+ (NSArray<PaperType *> *)allPaperTypes;

@end
