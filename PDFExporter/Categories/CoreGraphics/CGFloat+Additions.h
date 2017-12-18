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

/**
 Checks if lhs is equal to rhs with specified margin of error.

 @param lhs the first value.
 @param rhs the second value.
 @param marginOfError the margin of error within the check is performed.
 @return YES if the values are equal within specified margin of error, NO otherwise.
 */
CG_INLINE BOOL CGFloatIsEqualPrecision(CGFloat lhs, CGFloat rhs, CGFloat marginOfError)
{
    CGFloat difference = lhs - rhs;
    return fabs(difference) < marginOfError;
}

/**
 Checks if lhs is equal to rhs with 0.001 margin of error.

 @param lhs The first value.
 @param rhs The second value.
 @return YES if the values are equal within specified margin of error, NO otherwise.
 */
CG_INLINE BOOL CGFloatIsEqual(CGFloat lhs, CGFloat rhs)
{
    return CGFloatIsEqualPrecision(lhs, rhs, 0.001f);
}

CF_ASSUME_NONNULL_END

#endif /* CGFloat_Additions_h */
