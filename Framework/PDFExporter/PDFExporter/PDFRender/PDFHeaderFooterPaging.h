//
//  PDFHeaderFooterPaging.h
//  PDFExporter
//
//  Copyright © 2015 3Pillar Global. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol PDFHeaderFooterPaging <NSObject>

- (void)updatePageNumber:(NSUInteger)pageNumber totalPages:(NSUInteger)totalPages;

@end

NS_ASSUME_NONNULL_END
