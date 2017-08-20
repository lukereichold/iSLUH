#import "CreateCardsVCiPad.h"
#import "UIColor+SLUHCustom.h"

@implementation CreateCardsVCiPad

- (IBAction)save {
    [self.cardDelegates didCreateCardWithQuestion:self.question.text answer:self.answer.text];
}

- (IBAction)cancel {
    [self.cardDelegates didCancelCardCreation];
}

- (void)viewDidLoad  {
    
    [self createBackgroundGradientWithTopColor:[UIColor colorWithRed:250/255.0 green:250/255.0 blue:250/255.0 alpha:1] bottomColor:[UIColor sluhWarmGrey]];
    
    [self.question setBackgroundColor: [UIColor clearColor]];
    [self.answer setBackgroundColor: [UIColor clearColor]];
    [super viewDidLoad];
}

- (void)createBackgroundGradientWithTopColor:(UIColor*)topColor bottomColor:(UIColor*)bottomColor {
    
    CAGradientLayer *gradient = [CAGradientLayer layer];
    gradient.frame = CGRectMake(0, 0, 1200.0, 1200.0);
    gradient.colors = [NSArray arrayWithObjects:(id)[topColor CGColor], (id)[bottomColor CGColor], nil];
    [self.view.layer insertSublayer:gradient atIndex:0];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if (textField == self.question) {
        [self.answer becomeFirstResponder];
    } else if (textField == self.answer) {
        
        if (self.question.text.length && self.answer.text.length) {
            [textField resignFirstResponder];
            [self save];
        }
    }
    return YES;
}

- (BOOL)shouldAutorotate {
    return YES;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskAll;
}

@end
