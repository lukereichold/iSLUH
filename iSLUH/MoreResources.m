#import "MoreResources.h"
#import "Map.h"
#import "CampusMinistry.h"
#import "PBWebViewController.h"
#import "Reachability.h"
#import "Convenience.h"
#import "NSURL+SLUHCustom.h"
#import "UIColor+SLUHCustom.h"

@interface MoreResources ()

@property (strong, nonatomic) PBWebViewController *webController;
@property (strong, nonatomic) Reachability *reachability;

@property (strong) NSArray<NSString *> *resources;

@end

@implementation MoreResources

#pragma mark View lifecycle

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.resources = @[@"SLUH Library", @"PowerTeacher", @"PULSE Student Radio", @"Campus Ministry", @"AlumConnect", @"This Week in Sports", @"SLUH Facebook Page", @"SLUH Twitter"];
    }
    return self;
}

- (void)viewDidLoad {
    
    self.reachability = [Reachability reachabilityForInternetConnection];
	self.navigationItem.title = @"More Resources";
    [super viewDidLoad];
}

- (BOOL)shouldAutorotate {
    return YES;
}

#pragma mark Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
	
	switch (section){
		case 0:	{
			return @"Additional SLUH Resources";
			break;}
		case 1: {
			return @"Online Homework";
			break;}
		default:
			return @"";
			break;
	}
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	switch (section) {
		case 0:	{			// General Resources
			return self.resources.count;
			break;}
		case 1:	{			// Online Homework
			return 4;
			break;}
		default: {
			return 0;
			break;}
	}
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    
    if (indexPath.section == 0) {
        
        [[cell textLabel] setTextColor:[UIColor sluhNavy]];
        [[cell textLabel] setFont:[UIFont fontWithName:@"" size:14]];
        cell.backgroundColor = [UIColor whiteColor];
        
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.detailTextLabel.text = @"";
        
        cell.textLabel.text = [self.resources objectAtIndex:indexPath.row];
    }
    else if (indexPath.section == 1) {
        
        [[cell textLabel] setTextColor:[UIColor whiteColor]];
        [[cell textLabel] setFont:[UIFont fontWithName:@"" size:14]];
        cell.backgroundColor = [UIColor sluhNavy];
        
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.detailTextLabel.text = @"";
        
        switch (indexPath.row) {
            case 0:{
                cell.textLabel.text = @"WebAssign";
                break;}
            case 1:{
                cell.textLabel.text = @"Quia Web";
                break;}
            case 2:{
                cell.textLabel.text = @"BioWeb";
                break;}
            case 3:{
                cell.textLabel.text = @"SLUHdle";
                break;}
            default:
                break;
        }
    }
    
    return cell;
}

#pragma mark -
#pragma mark Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NetworkStatus networkStatus = [self.reachability currentReachabilityStatus];
    if (networkStatus == NotReachable && indexPath.row != 3) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Connection Unsuccessful" message:@"Unable to connect to the internet. Please check your network connection and try again." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    }
    else {
        
        if (indexPath.section == 0) {
            
            if (indexPath.row == 0) {
                self.webController = [[PBWebViewController alloc] initWithURL:[NSURL sluhLibrary] title:@"SLUH Library"];
                [self setBackButtonText:@"Resources"];
                [self.navigationController pushViewController:self.webController animated:YES];
            }
            else if (indexPath.row == 1) {
                self.webController = [[PBWebViewController alloc] initWithURL:[NSURL sluhPowerteacher] title:@"PowerTeacher"];
                [self setBackButtonText:@"Resources"];
                [self.navigationController pushViewController:self.webController animated:YES];
            }
            else if (indexPath.row == 2) {
                self.webController = [[PBWebViewController alloc] initWithURL:[NSURL sluhPulse] title:@"SLUH Pulse"];
                [self setBackButtonText:@"Resources"];
                [self.navigationController pushViewController:self.webController animated:YES];
            }
            else if (indexPath.row == 3) {
                CampusMinistry *myCM = [[CampusMinistry alloc] initWithNibName:@"CampusMinistry" bundle:nil];
                [self setBackButtonText:@"Resources"];
                [self.navigationController pushViewController:myCM animated:YES];
            }
            else if (indexPath.row == 4) {
                self.webController = [[PBWebViewController alloc] initWithURL:[NSURL sluhAlumConnect] title:@"AlumConnect"];
                [self setBackButtonText:@"Resources"];
                [self.navigationController pushViewController:self.webController animated:YES];
            }
            else if (indexPath.row == 5) {
                self.webController = [[PBWebViewController alloc] initWithURL:[NSURL sluhTWISS] title:@"This Week in Sports"];
                [self setBackButtonText:@"Resources"];
                [self.navigationController pushViewController:self.webController animated:YES];
            }
            else if (indexPath.row == 6) {
                self.webController = [[PBWebViewController alloc] initWithURL:[NSURL sluhFacebook] title:@"SLUH Facebook"];
                [self setBackButtonText:@"Resources"];
                [self.navigationController pushViewController:self.webController animated:YES];
            }
            else if (indexPath.row == 7) {
                self.webController = [[PBWebViewController alloc] initWithURL:[NSURL sluhTwitter] title:@"SLUH Twitter"];
                [self setBackButtonText:@"Resources"];
                [self.navigationController pushViewController:self.webController animated:YES];
            }
        }
        
        if (indexPath.section == 1) {
            
            if (indexPath.row == 0) {
                self.webController = [[PBWebViewController alloc] initWithURL:[NSURL sluhWebAssign] title:@"WebAssign"];
                [self setBackButtonText:@"Resources"];
                [self.navigationController pushViewController:self.webController animated:YES];
            }
            else if (indexPath.row == 1) {
                self.webController = [[PBWebViewController alloc] initWithURL:[NSURL sluhQuia] title:@"Quia Web"];
                [self setBackButtonText:@"Resources"];
                [self.navigationController pushViewController:self.webController animated:YES];
            }
            else if (indexPath.row == 2) {
                self.webController = [[PBWebViewController alloc] initWithURL:[NSURL sluhBioweb] title:@"BioWeb"];
                [self setBackButtonText:@"Resources"];
                [self.navigationController pushViewController:self.webController animated:YES];
            }
            else if (indexPath.row == 3) {
                self.webController = [[PBWebViewController alloc] initWithURL:[NSURL sluhMoodle] title:@"SLUHdle"];
                [self setBackButtonText:@"Resources"];
                [self.navigationController pushViewController:self.webController animated:YES];
            }
        }
    }
}

- (void)setBackButtonText:(NSString *)text {
    UIBarButtonItem *newBackButton = [[UIBarButtonItem alloc] initWithTitle:text style: UIBarButtonItemStylePlain target: nil action: nil];
    [[self navigationItem] setBackBarButtonItem: newBackButton];
}

@end
