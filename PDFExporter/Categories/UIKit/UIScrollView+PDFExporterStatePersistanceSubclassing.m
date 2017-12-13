//
//  UIScrollView+PDFExporterStatePersistanceSubclassing.m
//  PDFExporter
//
//  Created by David Livadaru on 13/12/2017.
//  Copyright © 2017 3Pillar Global. All rights reserved.
//

#import "UIScrollView+PDFExporterStatePersistanceSubclassing.h"
#import "UIView+PDFExporterStatePersistanceSubclassing.h"
#import "UIScrollViewPersistenceState.h"

@implementation UIScrollView (PDFExporterStatePersistanceSubclassing)

- (Class)stateClass {
    return [UIScrollViewPersistenceState class];
}

- (void)configureState:(UIViewPersistenceState *)state {
    [super configureState:state];

    if (!self.drawEntireContentSize) {
        return;
    }
    UIScrollViewPersistenceState *scrollState = (UIScrollViewPersistenceState *)state;
    scrollState.contentOffset = self.contentOffset;
}

- (void)performRestoreWithState:(UIViewPersistenceState *)state {
    [super performRestoreWithState:state];

    if (!self.drawEntireContentSize) {
        return;
    }
    UIScrollViewPersistenceState *scrollState = (UIScrollViewPersistenceState *)state;
    self.contentOffset = scrollState.contentOffset;
}

@end
