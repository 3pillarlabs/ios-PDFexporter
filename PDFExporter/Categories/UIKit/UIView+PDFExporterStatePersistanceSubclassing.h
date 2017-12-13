//
//  UIView+PDFExporterStatePersistanceSubclassing.h
//  PDFExporter
//
//  Created by David Livadaru on 13/12/2017.
//  Copyright © 2017 3Pillar Global. All rights reserved.
//

#import <UIKit/UIKit.h>

@class UIViewPersistenceState;

NS_ASSUME_NONNULL_BEGIN

@interface UIView (PDFExporterStatePersistanceSubclassing)

/**
 The state class to be used for this UIView subclass.
 UIView returns UIViewPersistenceState.
 UIScrollView returns UIScrollViewPersistenceState.

 @return The state class to be used for this UIView subclass.
 */
- (Class)stateClass;
/**
 Save the information into state.
 Subclasses must call super.

 @param state The state object which can store data.
 */
- (void)configureState:(UIViewPersistenceState *)state NS_REQUIRES_SUPER;
/**
 Restores the state using data from state object.
 Subclasses must call super.

 @param state The state object which can store data.
 */
- (void)performRestoreWithState:(UIViewPersistenceState *)state NS_REQUIRES_SUPER;

@end

NS_ASSUME_NONNULL_END
