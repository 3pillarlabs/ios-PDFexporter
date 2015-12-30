//
//  UILabel+Extension.m
//  PDFExporter
//
//  Copyright © 2015 3Pillar Global. All rights reserved.
//

#import "UILabel+Extension.h"
#import "UIView+SubclassExtension.h"

@implementation UILabel (Extension)

- (void)drawContentWithPath:(UIBezierPath *)path {
    [super drawContentWithPath:path];
    
    [self drawTextInsideRect:path.bounds];
}

- (void)drawTextInsideRect:(CGRect)rect {
    NSAttributedString *attrString = self.attributedText;
    NSMutableAttributedString *mutableAttrString = [attrString mutableCopy];
    
    NSMutableDictionary *textAttributes = [[attrString attributesAtIndex:0 effectiveRange:nil] mutableCopy];
    
    NSMutableParagraphStyle *style = [[textAttributes valueForKey:NSParagraphStyleAttributeName] mutableCopy];
    
    if (style) {
        style.lineBreakMode = NSLineBreakByWordWrapping;
        [mutableAttrString addAttribute:NSParagraphStyleAttributeName value:style range:NSMakeRange(0, attrString.length)];
    }
    
    CGRect textRect = [self.text boundingRectWithSize:CGSizeMake(CGRectGetWidth(rect), CGRectGetHeight(rect))
                                              options:NSStringDrawingUsesLineFragmentOrigin
                                           attributes:textAttributes
                                              context:nil];
    
    textRect = CGRectMake(rect.origin.x,
                          rect.origin.y + ((rect.size.height - textRect.size.height) / 2),
                          rect.size.width,
                          rect.size.height);
    [mutableAttrString drawInRect:rect];
}

@end
