//
//  UIView+StatePersistance.m
//  PDFExporter
//
//  Copyright © 2016 3Pillar Global. All rights reserved.
//

#import "UIView+PDFExporterStatePersistance.h"
#import <objc/runtime.h>

static void * const kUIViewPersistenceStatesAssociatedStorageKey = (void *)&kUIViewPersistenceStatesAssociatedStorageKey;
static void * const kUIViewPersistStateAssociatedStorageKey = (void *)&kUIViewPersistStateAssociatedStorageKey;

@interface UIView (PDFExporterStatePersistancePrivate)

@property (nonatomic) NSMutableArray *persistenceStates;

@end

@implementation UIView (PDFExporterStatePersistance)

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

- (BOOL)shouldPersistState {
    NSNumber *persistStateNumber = objc_getAssociatedObject(self, kUIViewPersistStateAssociatedStorageKey);
    return [persistStateNumber boolValue];
}

- (void)setPersistState:(BOOL)persistState {
    NSNumber *persistStateNumber = nil;
    if (persistState) {
        persistStateNumber = @(persistState);
    }
    objc_setAssociatedObject(self, kUIViewPersistStateAssociatedStorageKey, persistStateNumber, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

#pragma mark - Public Interface

- (void)saveState {
    if (![self shouldPersistState]) {
        return;
    }
    UIViewPersistenceState *state = [[self stateClass] new];
    [self configureState:state];
    [self.persistenceStates addObject:state];
}

- (void)restoreState {
    if (![self shouldPersistState]) {
        return;
    }
    UIViewPersistenceState *state = [self.persistenceStates lastObject];
    [self performRestoreWithState:state];
    [self.persistenceStates removeLastObject];
}

#pragma mark - StatePersistanceSubclassing

- (Class)stateClass {
    return [UIViewPersistenceState class];
}

- (void)configureState:(UIViewPersistenceState *)state {
    state.frame = self.frame;
}

- (void)performRestoreWithState:(UIViewPersistenceState *)state {
    self.frame = state.frame;
}

@end

@implementation UIViewPersistenceState

@end
