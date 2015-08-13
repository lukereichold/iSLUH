#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>
#import <MessageUI/MFMailComposeViewController.h>

@interface CampusMinistry : UITableViewController <MFMailComposeViewControllerDelegate, UINavigationControllerDelegate> {}

- (void)sendIntention;

@end
