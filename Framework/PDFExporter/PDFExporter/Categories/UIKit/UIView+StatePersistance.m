//
//  UIView+StatePersistance.m
//  PDFExporter
//
//  Copyright © 2016 3Pillar Global. All rights reserved.
//

#import "UIView+StatePersistance.h"
#import <objc/runtime.h>

static void * const kUIViewPersistenceStatesAssociatedStorageKey = (void *)&kUIViewPersistenceStatesAssociatedStorageKey;

@interface UIView (StatePersistancePrivate)

@property (nonatomic) NSMutableArray *persistenceStates;

@end

@implementation UIView (StatePersistance)

- (NSMutableArray *)persistenceStates {
    NSMutableArray *_persistenceStates = objc_getAssociatedObject(self, kUIViewPersistenceStatesAssociatedStorageKey);
    if (!_persistenceStates) {
        _persistenceStates = [NSMutableArray new];
        self.persistenceStates = _persistenceStates;
    }
    return _persistenceStates;
}

- (void)setPersistenceStates:(NSMutableArray *)persistenceStates {
    objc_setAssociatedObject(self, kUIViewPersistenceStatesAssociatedStorageKey, persistenceStates, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)saveState {
    UIViewPersistenceState *state = [self createState];
    if (state) {
        [self.persistenceStates addObject:state];
    }
}

- (void)restoreState {
    UIViewPersistenceState *state = [self.persistenceStates lastObject];
    if (state) {
        [self performRestoreWithState:state];
        [self.persistenceStates removeLastObject];
    }
}

#pragma mark - StatePersistanceSubclassing

- (UIViewPersistenceState *)createState {
    return nil;
}

- (void)performRestoreWithState:(UIViewPersistenceState *)state {
    // Nothing to do by default
}

@end

@implementation UIViewPersistenceState

@end
