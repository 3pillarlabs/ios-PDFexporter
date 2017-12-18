//
//  UIViewRenderingOffsetTests.m
//  PDFExporterTests
//
//  Created by David Livadaru on 18/12/2017.
//  Copyright © 2017 3Pillar Global. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "PDFPrintPageRenderer.h"
#import "PDFPrintPageRenderer+Private.h"
#import "UIView+PDFExporterPageInformation.h"

NS_ASSUME_NONNULL_BEGIN

@interface PDFLongContentViewFactory : NSObject

+ (UIView *)subview1;
+ (UIView *)subview2;
+ (UIView *)subview3;
+ (UIView *)subview4;
+ (UIView *)subview5;

+ (UIView *)contentView;

@end

@interface UIViewRenderingOffsetTests : XCTestCase

@property (nonatomic) PDFPrintPageRenderer *renderer;

@end

@implementation UIViewRenderingOffsetTests

- (instancetype)init {
    self = [super init];

    if (self) {
        self.renderer = [PDFPrintPageRenderer new];
    }

    return self;
}

- (void)testSubview1RenderingOffset {
    CGRect pageRect = [self.renderer scaledPageRectOffsetForIndex:0];
    UIView *view = [PDFLongContentViewFactory subview1];
    CGPoint offset = [view renderingOffsetForPageRect:pageRect];
    XCTAssertEqual(offset.y, 0.0, @"View does not return correct rendering offset for first page.");
}

- (void)testSubview2RenderingOffset {
    CGRect pageRect = [self.renderer scaledPageRectOffsetForIndex:0];
    UIView *view = [PDFLongContentViewFactory subview2];
    CGPoint offset = [view renderingOffsetForPageRect:pageRect];
    XCTAssertEqual(offset.y, 0.0, @"View does not return correct rendering offset for first page.");
}

- (void)testSubview3RenderingOffset {
    CGRect pageRect = [self.renderer scaledPageRectOffsetForIndex:0];
    UIView *view = [PDFLongContentViewFactory subview3];
    CGPoint offset = [view renderingOffsetForPageRect:pageRect];
    XCTAssertEqual(offset.y, 0.0, @"View does not return correct rendering offset for first page.");
}

- (void)testSubview4RenderingOffset {
    CGRect pageRect = [self.renderer scaledPageRectOffsetForIndex:0];
    UIView *view = [PDFLongContentViewFactory subview4];
    CGPoint offset = [view renderingOffsetForPageRect:pageRect];
    XCTAssertEqual(offset.y, 50.0, @"View does not return correct rendering offset for first page.");
}

- (void)testSubview5RenderingOffset {
    CGRect pageRect = [self.renderer scaledPageRectOffsetForIndex:0];
    UIView *view = [PDFLongContentViewFactory subview5];
    CGPoint offset = [view renderingOffsetForPageRect:pageRect];
    XCTAssertEqual(offset.y, 20.0, @"View does not return correct rendering offset for first page.");
}

- (void)testUIViewRenderingOffset {
    UIView *contentView = [PDFLongContentViewFactory contentView];
    PDFPrintPageRenderer *renderer = [PDFPrintPageRenderer new];
    CGRect pageRect = [renderer scaledPageRectOffsetForIndex:0];
    CGPoint offset = [contentView renderingOffsetForPageRect:pageRect];
    XCTAssertEqual(offset.y, 120.0, @"Content view does not return correct rendering offset for first page.");
}

@end

@implementation PDFLongContentViewFactory

+ (UIView *)subview1 {
    return [[UIView alloc] initWithFrame: CGRectMake(50.0, 30.0, 50.0, 50.0)];
}

+ (UIView *)subview2 {
    return [[UIView alloc] initWithFrame: CGRectMake(300.0, 30.0, 65.0, 80.0)];
}

+ (UIView *)subview3 {
    return [[UIView alloc] initWithFrame: CGRectMake(110.0, 492.0, 80.0, 80.0)];
}

+ (UIView *)subview4 {
    return [[UIView alloc] initWithFrame: CGRectMake(20.0, 562.0, 70.0, 90.0)];
}

+ (UIView *)subview5 {
    return [[UIView alloc] initWithFrame: CGRectMake(200.0, 5920.0, 100.0, 120.0)];
}

+ (UIView *)contentView {
    UIView *contentView = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, 552.0, 1400.0)];

    [contentView addSubview:[self subview1]];
    [contentView addSubview:[self subview2]];
    [contentView addSubview:[self subview3]];
    [contentView addSubview:[self subview4]];
    [contentView addSubview:[self subview5]];

    return contentView;
}

@end

NS_ASSUME_NONNULL_END
