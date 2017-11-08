//
//  SettingsViewController.m
//  PDFExporterDemo
//
//  Copyright © 2015 3Pillar Global. All rights reserved.
//

#import "SettingsViewController.h"
@import PDFExporter;
#import "PaperType.h"

@interface SettingsViewController () <UIPickerViewDataSource, UIPickerViewDelegate, UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIPickerView *paperTypePickerView;
@property (weak, nonatomic) IBOutlet UITextField *topTextField;
@property (weak, nonatomic) IBOutlet UITextField *bottomTextField;
@property (weak, nonatomic) IBOutlet UITextField *leftTextField;
@property (weak, nonatomic) IBOutlet UITextField *rightTextField;

@property (nonatomic) NSArray<PaperType *> *paperTypes;

@end

@implementation SettingsViewController

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.paperTypePickerView.layer.borderWidth = 2.f;
    self.paperTypePickerView.layer.borderColor = [[UIColor lightGrayColor] CGColor];
    self.paperTypes = [PaperType allPaperTypes];
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(scrollViewTapped:)];
    [self.scrollView addGestureRecognizer:tapGesture];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.topTextField.text = [NSString stringWithFormat:@"%.2f", self.contentPaperInsets.top];
    self.bottomTextField.text = [NSString stringWithFormat:@"%.2f", self.contentPaperInsets.bottom];
    self.leftTextField.text = [NSString stringWithFormat:@"%.2f", self.contentPaperInsets.left];
    self.rightTextField.text = [NSString stringWithFormat:@"%.2f", self.contentPaperInsets.right];
    
    __block NSUInteger indexOfSelectedPaperType = NSUIntegerMax;
    [self.paperTypes enumerateObjectsUsingBlock:^(PaperType * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (CGSizeEqualToSize(obj.size, self.paperSize)) {
            indexOfSelectedPaperType = idx;
            *stop = YES;
        }
    }];
    if (indexOfSelectedPaperType != NSUIntegerMax) {
        [self.paperTypePickerView selectRow:indexOfSelectedPaperType inComponent:0 animated:YES];
    }
}

#pragma mark - Button Actions

- (IBAction)doneButtonPressed:(id)sender {
    [self.view endEditing:YES];
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - Gesture Actions

- (void)scrollViewTapped:(UITapGestureRecognizer *)tapGesture {
    [self.view endEditing:YES];
}

#pragma mark - Notification Handling

- (void)keyboardWillShow:(NSNotification *)notification {
    NSDictionary *userInfo = [notification userInfo];
    
    CGRect keyboardFrame = [userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    NSTimeInterval animationDuration = [userInfo[UIKeyboardAnimationDurationUserInfoKey] floatValue];
    NSUInteger animationOptions = [userInfo[UIKeyboardAnimationCurveUserInfoKey] unsignedIntegerValue];
    CGPoint scrollContentOffset = self.scrollView.contentOffset;
    scrollContentOffset.y = CGRectGetHeight(keyboardFrame);
    [UIView animateWithDuration:animationDuration delay:0 options:animationOptions animations:^{
        self.scrollView.contentOffset = scrollContentOffset;
    } completion:nil];
}

- (void)keyboardWillHide:(NSNotification *)notification {
    NSDictionary *userInfo = [notification userInfo];
    
    NSTimeInterval animationDuration = [userInfo[UIKeyboardAnimationDurationUserInfoKey] floatValue];
    NSUInteger animationOptions = [userInfo[UIKeyboardAnimationCurveUserInfoKey] unsignedIntegerValue];
    [UIView animateWithDuration:animationDuration delay:0 options:animationOptions animations:^{
        self.scrollView.contentOffset = CGPointZero;
    } completion:nil];
}

#pragma mark - UITextFieldDelegate

- (void)textFieldDidEndEditing:(UITextField *)textField {
    UIEdgeInsets edgeInsets = self.contentPaperInsets;
    if (textField == self.topTextField) {
        edgeInsets.top = textField.text.floatValue;
    } else if (textField == self.bottomTextField) {
        edgeInsets.bottom = textField.text.floatValue;
    } else if (textField == self.leftTextField) {
        edgeInsets.left = textField.text.floatValue;
    } else { // textField == self.rightTextField
        edgeInsets.right = textField.text.floatValue;
    }
    self.contentPaperInsets = edgeInsets;
    [self.delegate settingsViewController:self didChangePaperInsets:self.contentPaperInsets];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [self.view endEditing:YES];
    return YES;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    static NSCharacterSet *incompatibleCharacterSet = nil;
    if (!incompatibleCharacterSet) {
        NSString *decimalSeparator = [[NSLocale currentLocale] objectForKey:NSLocaleDecimalSeparator];
        NSMutableCharacterSet *characterSet = [NSMutableCharacterSet decimalDigitCharacterSet];
        [characterSet addCharactersInString:decimalSeparator];
        incompatibleCharacterSet = [characterSet invertedSet];
    }
    
    if ([string rangeOfCharacterFromSet:incompatibleCharacterSet].location != NSNotFound) {
        return NO;
    }
    
    return YES;
}

#pragma mark - UIPickerViewDataSource

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return [self.paperTypes count];
}

#pragma mark - UIPickerViewDelegate

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(nullable UIView *)view {
    if (!view) {
        view = [UILabel new];
    }
    if ([view isKindOfClass:[UILabel class]]) {
        UILabel *label = (UILabel *)view;
        label.textAlignment = NSTextAlignmentCenter;
        label.text = self.paperTypes[row].name;
    }
    return view;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    if (row < self.paperTypes.count) {
        [self.delegate settingsViewController:self didChangePaperSize:self.paperTypes[row].size];
    }
}

@end
