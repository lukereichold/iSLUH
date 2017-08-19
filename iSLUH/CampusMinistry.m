#import "CampusMinistry.h"
#import "PBWebViewController.h"
#import "Reachability.h"
#import "UIColor+SLUHCustom.h"
#import "Convenience.h"
#import "NSURL+SLUHCustom.h"

@interface CampusMinistry ()

@property (strong, nonatomic) Reachability *reachability;
@property (strong, nonatomic) PBWebViewController *webController;

@end

@implementation CampusMinistry

- (void)viewDidLoad {
    
    self.reachability = [Reachability reachabilityForInternetConnection];
	self.navigationItem.title = @"Campus Ministry";
    [super viewDidLoad];
}

- (void)sendIntention
{
	if ([MFMailComposeViewController canSendMail] == YES)
	{
		MFMailComposeViewController *mailer = [[MFMailComposeViewController alloc]init];
		mailer.navigationBar.tintColor = [UIColor colorWithRed:(19/255.0) green:(59/255.0) blue:(189/255.0) alpha:1];;
		mailer.mailComposeDelegate = self;
		
		[mailer setSubject:@"Rosary Intention"];
		[mailer setMessageBody:@"<p>I have a special intention prayer request for the weekly rosary:</p><br><br><p></p>" isHTML: YES];
		
		[mailer setToRecipients: [NSArray arrayWithObject:@"rosary@sluh.org"]];
		
		if (mailer !=nil)	{
            [self presentViewController:mailer animated:YES completion:nil];
		}
	}
	else {
		UIAlertView *cannotSendMail = [[UIAlertView alloc]initWithTitle:@"Send Feedback" message:@"You need to have a Mail account set up to use this feature." delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
		[cannotSendMail show];
	}
}

- (void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error {
    
	if (result == MFMailComposeResultSent)	{
		NSLog(@"Message sent!");
	}
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (BOOL)shouldAutorotate {
    return YES;
}

- (NSUInteger)supportedInterfaceOrientations {
    
    return ([Convenience isiPad]) ? UIInterfaceOrientationMaskAll : (UIInterfaceOrientationMaskPortrait | UIInterfaceOrientationMaskPortraitUpsideDown);
}


#pragma mark -
#pragma mark Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
	
	switch (section){
            
		case 1: {
			return @"Sodality of Our Lady";
			break;}
		case 2:	{
			return @"Dial-A-Saint";
			break;}	
		default:
			return @"";
			break;
	}
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (section == 0)
        return 2;
    else if (section == 1)
        return 1;
    else
        return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
	switch (indexPath.section) {
		case 0: {
            [[cell textLabel] setTextColor:[UIColor sluhNavy]];
            cell.backgroundColor = [UIColor whiteColor];
			cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            
            if (indexPath.row == 0) {
                cell.textLabel.text = @"Home Page";
            }
            else if (indexPath.row == 1) {
                cell.textLabel.text = @"Campus Ministry Twitter";
            }
			break;
        }
		case 1:{
			cell.backgroundColor = [UIColor sluhNavy];
			[[cell textLabel] setTextColor:[UIColor whiteColor]];
			cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
			cell.textLabel.text = @"E-Mail Special Intentions";
			break;
        }
		case 2:{
			[[cell textLabel] setTextColor:[UIColor sluhNavy]];
			cell.textLabel.text = @"314-421-4775";
			cell.accessoryType = UITableViewCellAccessoryNone;
			cell.backgroundColor = [UIColor whiteColor];
            cell.userInteractionEnabled = NO;
			break;
        }
	}
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
   	
    NetworkStatus networkStatus = [self.reachability currentReachabilityStatus];
    if (networkStatus == NotReachable) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Connection Unsuccessful" message:@"Unable to connect to the internet. Please check your network connection and try again." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    } else {
        
        if (indexPath.section == 0)	{
            
            if (indexPath.row == 0) {
                self.webController = [[PBWebViewController alloc] initWithURL:[NSURL sluhCampusMinistry] title:@"Campus Ministry"];
                [self setBackButtonText:@"Ministry"];
                [self.navigationController pushViewController:self.webController animated:YES];
            }
            else if (indexPath.row == 1) {
                self.webController = [[PBWebViewController alloc] initWithURL:[NSURL sluhCampusMinistryTwitter] title:@"Ministry - Twitter"];
                [self setBackButtonText:@"Ministry"];
                [self.navigationController pushViewController:self.webController animated:YES];
            }
        }
        else if (indexPath.section == 1)	{
            [self sendIntention];
        }
    }
}

- (void)setBackButtonText:(NSString *)text {
    UIBarButtonItem *newBackButton = [[UIBarButtonItem alloc] initWithTitle:text style: UIBarButtonItemStylePlain target: nil action: nil];
    [[self navigationItem] setBackBarButtonItem: newBackButton];
}

@end
