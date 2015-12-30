//
//  HeaderView.m
//  PDFExporterDemo
//
//  Copyright © 2015 3Pillar Global. All rights reserved.
//

#import "HeaderView.h"

@implementation HeaderView

- (instancetype)initFromXib {
    self = [self init];
    
    if (self) {
        NSArray<UIView *> *xibViews = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class])
                                                                    owner:self
                                                                  options:nil];
        UIView *view = [xibViews firstObject];
        self.bounds = view.bounds;
        [self addSubview:view];
    }
    
    return self;
}

@end
