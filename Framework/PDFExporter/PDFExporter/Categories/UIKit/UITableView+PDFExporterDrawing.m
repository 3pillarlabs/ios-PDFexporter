//
//  UITableView+Extension.m
//  PDFExporter
//
//  Copyright © 2016 3Pillar Global. All rights reserved.
//

#import "UITableView+PDFExporterDrawing.h"
#import "CGGeometry+Additions.h"

@implementation UITableView (PDFExporterExtension)

- (void)drawViewWithinPageRect:(CGRect)rect {
    CGRect drawingFrame = self.drawingFrame;
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:drawingFrame cornerRadius:self.layer.cornerRadius];
    
    [self drawBackgroundWithPath:path];
    [self drawContentWithPath:path];
    [self drawSubviewsWithPath:path withinPageRect:rect];
    if (self.layer.borderWidth != 0) {
        [self drawBorderWithPath:path];
    }
}

- (void)drawSubviewsWithPath:(UIBezierPath *)path withinPageRect:(CGRect)rect {
    CGPoint offset = CGPointZero;
    for (CGFloat yCoordinate = CGRectGetMinY(rect);
         yCoordinate < CGRectGetMaxY(rect);
         yCoordinate += CGRectGetHeight(self.bounds)) {
        offset.y = yCoordinate;
        self.contentOffset = offset;
        CGRect frame = self.frame;
        [self layoutIfNeeded];
        self.frame = frame;
        [self layoutHeadersAndFooters];
        [super drawSubviewsWithPath:path withinPageRect:rect];
    }
}

- (void)layoutHeadersAndFooters {
    for (NSUInteger section = 0; section < self.numberOfSections; ++section) {
        UIView *headerView = [self headerViewForSection:section];
        if (headerView) {
            headerView.frame = [self rectForHeaderInSection:section];
        }
        UIView *footerView = [self footerViewForSection:section];
        if (footerView) {
            footerView.frame = [self rectForFooterInSection:section];
        }
    }
}

#pragma mark - PDFExpoterPageInformation

- (CGPoint)renderingOffsetForPageRect:(CGRect)rect {
    CGPoint renderingOffset = CGPointZero;
    CGPoint contentOffset = CGPointZero;
    for (CGFloat yCoordinate = CGRectGetMinY(rect);
         yCoordinate < CGRectGetMaxY(rect);
         yCoordinate += CGRectGetHeight(self.bounds)) {
        
        // prepare view for rect section
        contentOffset.y = yCoordinate;
        self.contentOffset = contentOffset;
        CGRect frame = self.frame;
        [self layoutIfNeeded];
        self.frame = frame;
        [self layoutHeadersAndFooters];
        
        // ask subviews their rendering offset
        CGPoint subviewRenderingOffset = [super renderingOffsetForPageRect:rect];
        renderingOffset.y = fmaxf(renderingOffset.y, subviewRenderingOffset.y);
    }
    return renderingOffset;
}

- (CGRect)subviewRect:(UIView *)subview {
    if ([subview isKindOfClass:[UITableViewCell class]] ||
        [subview isKindOfClass:[UITableViewHeaderFooterView class]]) {
        CGRect subviewRect = CGRectOffsetWithCGPoint(subview.drawingFrame, CGPointMinus(self.contentOffset));
        return subviewRect;
    } else {
        return [super subviewRect:subview];
    }
}

@end
