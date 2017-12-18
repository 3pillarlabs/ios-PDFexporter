//
//  PDFHeaderFooterPaging.h
//  PDFExporter
//
//  Copyright © 2015 3Pillar Global. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
 
/**
 Provides an interface for views which are provided as header or footer to renderer.
 */
@protocol PDFHeaderFooterPaging <NSObject>

@optional
/**
 Called on every page draw.

 @param pageNumber the current page.
 @param totalPages the number of pages.
 */
- (void)updatePageNumber:(NSUInteger)pageNumber totalPages:(NSUInteger)totalPages;

@end

NS_ASSUME_NONNULL_END
