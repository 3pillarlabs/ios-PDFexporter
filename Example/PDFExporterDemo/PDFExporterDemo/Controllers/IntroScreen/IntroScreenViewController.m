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

@interface IntroScreenViewController () <SettingsViewControllerDelegate, UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UIView *contentView;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UILabel *USLabel;

@property (nonatomic) PDFPrintPageRenderer *PDFRenderer;

@end

@implementation IntroScreenViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.PDFRenderer = [PDFPrintPageRenderer new];
    self.PDFRenderer.contentView = self.tableView;
    
    self.PDFRenderer.headerView = [[HeaderView alloc] initFromXib];
    self.PDFRenderer.footerView = [[FooterView alloc] initFromXib];
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:NSStringFromClass([UITableViewCell class])];
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

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([UITableViewCell class]) forIndexPath:indexPath];
    cell.textLabel.text = [NSString stringWithFormat:@"%@", indexPath];
    cell.textLabel.numberOfLines = 0;
    cell.textLabel.textAlignment = NSTextAlignmentCenter;
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return [NSString stringWithFormat:@"%lu", (unsigned long)section];
}

- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section {
    return [NSString stringWithFormat:@"%lu", (unsigned long)section];
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
