#import "Sports.h"
#import "PBWebViewController.h"
#import "Reachability.h"
#import "UIColor+SLUHCustom.h"
#import "NSURL+SLUHCustom.h"
#import "Convenience.h"

@interface Sports ()

@property (strong, nonatomic) Reachability *reachability;
@property (nonatomic, strong) NSArray *sports;
@property (nonatomic, strong) NSArray *twitterFeeds;
@property (nonatomic, strong) PBWebViewController *webController;

@end

@implementation Sports

- (void)viewDidLoad {
	
    self.reachability = [Reachability reachabilityForInternetConnection];

    self.twitterFeeds = [[NSArray alloc] initWithObjects:@"Baseball", @"Basketball", @"Hockey", @"Lacrosse", @"Rugby", @"Soccer", @"XC/Track", @"Water Polo", @"Athletic Director", nil];
    
	self.sports = [[NSArray alloc] initWithObjects:@"Baseball", @"Basketball", @"Cross-Country", @"Football", @"Golf", @"Hockey", @"Inline Hockey", @"Lacrosse", @"Racquetball", @"Rifle", @"Rugby", @"Soccer", @"Swimming", @"Tennis", @"Track and Field", @"Ultimate Frisbee", @"Volleyball", @"Water Polo", @"Wresting", nil];
    
	self.navigationItem.title = @"Sports";
    [super viewDidLoad];
}

- (BOOL)shouldAutorotate {
    return YES;
}

- (NSUInteger)supportedInterfaceOrientations {
    
    return ([Convenience isiPad]) ? UIInterfaceOrientationMaskAll : (UIInterfaceOrientationMaskPortrait | UIInterfaceOrientationMaskPortraitUpsideDown);
}

#pragma mark Table view methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
	
	switch (section){
		case 0:	{
			return @"Twitter Feeds";
			break;}
		case 1: {
			return @"Sports Webpages";
			break;}		
		default:
			return @"";
			break;
	}
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
	switch (section) {
		case 0:
			return [self.twitterFeeds count];
			break;
		case 1:
			return [self.sports count];
		default:
			return 1;
			break;
	}
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
	
    // Twitter Feed Section (0)
    if (indexPath.section == 0)	{
        [[cell textLabel] setTextColor:[UIColor whiteColor]];
        cell.backgroundColor = [UIColor sluhNavy];

        [[cell textLabel] setText:[self.twitterFeeds objectAtIndex:indexPath.row]];
    }
	
    else if (indexPath.section == 1)	{
        cell.backgroundColor = [UIColor whiteColor];
        [[cell textLabel] setTextColor:[UIColor sluhNavy]];
        [[cell textLabel] setText:[self.sports objectAtIndex:indexPath.row]];
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
        
        // Twitter section
        if (indexPath.section == 0)	{
            
            if (indexPath.row == 0)	{	//Baseball
                self.webController = [[PBWebViewController alloc] initWithURL:[NSURL sluhBaseballTwitter] title:@"SLUH Baseball"];
                [self.navigationController pushViewController:self.webController animated:YES];
            }
            if (indexPath.row == 1)	{	//Basketball
                self.webController = [[PBWebViewController alloc] initWithURL:[NSURL sluhBasketballTwitter] title:@"SLUH Basketball"];
                [self.navigationController pushViewController:self.webController animated:YES];
            }
            else if (indexPath.row == 2)	{	//Hockey
                self.webController = [[PBWebViewController alloc] initWithURL:[NSURL sluhHockeyTwitter] title:@"SLUH Hockey"];
                [self.navigationController pushViewController:self.webController animated:YES];
            }
            else if (indexPath.row == 3)	{	//Lacrosse
                self.webController = [[PBWebViewController alloc] initWithURL:[NSURL sluhLacrosseTwitter] title:@"SLUH Lacrosse"];
                [self.navigationController pushViewController:self.webController animated:YES];
            }
            else if (indexPath.row == 4)	{	//Rugby
                self.webController = [[PBWebViewController alloc] initWithURL:[NSURL sluhRugbyTwitter] title:@"SLUH Rugby"];
                [self.navigationController pushViewController:self.webController animated:YES];
            }
            else if (indexPath.row == 5)	{	//Soccer
                self.webController = [[PBWebViewController alloc] initWithURL:[NSURL sluhSoccerTwitter] title:@"SLUH Soccer"];
                [self.navigationController pushViewController:self.webController animated:YES];
            }
            else if (indexPath.row == 6)	{	//XC/Track
                self.webController = [[PBWebViewController alloc] initWithURL:[NSURL sluhTrackTwitter] title:@"XC/Track"];
                [self.navigationController pushViewController:self.webController animated:YES];
            }
            else if (indexPath.row == 7)	{	//Water Polo
                self.webController = [[PBWebViewController alloc] initWithURL:[NSURL sluhWaterPoloTwitter] title:@"SLUH Water Polo"];
                [self.navigationController pushViewController:self.webController animated:YES];
            }
            else if (indexPath.row == 8)	{	//Athletic Director - Mr. Wehner
                self.webController = [[PBWebViewController alloc] initWithURL:[NSURL sluhADTwitter] title:@"Athletic Director"];
                [self.navigationController pushViewController:self.webController animated:YES];
            }
        }
        
        // Regular SLUH web page section
        if (indexPath.section == 1)	{
            
            if (indexPath.row == 0)	
            {
                self.webController = [[PBWebViewController alloc] initWithURL:[NSURL sluhBaseball] title:@"SLUH Baseball"];
                [self.navigationController pushViewController:self.webController animated:YES];
            }
            else if (indexPath.row == 1)
            {
                self.webController = [[PBWebViewController alloc] initWithURL:[NSURL sluhBasketball] title:@"SLUH Baseketball"];
                [self.navigationController pushViewController:self.webController animated:YES];
            }
            else if (indexPath.row == 2)
            {
                self.webController = [[PBWebViewController alloc] initWithURL:[NSURL sluhXC] title:@"SLUH XC"];
                [self.navigationController pushViewController:self.webController animated:YES];
            }
            else if (indexPath.row == 3)
            {
                self.webController = [[PBWebViewController alloc] initWithURL:[NSURL sluhFootball] title:@"SLUH Football"];
                [self.navigationController pushViewController:self.webController animated:YES];
            }
            else if (indexPath.row == 4)
            {
                self.webController = [[PBWebViewController alloc] initWithURL:[NSURL sluhGolf] title:@"SLUH Golf"];
                [self.navigationController pushViewController:self.webController animated:YES];
            }
            else if (indexPath.row == 5)
            {
                self.webController = [[PBWebViewController alloc] initWithURL:[NSURL sluhHockey] title:@"SLUH Hockey"];
                [self.navigationController pushViewController:self.webController animated:YES];
            }
            else if (indexPath.row == 6)
            {
                self.webController = [[PBWebViewController alloc] initWithURL:[NSURL sluhInlineHockey] title:@"Inline Hockey"];
                [self.navigationController pushViewController:self.webController animated:YES];
            }
            else if (indexPath.row == 7)
            {
                self.webController = [[PBWebViewController alloc] initWithURL:[NSURL sluhLacrosse] title:@"SLUH Lacrosse"];
                [self.navigationController pushViewController:self.webController animated:YES];
            }
            else if (indexPath.row == 8)
            {
                self.webController = [[PBWebViewController alloc] initWithURL:[NSURL sluhRacquetball] title:@"SLUH Racquetball"];
                [self.navigationController pushViewController:self.webController animated:YES];
            }
            else if (indexPath.row == 9)     //rifle
            {
                self.webController = [[PBWebViewController alloc] initWithURL:[NSURL sluhRifle] title:@"SLUH Riflery"];
                [self.navigationController pushViewController:self.webController animated:YES];
            }
            else if (indexPath.row == 10)
            {
                self.webController = [[PBWebViewController alloc] initWithURL:[NSURL sluhRugby] title:@"SLUH Rugby"];
                [self.navigationController pushViewController:self.webController animated:YES];
            }
            else if (indexPath.row == 11)
            {
                self.webController = [[PBWebViewController alloc] initWithURL:[NSURL sluhSoccer] title:@"SLUH Soccer"];
                [self.navigationController pushViewController:self.webController animated:YES];
            }
            else if (indexPath.row == 12)
            {
                self.webController = [[PBWebViewController alloc] initWithURL:[NSURL sluhSwimming] title:@"SLUH Swimming"];
                [self.navigationController pushViewController:self.webController animated:YES];
            }
            else if (indexPath.row == 13)
            {
                self.webController = [[PBWebViewController alloc] initWithURL:[NSURL sluhTennis] title:@"SLUH Tennis"];
                [self.navigationController pushViewController:self.webController animated:YES];
            }
            else if (indexPath.row == 14)
            {
                self.webController = [[PBWebViewController alloc] initWithURL:[NSURL sluhTrack] title:@"SLUH Track"];
                [self.navigationController pushViewController:self.webController animated:YES];
            }
            else if (indexPath.row == 15)
            {
                self.webController = [[PBWebViewController alloc] initWithURL:[NSURL sluhUltimate] title:@"SLUH Ultimate"];
                [self.navigationController pushViewController:self.webController animated:YES];
            }
            else if (indexPath.row == 16)
            {
                self.webController = [[PBWebViewController alloc] initWithURL:[NSURL sluhVolleyball] title:@"SLUH Volleyball"];
                [self.navigationController pushViewController:self.webController animated:YES];
            }
            else if (indexPath.row == 17)
            {
                self.webController = [[PBWebViewController alloc] initWithURL:[NSURL sluhWaterPolo] title:@"SLUH Water Polo"];
                [self.navigationController pushViewController:self.webController animated:YES];
            }
            
            else if (indexPath.row == 18)
            {
                self.webController = [[PBWebViewController alloc] initWithURL:[NSURL sluhWrestling] title:@"SLUH Wrestling"];
                [self.navigationController pushViewController:self.webController animated:YES];
                
            }
        }
    }
}


@end
