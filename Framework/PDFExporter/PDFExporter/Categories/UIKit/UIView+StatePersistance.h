//
//  UIView+StatePersistance.h
//  PDFExporter
//
//  Copyright © 2016 3Pillar Global. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (StatePersistance)

- (void)saveState;
- (void)restoreState;

@end

@interface UIViewPersistenceState : NSObject

@end

@interface UIView (StatePersistanceSubclassing)

- (nullable UIViewPersistenceState *)createState;
- (void)performRestoreWithState:(UIViewPersistenceState *)state;

@end

NS_ASSUME_NONNULL_END
