#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>
#import <MessageUI/MFMailComposeViewController.h>

@interface Info : UIViewController <MFMailComposeViewControllerDelegate, UINavigationControllerDelegate> {}

-(IBAction)sendFeedback:(id)sender;

@end