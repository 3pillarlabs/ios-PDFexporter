//
//  PDFLongContentViewFactory.h
//  PDFExporterTests
//
//  Created by David Livadaru on 21/12/2017.
//  Copyright © 2017 3Pillar Global. All rights reserved.
//

@import UIKit;

@class HeaderFooterView;

NS_ASSUME_NONNULL_BEGIN

@interface PDFLongContentViewFactory : NSObject

@property (nonatomic) UIView *subview1;
@property (nonatomic) UIView *subview2;
@property (nonatomic) UIView *subview3;
@property (nonatomic) UIView *subview4;
@property (nonatomic) UIView *subview5;

@property (nonatomic) UIView *contentView;

@property (nonatomic) HeaderFooterView *headerView;
@property (nonatomic) HeaderFooterView *footerView;

@end

NS_ASSUME_NONNULL_END
