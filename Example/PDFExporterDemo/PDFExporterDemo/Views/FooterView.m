//
//  FooterView.m
//  PDFExporterDemo
//
//  Copyright © 2015 3Pillar Global. All rights reserved.
//

#import "FooterView.h"

@import PDFExporter;

static NSString * const kPageLabelFormat = @"%lu / %lu";

@interface FooterView ()

@property (weak, nonatomic) IBOutlet UILabel *pageLabel;
@property (weak, nonatomic) IBOutlet UIView *wrapperView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *widthConstraint;

@property (nonatomic, nullable) NSLayoutConstraint *drawingWidthConstraint;

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
        NSArray *constraints = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[view]-0-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(view)];
        [self addConstraints:constraints];
        constraints = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[view]-0-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(view)];
        [self addConstraints:constraints];
    }
    
    return self;
}

- (void)updatePageNumber:(NSUInteger)pageNumber totalPages:(NSUInteger)totalPages {
    self.pageLabel.text = [NSString stringWithFormat:kPageLabelFormat, (unsigned long)pageNumber, (unsigned long)totalPages];
}

- (void)setDrawingWidth:(CGFloat)drawingWidth {
    if (_drawingWidth != drawingWidth) {
        _drawingWidth = drawingWidth;
        
        self.drawingWidthConstraint.active = NO;
        self.drawingWidthConstraint = [NSLayoutConstraint constraintWithItem:self.wrapperView
                                                                   attribute:NSLayoutAttributeWidth
                                                                   relatedBy:NSLayoutRelationEqual
                                                                      toItem:nil
                                                                   attribute:NSLayoutAttributeNotAnAttribute
                                                                  multiplier:1.f
                                                                    constant:_drawingWidth];
    }
}

#pragma mark - PDFExporterDrawing

- (void)prepareForDrawingWithPageSize:(CGSize)size {
    [super prepareForDrawingWithPageSize:size];
    
    if (self.drawingWidth > 0) {
        self.widthConstraint.active = NO;
        self.drawingWidthConstraint.active = YES;
        [self setNeedsLayout];
    }
}

- (void)cleanAfterDrawing {
    [super cleanAfterDrawing];
    
    if (self.drawingWidth > 0) {
        self.drawingWidthConstraint.active = NO;
        self.widthConstraint.active = YES;
        [self setNeedsLayout];
    }
}

@end
