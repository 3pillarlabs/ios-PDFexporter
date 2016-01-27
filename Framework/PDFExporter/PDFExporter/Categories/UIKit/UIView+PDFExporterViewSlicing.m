//
//  UIView+PDFExporterViewSlicing.m
//  PDFExporter
//
//  Copyright © 2016 3Pillar Global. All rights reserved.
//

#import "UIView+PDFExporterViewSlicing.h"
#import <objc/runtime.h>
#import "PDFWeakObjectContainer.h"

static void * const kUIViewSliceSubviewsAssociatedStorageKey = (void *)&kUIViewSliceSubviewsAssociatedStorageKey;
static void * const kUIViewRenderingDelegateAssociatedStorageKey = (void *)&kUIViewRenderingDelegateAssociatedStorageKey;

@implementation UIView (PDFExporterViewSlicing)

- (BOOL)shouldSliceSubviews {
    return [self.renderingDelegate viewShouldSliceSubviews:self];
//    NSNumber *sliceSubviewsNumber = objc_getAssociatedObject(self, kUIViewSliceSubviewsAssociatedStorageKey);
//    return [sliceSubviewsNumber boolValue];
}

- (void)setSliceSubviews:(BOOL)sliceSubviews {
//    NSNumber *sliceSubviewsNumber = nil;
//    if (sliceSubviews) {
//        sliceSubviewsNumber = @(sliceSubviews);
//    }
//    objc_setAssociatedObject(self, kUIViewSliceSubviewsAssociatedStorageKey, sliceSubviewsNumber, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (id<PDFRenderingDelegate>)renderingDelegate {
    PDFWeakObjectContainer *container = objc_getAssociatedObject(self, kUIViewRenderingDelegateAssociatedStorageKey);
    if (!container) {
        return [self.superview renderingDelegate];
    }
    if (!container.weakObject) {
        self.renderingDelegate = nil;
    }
    return container.weakObject;
}

- (void)setRenderingDelegate:(id<PDFRenderingDelegate>)renderingDelegate {
    PDFWeakObjectContainer *container = objc_getAssociatedObject(self, kUIViewRenderingDelegateAssociatedStorageKey);
    if (renderingDelegate == container.weakObject) {
        return;
    }
    PDFWeakObjectContainer *newContainer = nil;
    if (renderingDelegate) {
        newContainer = [PDFWeakObjectContainer new];
        newContainer.weakObject = renderingDelegate;
    }
    objc_setAssociatedObject(self, kUIViewRenderingDelegateAssociatedStorageKey, newContainer, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end
