//
//  PDFLongContentViewFactory.m
//  PDFExporterTests
//
//  Created by David Livadaru on 21/12/2017.
//  Copyright © 2017 3Pillar Global. All rights reserved.
//

#import "PDFLongContentViewFactory.h"
#import "HeaderFooterView.h"

@implementation PDFLongContentViewFactory

- (instancetype)init {
    self = [super init];

    if (self) {
        _subview1 = [[UIView alloc] initWithFrame: CGRectMake(50.0, 30.0, 50.0, 50.0)];
        _subview2 = [[UIView alloc] initWithFrame: CGRectMake(300.0, 30.0, 65.0, 80.0)];
        _subview3 = [[UIView alloc] initWithFrame: CGRectMake(110.0, 492.0, 80.0, 80.0)];
        _subview4 = [[UIView alloc] initWithFrame: CGRectMake(20.0, 562.0, 70.0, 90.0)];
        _subview5 = [[UIView alloc] initWithFrame: CGRectMake(200.0, 592.0, 100.0, 120.0)];

        _contentView = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, 552.0, 1400.0)];

        [_contentView addSubview:_subview1];
        [_contentView addSubview:_subview2];
        [_contentView addSubview:_subview3];
        [_contentView addSubview:_subview4];
        [_contentView addSubview:_subview5];

        _headerView = [[HeaderFooterView alloc] initWithFrame:CGRectMake(0.0, 0.0, 552.0, 60.0)];
        _footerView = [[HeaderFooterView alloc] initWithFrame:CGRectMake(0.0, 0.0, 552.0, 60.0)];
    }

    return self;
}

@end
