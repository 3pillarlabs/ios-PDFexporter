//
//  CGGeometry+Additions.h
//  PDFExporter
//
//  Copyright © 2015 3Pillar Global. All rights reserved.
//

#ifndef CGGeometry_Additions_h
#define CGGeometry_Additions_h

#include <CoreFoundation/CFBase.h>
#include <CoreGraphics/CGBase.h>
#include <CoreGraphics/CGGeometry.h>

CF_ASSUME_NONNULL_BEGIN

CG_INLINE CGPoint CGPointTranslate(CGPoint point, CGPoint delta)
{
    CGPoint newPoint = point;
    newPoint.x += delta.x;
    newPoint.y += delta.y;
    return newPoint;
}

CG_INLINE CGRect CGRectOffsetWithCGPoint(CGRect rect, CGPoint point)
{
    CGRect newRect = rect;
    newRect.origin = CGPointTranslate(rect.origin, point);
    return newRect;
}

CG_INLINE CGRect CGRectResizeWithOffset(CGRect rect, CGPoint offset)
{
    CGRect newRect = rect;
    newRect.size.width += offset.x;
    newRect.size.height += offset.y;
    return newRect;
}

CG_INLINE CGRect CGRectBounds(CGRect rect)
{
    CGRect newRect = CGRectZero;
    newRect.size = rect.size;
    return newRect;
}

CG_INLINE CGPoint CGPointScaleByFactor(CGPoint point, CGFloat factor)
{
    CGPoint newPoint = point;
    newPoint.x *= factor;
    newPoint.y *= factor;
    return newPoint;
}

CG_INLINE CGSize CGSizeScaleByFactor(CGSize size, CGFloat factor)
{
    CGSize newSize = size;
    newSize.width *= factor;
    newSize.height *= factor;
    return newSize;
}

CG_INLINE CGRect CGRectScaleByFactor(CGRect rect, CGFloat factor)
{
    CGRect scaledRect;
    scaledRect.origin = CGPointScaleByFactor(rect.origin, factor);
    scaledRect.size = CGSizeScaleByFactor(rect.size, factor);
    return scaledRect;
}

CG_INLINE CGSize CGSizeCeil(CGSize size)
{
    return CGSizeMake(ceilf(size.width), ceilf(size.height));
}

CG_INLINE CGRect CGRectCeil(CGRect rect)
{
    return CGRectMake(ceilf(rect.origin.x), ceilf(rect.origin.y),
                      ceilf(rect.size.width), ceilf(rect.size.height));
}

CG_INLINE CGPoint CGPointMinus(CGPoint point)
{
    CGPoint minusPoint;
    minusPoint.x = -point.x;
    minusPoint.y = -point.y;
    return minusPoint;
}

CF_ASSUME_NONNULL_END

#endif /* CGGeometry_Additions_h */
