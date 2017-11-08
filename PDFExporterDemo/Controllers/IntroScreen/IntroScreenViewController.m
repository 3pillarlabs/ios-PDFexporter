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

@property (nonatomic) PDFPrintPageRenderer *PDFRenderer;

@end

@implementation IntroScreenViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.PDFRenderer = [PDFPrintPageRenderer new];
    self.PDFRenderer.contentView = self.contentView;
    
    self.PDFRenderer.headerView = [[HeaderView alloc] initFromXib];
    self.PDFRenderer.footerView = [[FooterView alloc] initFromXib];
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
            settingsVC.contentPaperInsets = self.PDFRenderer.paperInsets;
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
}

- (void)settingsViewController:(SettingsViewController *)settingsViewController didChangePaperInsets:(UIEdgeInsets)paperInsets {
    self.PDFRenderer.paperInsets = paperInsets;
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
