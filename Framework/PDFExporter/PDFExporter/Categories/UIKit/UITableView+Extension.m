//
//  UITableView+Extension.m
//  PDFExporter
//
//  Copyright © 2016 3Pillar Global. All rights reserved.
//

#import "UITableView+Extension.h"
#import "UIView+StatePersistance.h"

@interface UITableViewPersistenceState : UIViewPersistenceState

@property (nonatomic) CGPoint contentOffset;

@end

@implementation UITableViewPersistenceState

@end

@implementation UITableView (Extension)

- (NSArray *)drawingSubviewsForRect:(CGRect)rect {
    NSMutableArray *drawingSubviews = [NSMutableArray new];
    if (self.backgroundView) {
        [drawingSubviews addObject:self.backgroundView];
    }
    if (self.contentSize.height > CGRectGetHeight(self.frame)) { // modify contentOffset only if there are invisible cells
        self.contentOffset = CGPointMake(0, CGRectGetMinY(rect));
    }
    [self layoutIfNeeded];
    [drawingSubviews addObjectsFromArray:[self headerAndFooterViews]];
    [drawingSubviews addObjectsFromArray:self.visibleCells];
    return drawingSubviews;
}

- (NSArray *)headerAndFooterViews {
    NSMutableArray *headerAndFooterViews = [NSMutableArray new];
    for (NSUInteger section = 0; section < self.numberOfSections; ++section) {
        UIView *headerView = [self headerViewForSection:section];
        if (headerView) {
            [headerAndFooterViews addObject:headerView];
            headerView.frame = [self rectForHeaderInSection:section];
            [headerView layoutIfNeeded];
        }
        UIView *footerView = [self footerViewForSection:section];
        if (footerView) {
            [headerAndFooterViews addObject:footerView];
            footerView.frame = [self rectForFooterInSection:section];
            [footerView layoutIfNeeded];
        }
    }
    return headerAndFooterViews;
}

#pragma mark - StatePersistanceSubclassing

- (nullable UIViewPersistenceState *)createState {
    UITableViewPersistenceState *state = [UITableViewPersistenceState new];
    state.contentOffset = self.contentOffset;
    return state;
}

- (void)performRestoreWithState:(UIViewPersistenceState *)state {
    UITableViewPersistenceState *tableState = (UITableViewPersistenceState *)state;
    self.contentOffset = tableState.contentOffset;
}

@end
