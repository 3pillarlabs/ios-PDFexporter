//
//  PDFPrintPageRenderer+Private.h
//  PDFExporter
//
//  Created by David Livadaru on 18/12/2017.
//  Copyright © 2017 3Pillar Global. All rights reserved.
//

#import "PDFPrintPageRenderer.h"

@interface PDFPrintPageRenderer (Private)

- (CGRect)scaledPageRectOffsetForIndex:(NSUInteger)index;

@end
