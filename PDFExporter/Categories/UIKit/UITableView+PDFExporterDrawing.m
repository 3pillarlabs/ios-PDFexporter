//
//  UITableView+Extension.m
//  PDFExporter
//
//  Copyright © 2016 3Pillar Global. All rights reserved.
//

#import "UITableView+PDFExporterDrawing.h"
#import "UIView+PDFExporterPageInformation.h"
#import "PDFDispatchQueueExtension.h"
#import "CGGeometry+Additions.h"

@implementation UITableView (PDFExporterExtension)

- (CGRect)drawingFrame {
    CGRect drawingFrame = self.frame;
    drawingFrame.size = self.contentSize;
    return drawingFrame;
}

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
        PDFExporter_dispatch_sync_main_queue(^{
            self.contentOffset = offset;
            CGRect frame = self.frame;
            [self layoutIfNeeded];
            self.frame = frame;
            [self layoutHeadersAndFooters];
        });
        
        [super drawSubviewsWithPath:path withinPageRect:rect];
    }
}

- (BOOL)canDrawSubview:(UIView *)subview intersection:(CGRect)intersection {
    if ([subview isKindOfClass:[UIScrollView class]]) {
        return YES;
    } else {
        return [super canDrawSubview:subview intersection:intersection];
    }
}

- (CGRect)subviewRect:(UIView *)subview drawingPageRect:(CGRect)rect {
    if ([subview isKindOfClass:[UIScrollView class]]) {
        return subview.drawingFrame; // hook for cells content view
    } else {
        return [super subviewRect:subview drawingPageRect:rect];
    }
}

#pragma mark - Private

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

#pragma mark - PDFExporterPageInformation

- (BOOL)canLayoutSubview:(UIView *)subview intersection:(CGRect)intersection {
    if ([subview isKindOfClass:[UIScrollView class]]) {
        return NO;
    } else {
        return [super canLayoutSubview:subview intersection:intersection];
    }
}

- (BOOL)shouldConsiderLayoutSubview:(UIView *)subview intersection:(CGRect)intersection {
    if ([subview isKindOfClass:[UIScrollView class]]) {
        return YES;
    } else {
        return [super canLayoutSubview:subview intersection:intersection];
    }
}

- (CGPoint)renderingOffsetForPageRect:(CGRect)rect {
    CGPoint renderingOffset = CGPointZero;
    CGPoint contentOffset = CGPointZero;
    for (CGFloat yCoordinate = CGRectGetMinY(rect);
         yCoordinate < CGRectGetMaxY(rect);
         yCoordinate += CGRectGetHeight(self.bounds)) {
        
        // prepare view for rect section
        contentOffset.y = yCoordinate;
        PDFExporter_dispatch_sync_main_queue(^{
            self.contentOffset = contentOffset;
            CGRect frame = self.frame;
            [self layoutIfNeeded];
            self.frame = frame;
            [self layoutHeadersAndFooters];
        });
        
        // ask subviews their rendering offset
        CGPoint subviewRenderingOffset = [super renderingOffsetForPageRect:rect];
        renderingOffset.y = fmaxf(renderingOffset.y, subviewRenderingOffset.y);
    }
    return renderingOffset;
}

- (CGRect)subviewRect:(UIView *)subview layoutPageRect:(CGRect)rect {
    if ([subview isKindOfClass:[UITableViewCell class]] ||
        [subview isKindOfClass:[UITableViewHeaderFooterView class]]) {
        return subview.drawingFrame;
    } else if ([subview isKindOfClass:[UIScrollView class]]) {
        CGRect scrollViewFrame = subview.drawingFrame;
        scrollViewFrame.origin = self.contentOffset;
        return scrollViewFrame;
    } else {
        return [super subviewRect:subview layoutPageRect:rect];
    }
}

@end
