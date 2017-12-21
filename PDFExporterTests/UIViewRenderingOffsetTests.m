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
#import "PDFLongContentViewFactory.h"
#import "UIView+PDFExporterViewSlicing.h"

NS_ASSUME_NONNULL_BEGIN

@interface UIViewRenderingOffsetTests : XCTestCase

@property (nonatomic) PDFLongContentViewFactory *factory;
@property (nonatomic) PDFPrintPageRenderer *renderer;
@property (nonatomic) CGRect pageRect;

@end

@implementation UIViewRenderingOffsetTests

- (void)setUp {
    [super setUp];

    self.factory = [PDFLongContentViewFactory new];
    self.renderer = [PDFPrintPageRenderer new];
    self.renderer.contentView = [self.factory contentView];
    self.renderer.contentView.renderingDelegate = self.renderer;
    self.renderer.headerView = [self.factory headerView];
    self.renderer.footerView = [self.factory footerView];
    CGRect rect = self.renderer.contentRect;
    rect.origin.x = 0.0f;
    rect.origin.y = 0.0f;
    self.pageRect = rect;
}

- (void)tearDown {
    [super tearDown];
}

- (void)testSubview1RenderingOffset {
    CGRect pageRect = [self.renderer scaledPageRectOffsetForIndex:0];
    UIView *view = [self.factory subview1];
    CGPoint offset = [view renderingOffsetForPageRect:pageRect];
    XCTAssertEqual(offset.y, 0.0, @"View does not return correct rendering offset for first page.");
}

- (void)testSubview2RenderingOffset {
    UIView *view = [self.factory subview2];
    CGPoint offset = [view renderingOffsetForPageRect:self.pageRect];
    XCTAssertEqual(offset.y, 0.0, @"View does not return correct rendering offset for first page.");
}

- (void)testSubview3RenderingOffset {
    UIView *view = [self.factory subview3];
    CGPoint offset = [view renderingOffsetForPageRect:self.pageRect];
    XCTAssertEqual(offset.y, 0.0, @"View does not return correct rendering offset for first page.");
}

- (void)testSubview4RenderingOffset {
    UIView *view = [self.factory subview4];
    CGPoint offset = [view renderingOffsetForPageRect:self.pageRect];
    XCTAssertEqual(offset.y, 50.0, @"View does not return correct rendering offset for first page.");
}

- (void)testSubview5RenderingOffset {
    UIView *view = [self.factory subview5];
    CGPoint offset = [view renderingOffsetForPageRect:self.pageRect];
    XCTAssertEqual(offset.y, 20.0, @"View does not return correct rendering offset for first page.");
}

- (void)testUIViewRenderingOffset {
    CGPoint offset = [self.renderer.contentView renderingOffsetForPageRect:self.pageRect];
    XCTAssertEqual(offset.y, 120.0, @"Content view does not return correct rendering offset for first page.");
}

@end

NS_ASSUME_NONNULL_END
