//
//  UITableView+Extension.m
//  PDFExporter
//
//  Copyright © 2016 3Pillar Global. All rights reserved.
//

#import "UITableView+PDFExporterDrawing.h"

@implementation UITableView (PDFExporterExtension)

- (void)drawSubviewsWithPath:(UIBezierPath *)path withinPageRect:(CGRect)rect {
    CGPoint offset = CGPointZero;
    for (CGFloat yCoordinate = CGRectGetMinY(rect);
         yCoordinate < CGRectGetMaxY(rect);
         yCoordinate += CGRectGetHeight(self.bounds)) {
        offset.y = yCoordinate;
        self.contentOffset = offset;
        [self layoutHeadersAndFooters];
        [self layoutIfNeeded];
        [super drawSubviewsWithPath:path withinPageRect:rect];
    }
}

- (void)layoutHeadersAndFooters {
    for (NSUInteger section = 0; section < self.numberOfSections; ++section) {
        UIView *headerView = [self headerViewForSection:section];
        if (headerView) {
            headerView.frame = [self rectForHeaderInSection:section];
            [headerView layoutIfNeeded];
        }
        UIView *footerView = [self footerViewForSection:section];
        if (footerView) {
            footerView.frame = [self rectForFooterInSection:section];
            [footerView layoutIfNeeded];
        }
    }
}

@end
