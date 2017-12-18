//
//  UIView+PDFExporterStatePersistanceSubclassing.m
//  PDFExporter
//
//  Created by David Livadaru on 13/12/2017.
//  Copyright © 2017 3Pillar Global. All rights reserved.
//

#import "UIView+PDFExporterStatePersistanceSubclassing.h"
#import "UIView+PDFExporterStatePersistance.h"
#import "UIViewPersistenceState.h"

@implementation UIView (PDFExporterStatePersistanceSubclassing)

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
