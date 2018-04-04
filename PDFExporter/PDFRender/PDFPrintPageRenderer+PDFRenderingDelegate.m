//
//  PDFPrintPageRenderer+PDFRenderingDelegate.m
//  PDFExporter
//
//  Created by David Livadaru on 04/04/2018.
//  Copyright © 2018 3Pillar Global. All rights reserved.
//

#import "PDFPrintPageRenderer+PDFRenderingDelegate.h"

@implementation PDFPrintPageRenderer (PDFRenderingDelegate)

- (CGRect)view:(UIView *)view convertRectToRootView:(CGRect)rect {
    UIView *rootView = nil;
    if ([view isDescendantOfView:self.contentView]) {
        rootView = self.contentView;
    } else if ([view isDescendantOfView:self.headerView]) {
        rootView = self.headerView;
    } else if ([view isDescendantOfView:self.footerView]) {
        rootView = self.footerView;
    } else {
        rootView = view.superview;
    }
    return [view convertRect:rect toView:rootView];
}

- (BOOL)viewShouldSliceSubviews:(UIView *)view {
    return self.shouldSliceViews;
}

@end
