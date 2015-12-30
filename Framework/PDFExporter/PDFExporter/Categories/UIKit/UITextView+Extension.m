//
//  UITextView+Extension.m
//  PDFExporter
//
//  Copyright © 2015 3Pillar Global. All rights reserved.
//

#import "UITextView+Extension.h"
#import "UIView+SubclassExtension.h"

@implementation UITextView (Extension)

- (void)drawContentWithPath:(UIBezierPath *)path {
    [super drawContentWithPath:path];
    
    CGRect rect = path.bounds;
    UIEdgeInsets inset = self.textContainerInset;
    CGFloat fragmentPadding = self.textContainer.lineFragmentPadding;
    CGRect textFrame = CGRectMake(CGRectGetMinX(rect) + fragmentPadding,
                                  CGRectGetMinY(rect) + inset.top,
                                  CGRectGetWidth(rect) - fragmentPadding * 2.f,
                                  CGRectGetHeight(rect) - (inset.top + inset.bottom));
    [self drawTextInRect:textFrame];
}

- (void)drawTextInRect:(CGRect)rect {
    NSAttributedString *attrString = self.attributedText;
    NSMutableAttributedString *mutableAttrString = [attrString mutableCopy];
    
    NSMutableDictionary *textAttributes = [[attrString attributesAtIndex:0 effectiveRange:nil] mutableCopy];
    
    NSMutableParagraphStyle *style = [[textAttributes valueForKey:NSParagraphStyleAttributeName] mutableCopy];
    
    if (style) {
        style.lineBreakMode = NSLineBreakByWordWrapping;
        [mutableAttrString addAttribute:NSParagraphStyleAttributeName value:style range:NSMakeRange(0, attrString.length)];
    }
    
    [mutableAttrString drawInRect:rect];
}

@end
