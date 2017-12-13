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

/**
 Translates the point.

 @param point The point.
 @param delta The offset.
 @return The new translated point.
 */
CG_INLINE CGPoint CGPointTranslate(CGPoint point, CGPoint delta)
{
    CGPoint newPoint = point;
    newPoint.x += delta.x;
    newPoint.y += delta.y;
    return newPoint;
}

/**
 Translates the origin of rect with provided offset point.

 @param rect The rect source.
 @param point The offset.
 @return The new rect with translated origin.
 */
CG_INLINE CGRect CGRectOffsetWithCGPoint(CGRect rect, CGPoint point)
{
    CGRect newRect = rect;
    newRect.origin = CGPointTranslate(rect.origin, point);
    return newRect;
}

/**
 Resizes the rect with offset without changing the origin.

 @param rect The rect.
 @param offset The offset resize the
 @return The new rect with resized size.
 */
CG_INLINE CGRect CGRectResizeWithOffset(CGRect rect, CGPoint offset)
{
    CGRect newRect = rect;
    newRect.size.width += offset.x;
    newRect.size.height += offset.y;
    return newRect;
}

/**
 The bounds of the rect.

 @param rect The rect source.
 @return The rectangle with origin as CGPoinZero.
 */
CG_INLINE CGRect CGRectBounds(CGRect rect)
{
    CGRect newRect = CGRectZero;
    newRect.size = rect.size;
    return newRect;
}

/**
 Scales point's x and y with provided factor.

 @param point The point to scale.
 @param factor The factor to apply on scale.
 @return The scaled point.
 */
CG_INLINE CGPoint CGPointScaleByFactor(CGPoint point, CGFloat factor)
{
    return CGPointMake(point.x * factor, point.y * factor);
}

/**
 Scales size's width and height with provided factor.

 @param size The size to scale.
 @param factor The factor to apply on scale.
 @return The scaled size.
 */
CG_INLINE CGSize CGSizeScaleByFactor(CGSize size, CGFloat factor)
{
    return CGSizeMake(size.width * factor, size.height * factor);
}

/**
 Scale rectangle's properties with provided factor,

 @param rect The rect to scale.
 @param factor The factor to apply on scale.
 @return The scaled rect.
 */
CG_INLINE CGRect CGRectScaleByFactor(CGRect rect, CGFloat factor)
{
    CGRect scaledRect;
    scaledRect.origin = CGPointScaleByFactor(rect.origin, factor);
    scaledRect.size = CGSizeScaleByFactor(rect.size, factor);
    return scaledRect;
}

/**
 Ceil size's width and height.

 @param size The size to ceil.
 @return The size with ceiled values.
 */
CG_INLINE CGSize CGSizeCeil(CGSize size)
{
    return CGSizeMake(ceilf(size.width), ceilf(size.height));
}

/**
 Ceil rectangle's properties.

 @param rect The rect to ceil.
 @return The rect with ceiled values.
 */
CG_INLINE CGRect CGRectCeil(CGRect rect)
{
    return CGRectMake(ceilf(rect.origin.x), ceilf(rect.origin.y),
                      ceilf(rect.size.width), ceilf(rect.size.height));
}

/**
 Applies minus the x and t.

 @param point The point to update
 @return The minus point.
 */
CG_INLINE CGPoint CGPointMinus(CGPoint point)
{
    return CGPointMake(-point.x, -point.y);
}

CF_ASSUME_NONNULL_END

#endif /* CGGeometry_Additions_h */
