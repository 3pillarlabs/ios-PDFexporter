//
//  UIView+StatePersistance.h
//  PDFExporter
//
//  Copyright © 2016 3Pillar Global. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (PDFExporterStatePersistance)

/**
 Default is NO.
 */
@property (nonatomic, getter=shouldPersistState) BOOL persistState;

/**
 Preserves the current state of the view.
 */
- (void)saveState;
/**
 Restores the last saved state.
 */
- (void)restoreState;

@end

NS_ASSUME_NONNULL_END
