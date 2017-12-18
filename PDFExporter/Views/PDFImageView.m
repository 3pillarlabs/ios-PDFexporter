//
//  PDFImageView.m
//  PDFExporter
//
//  Copyright © 2016 3Pillar Global. All rights reserved.
//

#import "PDFImageView.h"
@import QuartzCore;

NS_ASSUME_NONNULL_BEGIN

@interface PDFImageView ()

@property (nonatomic) CGPDFDocumentRef imageDocument;

@end

@implementation PDFImageView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    
    if (self) {
        [self initialize];
    }
    
    return self;
}

- (nullable instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    
    if (self) {
        [self initialize];
    }
    
    return self;
}

- (void)dealloc {
    CGPDFDocumentRelease(self.imageDocument);
}

- (void)drawRect:(CGRect)rect {
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGPDFPageRef firstPage = CGPDFDocumentGetPage(self.imageDocument, 1);
    NSAssert(firstPage, @"Unable to find first page from PDF file.");
    
    CGRect pageRect = CGPDFPageGetBoxRect(firstPage, kCGPDFMediaBox);
    CGFloat scale = MIN(self.bounds.size.width / pageRect.size.width, self.bounds.size.height / pageRect.size.height);
    
    CGContextSaveGState(context);
    
    CGContextTranslateCTM(context, 0.0, self.bounds.size.height);
    CGContextScaleCTM(context, 1.0, -1.0);
    CGContextScaleCTM(context, scale, scale);
    CGContextDrawPDFPage(context, firstPage);
    
    CGContextRestoreGState(context);
}

#pragma mark - Getters and Setters

- (void)setPDFFileName:(NSString *)PDFFileName {
    if (_PDFFileName != PDFFileName) {
        _PDFFileName = PDFFileName;
        [self loadImage];
    }
}

#pragma mark - Private

- (void)initialize {
    self.bundle = [NSBundle mainBundle];
    self.PDFFileName = @"";
}

- (void)loadImage {
    CGPDFDocumentRelease(self.imageDocument);
    
    //NSString *fileExtension = [self.PDFFileName pathExtension];
    //NSAssert([fileExtension length] == 0 || ([fileExtension length] > 0 && [[fileExtension lowercaseString] compare:@"pdf"] == NSOrderedSame), @"Only PDF files are supported.");
    if ([self.PDFFileName length] > 0) {
        NSString *PDFFile = [self.PDFFileName stringByDeletingPathExtension];
        NSURL *PDFDocumentURL = [self.bundle URLForResource:PDFFile withExtension:@"pdf"];
        NSAssert(PDFDocumentURL != nil, @"Unable to find PDF in main bundle");
        
        self.imageDocument = CGPDFDocumentCreateWithURL((__bridge CFURLRef)PDFDocumentURL);
    }
}

@end

NS_ASSUME_NONNULL_END
