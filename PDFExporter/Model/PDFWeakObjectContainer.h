//
//  PDFWeakObjectContainer.h
//  PDFExporter
//
//  Copyright © 2016 3Pillar Global. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface PDFWeakObjectContainer : NSObject

@property (nonatomic, weak, nullable) id weakObject;

@end

NS_ASSUME_NONNULL_END
