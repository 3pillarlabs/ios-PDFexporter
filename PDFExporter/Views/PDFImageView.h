//
//  PDFImageView.h
//  PDFExporter
//
//  Copyright © 2016 3Pillar Global. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

IB_DESIGNABLE
@interface PDFImageView : UIView

@property (nonatomic) IBInspectable NSString *PDFFileName;
@property (nonatomic) NSBundle *bundle; // default value is mainBundle 

@end

NS_ASSUME_NONNULL_END
