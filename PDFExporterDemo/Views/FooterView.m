//
//  FooterView.m
//  PDFExporterDemo
//
//  Copyright © 2015 3Pillar Global. All rights reserved.
//

#import "FooterView.h"

static NSString * const kPageLabelFormat = @"%lu / %lu";

@interface FooterView ()

@property (weak, nonatomic) IBOutlet UILabel *pageLabel;

@end

@implementation FooterView

- (instancetype)initFromXib {
    self = [self init];
    
    if (self) {
        NSArray<UIView *> *xibViews = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class])
                                                                    owner:self
                                                                  options:nil];
        UIView *view = [xibViews firstObject];
        self.bounds = view.bounds;
        [self addSubview:view];
    }
    
    return self;
}

- (void)updatePageNumber:(NSUInteger)pageNumber totalPages:(NSUInteger)totalPages {
    self.pageLabel.text = [NSString stringWithFormat:kPageLabelFormat, (unsigned long)pageNumber, (unsigned long)totalPages];
}

@end
