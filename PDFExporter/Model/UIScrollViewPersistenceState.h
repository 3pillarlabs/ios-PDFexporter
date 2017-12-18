//
//  UIScrollViewPersistenceState.h
//  PDFExporter
//
//  Created by David Livadaru on 13/12/2017.
//  Copyright © 2017 3Pillar Global. All rights reserved.
//

#import <PDFExporter/PDFExporter.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIScrollViewPersistenceState : UIViewPersistenceState

/**
 Stores UIScrollView's frame.
 */
@property (nonatomic) CGPoint contentOffset;

@end

NS_ASSUME_NONNULL_END
