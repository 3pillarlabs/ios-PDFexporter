//
//  UIViewPersistenceState.h
//  PDFExporter
//
//  Created by David Livadaru on 13/12/2017.
//  Copyright © 2017 3Pillar Global. All rights reserved.
//

#import <Foundation/Foundation.h>
@import CoreGraphics;

NS_ASSUME_NONNULL_BEGIN

@interface UIViewPersistenceState : NSObject

/**
 Stores UIView's frame.
 */
@property (nonatomic) CGRect frame;

@end

NS_ASSUME_NONNULL_END
