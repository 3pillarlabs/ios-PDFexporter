//
//  PDFMemoryCleanerObject.m
//  PDFExporter
//
//  Created by David Livadaru on 08/11/16.
//  Copyright © 2016 3Pillar Global. All rights reserved.
//

#import "PDFMemoryCleanerObject.h"

@interface PDFMemoryCleanerObject ()

@property (nonatomic, copy) void (^deallocationBlock)(void);

@end

@implementation PDFMemoryCleanerObject

- (instancetype)initWithConstructBlock:(void (^)(void))constructBlock
                     deallocationBlock:(void (^)(void))deallocationBlock {
    self = [super init];
    
    if (self) {
        constructBlock();
        self.deallocationBlock = deallocationBlock;
    }
    
    return self;
}

+ (instancetype)memoryCleanerWithConstructBlock:(void (^)(void))constructBlock
                              deallocationBlock:(void (^)(void))deallocationBlock {
    return [[PDFMemoryCleanerObject alloc] initWithConstructBlock:constructBlock deallocationBlock:deallocationBlock];
}

- (void)dealloc {
    self.deallocationBlock();
}

@end
