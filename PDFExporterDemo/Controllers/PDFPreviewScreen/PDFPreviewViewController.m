//
//  PDFPreviewViewController.m
//  PDFExporter
//
//  Copyright © 2015 3PillarGlobal. All rights reserved.
//

#import "PDFPreviewViewController.h"

static NSString * const kPDFFileName = @"ExportedPDF.pdf";

@interface PDFPreviewViewController () <UIWebViewDelegate>

@property (weak, nonatomic) IBOutlet UIWebView *webView;

@property (nonatomic) NSData *PDFData;

@end

@implementation PDFPreviewViewController

#pragma mark - View Life Cycle

- (instancetype)initWithPDFData:(NSData *)PDFData {
    self = [super init];
    
    if (self) {
        self.PDFData = PDFData;
    }
    
    return self;
}

- (void)viewDidLoad {
	[super viewDidLoad];
    
    [self.webView loadData:self.PDFData MIMEType:@"application/pdf" textEncodingName:@"UTF-8" baseURL:[NSURL URLWithString:@""]];
}

- (IBAction)closeButtonPressed:(UIButton *)sender {
	[self dismissViewControllerAnimated:YES completion:nil];
}

- (BOOL)prefersStatusBarHidden {
    return YES;
}

@end
