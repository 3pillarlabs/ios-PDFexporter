//
//  IntroScreenViewController.m
//  PDFExporter
//
//  Copyright © 2015 3PillarGlobal. All rights reserved.
//

#import "IntroScreenViewController.h"

@import PDFExporter;
#import "PDFPreviewViewController.h"
#import "SettingsViewController.h"
#import "HeaderView.h"
#import "FooterView.h"

static NSString * const kPDFFileName = @"ExportedPDF.pdf";

@interface IntroScreenViewController () <SettingsViewControllerDelegate>

@property (weak, nonatomic) IBOutlet UIView *contentView;
@property (nonatomic) FooterView *footerView;
@property (nonatomic) HeaderView *headerView;

@property (nonatomic) PDFPrintPageRenderer *PDFRenderer;

@end

@implementation IntroScreenViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.PDFRenderer = [PDFPrintPageRenderer new];
    self.PDFRenderer.scaleContent = YES;
    self.PDFRenderer.sliceViews = YES; // comment you do not want to slice views
    self.PDFRenderer.contentView = self.contentView;
    self.PDFRenderer.pagingMask = PDFPagingOptionFooter;
    
    self.headerView = [[HeaderView alloc] initFromXib];
    self.PDFRenderer.headerView = self.headerView;
    self.PDFRenderer.scaleHeader = YES;
    self.footerView = [[FooterView alloc] initFromXib];
    self.PDFRenderer.footerView = self.footerView;
    self.footerView.drawingWidth = CGRectGetWidth(self.PDFRenderer.footerRect);
}

- (void)tapContentView:(id)sender {
    [self.view endEditing:YES];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(nullable id)sender {
    if ([segue.destinationViewController isKindOfClass:[UINavigationController class]]) {
        UINavigationController *destinationVC = (UINavigationController *)segue.destinationViewController;
        UIViewController *rootViewController = [destinationVC.viewControllers firstObject];
        if ([rootViewController isKindOfClass:[SettingsViewController class]]) {
            SettingsViewController *settingsVC = (SettingsViewController *)rootViewController;
            settingsVC.paperSize = self.PDFRenderer.paperSize;
            settingsVC.contentPaperInset = self.PDFRenderer.paperInset;
            settingsVC.delegate = self;
        }
    }
}

#pragma mark - Actions

- (IBAction)previewPDFButtonPressed:(UIButton *)sender {
    NSData *PDFData = [self generatePDF];
    [self presentViewController:[[PDFPreviewViewController alloc] initWithPDFData:PDFData] animated:YES completion:nil];
}

#pragma mark - SettingsViewControllerDelegate

- (void)settingsViewController:(SettingsViewController *)settingsViewController didChangePaperSize:(CGSize)paperSize {
    self.PDFRenderer.paperSize = paperSize;
    self.footerView.drawingWidth = CGRectGetWidth(self.PDFRenderer.footerRect);
}

- (void)settingsViewController:(SettingsViewController *)settingsViewController didChangePaperInset:(UIEdgeInsets)paperInset {
    self.PDFRenderer.paperInset = paperInset;
}

#pragma mark - Private

- (NSData *)generatePDF {
    NSData *PDFData = [self.PDFRenderer drawPagesToPDFData];
    NSURL *PDF_URL = [[self documentsFolder] URLByAppendingPathComponent:kPDFFileName];
    NSLog(@"%@", PDF_URL);
    [PDFData writeToURL:PDF_URL atomically:YES];
    return PDFData;
}

- (NSURL *)documentsFolder {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *basePath = [paths firstObject];
    
    return [NSURL fileURLWithPath:basePath];
}

@end
