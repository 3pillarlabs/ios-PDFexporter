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

CG_INLINE CGRect CGRectOffsetWithCGPoint(CGRect rect, CGPoint point)
{
    rect.origin.x += point.x;
    rect.origin.y += point.y;
    return rect;
}

CG_INLINE CGRect CGRectBounds(CGRect rect)
{
    CGRect newRect = CGRectZero;
    newRect.size = rect.size;
    return newRect;
}

CG_INLINE CGRect CGRectScaleByFactor(CGRect rect, CGFloat factor)
{
    CGRect scaledRect = rect;
    scaledRect.origin.x *= factor;
    scaledRect.origin.y *= factor;
    scaledRect.size.width *= factor;
    scaledRect.size.height *= factor;
    return CGRectMake(ceilf(scaledRect.origin.x), ceilf(scaledRect.origin.y),
                      ceilf(scaledRect.size.width), ceilf(scaledRect.size.height));
}

CF_ASSUME_NONNULL_END


#endif /* CGGeometry_Additions_h */
