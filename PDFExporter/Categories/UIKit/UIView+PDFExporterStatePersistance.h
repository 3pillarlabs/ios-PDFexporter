//
//  UIView+StatePersistance.h
//  PDFExporter
//
//  Copyright © 2016 3Pillar Global. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (PDFExporterStatePersistance)

@property (nonatomic, getter=shouldPersistState) BOOL persistState; // default value is YES

- (void)saveState;
- (void)restoreState;

@end

@interface UIViewPersistenceState : NSObject

@property (nonatomic) CGRect frame;

@end

@interface UIView (StatePersistanceSubclassing)

- (Class)stateClass;
- (void)configureState:(UIViewPersistenceState *)state NS_REQUIRES_SUPER;
- (void)performRestoreWithState:(UIViewPersistenceState *)state NS_REQUIRES_SUPER;

@end

NS_ASSUME_NONNULL_END
