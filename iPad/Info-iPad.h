#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>
#import <MessageUI/MFMailComposeViewController.h>

@interface Info_iPad : UIViewController <MFMailComposeViewControllerDelegate, UINavigationControllerDelegate> {}


-(IBAction)sendFeedback:(id)sender;

@end