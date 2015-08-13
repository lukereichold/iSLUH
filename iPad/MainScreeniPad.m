#import "MainScreeniPad.h"
#import "Sports.h"
#import "Info-iPad.h"
#import "GamesIndex.h"
#import "HolidayJSONDataSource.h"
#import "Kal.h"
#import "MoreResources.h"
#import "CalendarDetailPad.h"
#import "GradientButton.h"
#import "KalViewController.h"
#import "PBWebViewController.h"
#import "PBSafariActivity.h"
#import "MKTickerView.h"
#import "Reachability.h"
#import "NSMutableArray+Shuffling.h"

#define kBgQueue dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0) //1

@interface MainScreeniPad ()

@property (strong, nonatomic) IBOutletCollection(UILabel) NSArray *labelsCollection;
@property (strong, nonatomic) IBOutlet UIButton *moreResourcesButton;
@property (strong, nonatomic) IBOutlet UIButton *infoButton;
@property (strong, nonatomic) IBOutlet UILabel *amdgLabel;

@property (strong, nonatomic) Reachability *reachability;
@property (strong, nonatomic) PBWebViewController *webController;
@property (strong, nonatomic) IBOutlet MKTickerView *tickerView;
@property (strong, nonatomic) NSArray *tickerItems;

@property (strong, nonatomic) IBOutlet UIButton *mailButton;
@property (strong, nonatomic) IBOutlet UIButton *mapsButton;
@property (strong, nonatomic) IBOutlet UILabel *mailLabel;
@property (strong, nonatomic) IBOutlet UILabel *mapsLabel;

@end

@implementation MainScreeniPad


- (IBAction)loadWebFeature:(id)sender {
    
    NetworkStatus networkStatus = [self.reachability currentReachabilityStatus];
    if (networkStatus == NotReachable) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Connection Unsuccessful" message:@"Unable to connect to the internet. Please check your network connection and try again." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
    } else {
        
        switch ([sender tag]) {		// each button has a tag (given in IB) specific to it
            case 1:
            {
                self.webController = [[PBWebViewController alloc] initWithURL:[NSURL sluhPrepNews] title:@"Prep News"];
                [self setBackButtonText:@"Home"];
                [self.navigationController pushViewController:self.webController animated:YES];
                break;
            }
            case 2:
            {
                self.webController = [[PBWebViewController alloc] initWithURL:[NSURL sluhMail] title:@"SLUH Mail"];
                [self setBackButtonText:@"Home"];
                [self.navigationController pushViewController:self.webController animated:YES];
                break;
            }
            case 3:
            {
                self.webController = [[PBWebViewController alloc] initWithURL:[NSURL sluhPowerschool] title:@"PowerSchool"];
                [self setBackButtonText:@"Home"];
                [self.navigationController pushViewController:self.webController animated:YES];
                break;
            }
            case 4:
            {
                self.webController = [[PBWebViewController alloc] initWithURL:[NSURL sluhGoogleDrive] title:@"SLUH Drive"];
                [self setBackButtonText:@"Home"];
                [self.navigationController pushViewController:self.webController animated:YES];
                break;
            }
            default:
                break;
        }
    }
}

- (IBAction)loadMap:(id)sender {
    
    Map *myMap = [[Map alloc] initWithNibName:@"Map" bundle:nil];
    [self setBackButtonText:@"Home"];
    [self.navigationController pushViewController:myMap animated:YES];
}

- (IBAction)loadSportsFeature:(id)sender
{
	Sports *sportsView = [[Sports alloc]initWithNibName:@"Sports" bundle:nil];
    [self setBackButtonText:@"Home"];
	[self.navigationController pushViewController:sportsView animated:YES];
}

- (IBAction)loadGamesIndex:(id)sender
{
	GamesIndex *gamesIndexView = [[GamesIndex alloc]initWithNibName:@"GamesIndex" bundle:nil];
    [self setBackButtonText:@"Home"];
	[self.navigationController pushViewController:gamesIndexView animated:YES];
}

- (IBAction)loadMoreResources:(id)sender
{
	MoreResources *newResources = [[MoreResources alloc]initWithNibName:@"MoreResources" bundle:nil];
    [self setBackButtonText:@"Home"];
	[self.navigationController pushViewController:newResources animated:YES];
}

- (IBAction)loadCalendar:(id)sender
{
	kal = [[KalViewController alloc]init];	
	kal.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Today" style:UIBarButtonItemStyleBordered target:self action:@selector(showAndSelectToday)];
	kal.delegate = self;
	dataSource = [[HolidayJSONDataSource alloc]init];
	kal.dataSource = dataSource;
	self.navigationItem.title = @"Main Calendar";
	
	UIBarButtonItem *newBackButton = [[UIBarButtonItem alloc] initWithTitle:@"Home" style: UIBarButtonItemStyleBordered target: nil action:nil];
	[[self navigationItem] setBackBarButtonItem:newBackButton];
    
	[self.navigationController pushViewController:kal animated:YES];
}

// Action handler for the navigation bar's right bar button item.
- (void)showAndSelectToday {

	[kal showAndSelectDate:[NSDate date]];
}

#pragma mark UITableViewDelegate protocol conformance

// Display a details screen for the selected event/row.
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	Calendar *event = [dataSource eventAtIndexPath:indexPath];
	self.vc = [[CalendarDetailPad alloc]initWithNibName:@"CalendarDetailPad" bundle: nil];
	[self.vc initWithEvent:event];
	[self.navigationController pushViewController:self.vc animated:YES];
	//[event release];
}

- (IBAction)loadInfoFeature:(id)sender
{
	Info_iPad *infoView = [[Info_iPad alloc]initWithNibName:@"Info-iPad" bundle:nil];
    [self setBackButtonText:@"Home"];
	[self.navigationController pushViewController:infoView animated:YES];
}

- (void)setBackButtonText:(NSString *)text {
    UIBarButtonItem *newBackButton = [[UIBarButtonItem alloc] initWithTitle:text style: UIBarButtonItemStyleBordered target: nil action: nil];
    [[self navigationItem] setBackBarButtonItem: newBackButton];
}

- (void)createBackgroundGradientWithTopColor:(UIColor*)topColor bottomColor:(UIColor*)bottomColor {
    
    CAGradientLayer *gradient = [CAGradientLayer layer];
    // gradient.frame = self.view.frame;
    // sufficient to avoid redrawing the gradient after every rotation
    gradient.frame = CGRectMake(0, 0, 1024.0, 1024.0);
    
    gradient.colors = [NSArray arrayWithObjects:(id)[topColor CGColor], (id)[bottomColor CGColor], nil];
    [self.view.layer insertSublayer:gradient atIndex:0];
}



// The following 5 are delegate methods for MKTickerView:

// Note: to get this Ticker to refresh every new time I open up the view, I'm removing the current MKTickerView, killing it, and adding a new one (with new data) in viewWillAppear.

- (UIColor*) backgroundColorForTickerView:(MKTickerView *)vertMenu
{
    return [UIColor sluhLightGrey];
}

- (int) numberOfItemsForTickerView:(MKTickerView *)tabView
{
    if (self.tickerItems != nil)
        return [self.tickerItems count];
    else
        return 0;
}

- (NSString*) tickerView:(MKTickerView *)tickerView titleForItemAtIndex:(NSUInteger)index
{
    id dict = [self.tickerItems objectAtIndex:index];
    if ([dict isKindOfClass:[NSDictionary class]]) {
        
        if ([(NSDictionary *)dict objectForKey:@"Title"]) {
            return [(NSDictionary *)dict objectForKey:@"Title"];
        }
        else return @"";
    }
    else {
        return @"";
    }
}

- (NSString*) tickerView:(MKTickerView *)tickerView valueForItemAtIndex:(NSUInteger)index
{
    id dict = [self.tickerItems objectAtIndex:index];
    if ([dict isKindOfClass:[NSDictionary class]]) {
        
        if ([(NSDictionary *)dict objectForKey:@"Description"]) {
            return [(NSDictionary *)dict objectForKey:@"Description"];
        }
        else return @"";
    }
    else {
        return @"";
    }
}

- (UIImage*) tickerView:(MKTickerView*) tickerView imageForItemAtIndex:(NSUInteger) index
{
    NSString *imageFileName = @"blah";  //send BS link, we don't want an image
    return [UIImage imageNamed:imageFileName];
}

- (void)viewWillAppear:(BOOL)animated {
    
    [self.view setNeedsLayout];
    
    if ([[UIApplication sharedApplication] statusBarOrientation] == UIDeviceOrientationPortrait || [[UIApplication sharedApplication] statusBarOrientation] == UIDeviceOrientationPortraitUpsideDown) {
      
        self.mailButton.frame = CGRectMake(28, 704, 200, 200);
        self.mailLabel.frame = CGRectMake(56, 885, 140, 55);
        
        self.mapsButton.frame = CGRectMake(300, 704, 200, 200);
        self.mapsLabel.frame = CGRectMake(325, 885, 140, 55);
    }
    else {  // landscape
        
        self.mailButton.frame = CGRectMake(804, 131, 200, 200);
        self.mailLabel.frame = CGRectMake(836, 309, 140, 55);
        
        self.mapsButton.frame = CGRectMake(804, 428, 200, 200);
        self.mapsLabel.frame = CGRectMake(834, 613, 140, 55);
    }
    
    double tickerHeight = 28.0;
    self.tickerView = [[MKTickerView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height - tickerHeight, self.view.frame.size.width, tickerHeight)];
    self.tickerView.backgroundColor = [UIColor sluhLightGrey];
    
    self.tickerView.dataSource = self;
    self.tickerView.delegate = self;
    
    [self.view addSubview:self.tickerView];
    
    self.tickerView.userInteractionEnabled = NO;
    self.tickerView.layer.borderWidth = 2;
    self.tickerView.layer.borderColor = [[UIColor whiteColor] CGColor];
    
    self.tickerView.autoresizingMask = (UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin);
    
    
    self.reachability = [Reachability reachabilityForInternetConnection];
    
    NetworkStatus networkStatus = [self.reachability currentReachabilityStatus];
    if (networkStatus != NotReachable) {
        
        dispatch_async(kBgQueue, ^{
            NSData* data = [NSData dataWithContentsOfURL:
                            [NSURL sluhTickerAnnouncements]];
            
            if (data) {
                [self performSelectorOnMainThread:@selector(fetchedData:)
                                       withObject:data waitUntilDone:YES];
            }
        });
    }
}

- (void)viewWillDisappear:(BOOL)animated    {
    
    [self.tickerView removeFromSuperview];
    self.tickerView = nil;
    self.tickerItems = nil;
}

- (void)fetchedData:(NSData *)responseData {
    
    NSError* e = nil;
    NSMutableArray* data = [NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingMutableContainers error:&e];
    [data shuffle];

    if (data.count > 0) {
        //self.tickerItems = nil;
        self.tickerItems = data;
        [self.tickerView reloadData];
    }
}

#pragma mark - View lifecycle

- (void)viewDidLoad {
    
    self.reachability = [Reachability reachabilityForInternetConnection];
    
    [self createBackgroundGradientWithTopColor:[UIColor sluhNavy] bottomColor:[UIColor sluhBlue]];
	self.navigationItem.backBarButtonItem.title = @"Home";
    
    self.amdgLabel.font = [UIFont fontWithName:@"Bree Serif" size:28];
    
    for (UILabel *label in self.labelsCollection)
    {
        label.font = [UIFont fontWithName:@"Ubuntu" size:20];
        label.textColor = [UIColor sluhLightGrey];
    }
    self.moreResourcesButton.titleLabel.shadowColor = [UIColor sluhGold];
    self.moreResourcesButton.titleLabel.font = [UIFont fontWithName:@"Ubuntu" size:26];
    
    [super viewDidLoad];
}

- (BOOL)shouldAutorotate {
    return YES;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return YES;
}

- (NSUInteger)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskAll;
}

-(void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration {
    
    if (toInterfaceOrientation == UIDeviceOrientationPortrait || toInterfaceOrientation == UIDeviceOrientationPortraitUpsideDown) {
        
        self.mailButton.frame = CGRectMake(28, 704, 200, 200);
        self.mailLabel.frame = CGRectMake(56, 885, 140, 55);
        
        self.mapsButton.frame = CGRectMake(300, 704, 200, 200);
        self.mapsLabel.frame = CGRectMake(325, 885, 140, 55);
    }
    else {  // landscape
        
        self.mailButton.frame = CGRectMake(804, 131, 200, 200);
        self.mailLabel.frame = CGRectMake(836, 309, 140, 55);
        
        self.mapsButton.frame = CGRectMake(804, 428, 200, 200);
        self.mapsLabel.frame = CGRectMake(834, 613, 140, 55);
    }
}

@end
