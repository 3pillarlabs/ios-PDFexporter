//
//  CGFloat+Additions.h
//  PDFExporter
//
//  Created by David Livadaru on 12/12/2017.
//  Copyright © 2017 3Pillar Global. All rights reserved.
//

#ifndef CGFloat_Additions_h
#define CGFloat_Additions_h

#include <CoreFoundation/CFBase.h>
#include <CoreGraphics/CGBase.h>
#include <CoreGraphics/CGGeometry.h>

CF_ASSUME_NONNULL_BEGIN

CG_INLINE BOOL CGFloatIsEqualPrecision(CGFloat lhs, CGFloat rhs, CGFloat marginOfError)
{
    CGFloat difference = lhs - rhs;
    return difference < marginOfError;
}

CG_INLINE BOOL CGFloatIsEqual(CGFloat lhs, CGFloat rhs)
{
    return CGFloatIsEqualPrecision(lhs, rhs, 0.001f);
}

CF_ASSUME_NONNULL_END

#endif /* CGFloat_Additions_h */
