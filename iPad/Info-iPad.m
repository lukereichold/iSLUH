#import "Info-iPad.h"
#import "UIColor+SLUHCustom.h"
#import "NSURL+SLUHCustom.h"

@interface Info_iPad ()

@property (nonatomic, strong) IBOutlet UIButton *feedbackButton;
@property (nonatomic, strong) IBOutlet UILabel *titleLabel;
@property (nonatomic, retain) IBOutletCollection(UILabel) NSArray *labelsCollection;

@end

@implementation Info_iPad

- (IBAction)sendFeedback:(id)sender
{
	if ([MFMailComposeViewController canSendMail] == YES)
	{
		MFMailComposeViewController *mailer = [[MFMailComposeViewController alloc]init];
		mailer.navigationBar.tintColor = [UIColor blueColor];
		mailer.mailComposeDelegate = self;
		
		[mailer setSubject:@"iSLUH Feedback"];
		[mailer setMessageBody:@"<p>I have some feedback on the iSLUH app:</p><br><br><p></p>" isHTML: YES];
		
		[mailer setToRecipients: [NSArray arrayWithObject:@"sluhiphone@gmail.com"]];
		
		if (mailer !=nil)	{
			[self.navigationController presentViewController:mailer animated:YES completion:nil];
		}
	}
	else {
		UIAlertView *cannotSendMail = [[UIAlertView alloc]initWithTitle:@"Send Feedback" message:@"You need to have a Mail account set up to use this feature." delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
		[cannotSendMail show];
	}
}

# pragma mark - 
# pragma mark MFMailComposeViewControllerDelegate


- (void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error
{
	if (result == MFMailComposeResultSent)	{
		NSLog(@"Message sent!");
	}
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark -

- (void)viewDidLoad {
	
    self.titleLabel.font = [UIFont fontWithName:@"Bree Serif" size:60];
    
    [self createBackgroundGradientWithTopColor:[UIColor colorWithRed:250/255.0 green:250/255.0 blue:250/255.0 alpha:1] bottomColor:[UIColor sluhWarmGrey]];
    
    for (UILabel *label in self.labelsCollection)
    {
        label.font = [UIFont fontWithName:@"Ubuntu" size:28];
        label.textColor = [UIColor sluhNavy];
    }
    
	self.navigationItem.title = @"About iSLUH";
    [super viewDidLoad];
}

- (void)createBackgroundGradientWithTopColor:(UIColor*)topColor bottomColor:(UIColor*)bottomColor {
    
    CAGradientLayer *gradient = [CAGradientLayer layer];
    gradient.frame = CGRectMake(0, 0, 1200.0, 1200.0);
    gradient.colors = [NSArray arrayWithObjects:(id)[topColor CGColor], (id)[bottomColor CGColor], nil];
    [self.view.layer insertSublayer:gradient atIndex:0];
}

- (IBAction)openPersonalSite {
    [[UIApplication sharedApplication] openURL:[NSURL sluhPersonalSite]];
}

- (BOOL)shouldAutorotate {
    return YES;
}

- (NSUInteger)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskAll;
}

@end