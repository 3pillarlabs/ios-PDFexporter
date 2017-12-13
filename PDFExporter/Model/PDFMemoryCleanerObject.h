//
//  PDFMemoryCleanerObject.h
//  PDFExporter
//
//  Created by David Livadaru on 08/11/16.
//  Copyright © 2016 3Pillar Global. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface PDFMemoryCleanerObject : NSObject

- (instancetype)initWithConstructBlock:(void (^)(void))constructBlock
                     deallocationBlock:(void (^)(void))deallocationBlock;

+ (instancetype)memoryCleanerWithConstructBlock:(void (^)(void))constructBlock
                              deallocationBlock:(void (^)(void))deallocationBlock;

@end

NS_ASSUME_NONNULL_END
