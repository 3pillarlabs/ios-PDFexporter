//
//  UIView+PDFExporterPageInformation.m
//  PDFExporter
//
//  Copyright © 2016 3Pillar Global. All rights reserved.
//

#import "UIView+PDFExporterPageInformation.h"
#import "UIView+PDFExporterViewSlicing.h"
#import "UIView+PDFExporterDrawing.h"
#import "CGGeometry+Additions.h"

@implementation UIView (PDFExporterPageInformation)

- (BOOL)askSubviewsRenderingOffset {
    return YES;
}

- (CGPoint)renderingOffsetForPageRect:(CGRect)rect {
    CGPoint renderingOffset = CGPointZero;
    if (![self askSubviewsRenderingOffset]) {
        return renderingOffset;
    }
    for (UIView *subview in self.subviews) {
        if ([subview isDrawable]) {
            CGRect intersection = [self subviewIntersection:subview pageRect:rect];
            if (CGRectIsNull(intersection) ||                                               // skip subviews that are not visible,
                CGRectGetHeight(intersection) == CGRectGetHeight(subview.drawingFrame)) {   // it is possible to draw them on a page or
                continue;
            }
            CGPoint subviewRenderingOffset = [subview renderingOffsetForPageRect:rect];
            CGFloat subviewYOffset = (subviewRenderingOffset.y) ? fminf(CGRectGetHeight(intersection), subviewRenderingOffset.y) : CGRectGetHeight(intersection);
            if (CGRectGetHeight(rect) == subviewYOffset) { // views that has equal or greater height than the page will not be moved to the next page
                continue;
            }
            renderingOffset.y = fmaxf(renderingOffset.y, subviewYOffset);
        }
    }
    return renderingOffset;
}

- (CGRect)subviewRect:(UIView *)subview pageRect:(CGRect)rect {
    CGRect subviewRect = subview.drawingFrame;
    subviewRect = [self.renderingDelegate view:self convertRectToContentView:subviewRect];
    subviewRect = CGRectOffsetWithCGPoint(subviewRect, CGPointMinus(rect.origin));
    return subviewRect;
}

- (CGRect)subviewIntersection:(UIView *)subview pageRect:(CGRect)rect {
    CGRect subviewRect = [self subviewRect:subview pageRect:rect];
    return CGRectIntersection(subviewRect, CGRectBounds(rect));
}

@end

@implementation UIButton (PDFExporterPageInformationPrivate)

- (BOOL)askSubviewsRenderingOffset {
    return NO;
}

@end

@implementation UIControl (PDFExporterPageInformationPrivate)

- (BOOL)askSubviewsRenderingOffset {
    return NO;
}

@end

@implementation UIImageView (PDFExporterPageInformationPrivate)

- (BOOL)askSubviewsRenderingOffset {
    return NO;
}

@end

@implementation UIInputView (PDFExporterPageInformationPrivate)

- (BOOL)askSubviewsRenderingOffset {
    return NO;
}

@end

@implementation UILabel (PDFExporterPageInformationPrivate)

- (BOOL)askSubviewsRenderingOffset {
    return NO;
}

@end

@implementation UICollectionReusableView (PDFExporterPageInformationPrivate)

- (BOOL)askSubviewsRenderingOffset {
    return NO;
}

@end

@implementation UITableViewCell (PDFExporterPageInformationPrivate)

- (BOOL)askSubviewsRenderingOffset {
    return NO;
}

@end

@implementation UITableViewHeaderFooterView (PDFExporterPageInformationPrivate)

- (BOOL)askSubviewsRenderingOffset {
    return NO;
}

@end