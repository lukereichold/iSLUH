#import "MainScreen.h"
#import "Sports.h"
#import "Info.h"
#import "GamesIndex.h"
#import "HolidayJSONDataSource.h"
#import "Kal.h"
#import "MoreResources.h"
#import "CalendarDetailPhone.h"
#import "GradientButton.h"
#import "KalViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "PBWebViewController.h"
#import "MKTickerView.h"
#import "Reachability.h"
#import "NSMutableArray+Shuffling.h"

#define kBgQueue dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0) //1

@interface MainScreen ()

@property (strong, nonatomic) IBOutletCollection(UILabel) NSArray *labelsCollection;
@property (strong, nonatomic) IBOutlet UIButton *moreResourcesButton;
@property (strong, nonatomic) IBOutlet UIButton *infoButton;
@property (strong, nonatomic) IBOutlet UILabel *amdgLabel;

@property (strong, nonatomic) IBOutlet UIButton *newsButton;
@property (strong, nonatomic) IBOutlet UIButton *calendarButton;
@property (strong, nonatomic) IBOutlet UIButton *gradesButton;
@property (strong, nonatomic) IBOutlet UIButton *mailButton;
@property (strong, nonatomic) IBOutlet UIButton *driveButton;
@property (strong, nonatomic) IBOutlet UIButton *gamesButton;
@property (strong, nonatomic) IBOutlet UIButton *sportsButton;
@property (strong, nonatomic) IBOutlet UIButton *mapsButton;

@property (strong, nonatomic) IBOutlet UILabel *newsLabel;
@property (strong, nonatomic) IBOutlet UILabel *calendarLabel;
@property (strong, nonatomic) IBOutlet UILabel *gradesLabel;
@property (strong, nonatomic) IBOutlet UILabel *mailLabel;
@property (strong, nonatomic) IBOutlet UILabel *driveLabel;
@property (strong, nonatomic) IBOutlet UILabel *gamesLabel;
@property (strong, nonatomic) IBOutlet UILabel *sportsLabel;
@property (strong, nonatomic) IBOutlet UILabel *mapsLabel;

@property (strong, nonatomic) Reachability *reachability;
@property (strong, nonatomic) PBWebViewController *webController;
@property (strong, nonatomic) MKTickerView *tickerView;
@property (strong, nonatomic) NSArray *tickerItems;

@end

@implementation MainScreen

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
    kal.title = @"Calendar";
	self.navigationItem.title = @"Main Calendar";
	
    [self setBackButtonText:@"Home"];
	[self.navigationController pushViewController:kal animated:YES];
}

// Action handler for the navigation bar's right bar button item.
- (void)showAndSelectToday
{
	[kal showAndSelectDate:[NSDate date]];
}

#pragma mark UITableViewDelegate protocol conformance

// Display a details screen for the selected event/row.
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	Calendar *event = [dataSource eventAtIndexPath:indexPath];
    
    CalendarDetailPhone *vciphone = [[CalendarDetailPhone alloc]initWithNibName:@"CalendarDetailPhone" bundle: nil];
    [vciphone initWithEvent:event];
    [self.navigationController pushViewController:vciphone animated:YES];
}

- (IBAction)loadInfoFeature:(id)sender
{
	Info *infoView = [[Info alloc]initWithNibName:@"Info" bundle:nil];
    [self setBackButtonText:@"Home"];
	[self.navigationController pushViewController:infoView animated:YES];
}

- (void)createBackgroundGradientWithTopColor:(UIColor*)topColor bottomColor:(UIColor*)bottomColor {
   
    CAGradientLayer *gradient = [CAGradientLayer layer];
    gradient.frame = self.view.frame;
    gradient.colors = [NSArray arrayWithObjects:(id)[topColor CGColor], (id)[bottomColor CGColor], nil];
    [self.view.layer insertSublayer:gradient atIndex:0];
}

- (void)viewDidLoad {
    
    self.reachability = [Reachability reachabilityForInternetConnection];

    [self createBackgroundGradientWithTopColor:[UIColor sluhNavy] bottomColor:[UIColor sluhBlue]];
    
    self.amdgLabel.font = [UIFont fontWithName:@"Bree Serif" size:20];
    
    for (UILabel *label in self.labelsCollection)
    {
        label.font = [UIFont fontWithName:@"Ubuntu" size:16];
        label.textColor = [UIColor sluhLightGrey];
    }
    self.moreResourcesButton.titleLabel.shadowColor = [UIColor sluhGold];
    self.moreResourcesButton.titleLabel.font = [UIFont fontWithName:@"Ubuntu" size:16];
    
    
    if ([Convenience is4InchScreen]) {
        // Use IB settings
        
    } else {    // 3.5" screen (iPhone 4/4S)
        self.amdgLabel.hidden = YES;
        
        self.newsButton.frame = CGRectMake(7, 83, 95, 73);
        self.calendarButton.frame = CGRectMake(124, 71, 85, 85);
        self.gradesButton.frame = CGRectMake(221, 83, 93, 75);
        self.mailButton.frame = CGRectMake(5, 201, 99, 63);
        self.driveButton.frame = CGRectMake(124, 200, 88, 69);
        self.gamesButton.frame = CGRectMake(226, 189, 85, 83);
        self.sportsButton.frame = CGRectMake(8, 303, 100, 93);
        self.mapsButton.frame = CGRectMake(123, 311, 91, 83);
        
        self.newsLabel.frame = CGRectMake(10, 160, 88, 21);
        self.calendarLabel.frame = CGRectMake(129, 160, 76, 21);
        self.gradesLabel.frame = CGRectMake(213, 160, 108, 21);
        self.mailLabel.frame = CGRectMake(-1, 267, 105, 31);
        self.driveLabel.frame = CGRectMake(116, 267, 105, 31);
        self.gamesLabel.frame = CGRectMake(225, 267, 89, 31);
        self.sportsLabel.frame = CGRectMake(-3, 392, 108, 31);
        self.mapsLabel.frame = CGRectMake(115, 392, 105, 31);
        
        self.moreResourcesButton.frame = CGRectMake(188, 407, 132, 54);
        self.infoButton.frame = CGRectMake(5, 423, 22, 22);
    }
    
	self.navigationItem.backBarButtonItem.title = @"Home";
    [super viewDidLoad];
}

- (void)setBackButtonText:(NSString *)text {
    UIBarButtonItem *newBackButton = [[UIBarButtonItem alloc] initWithTitle:text style: UIBarButtonItemStyleBordered target: nil action: nil];
    [[self navigationItem] setBackBarButtonItem: newBackButton];
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
    NSDictionary *thisDict = [self.tickerItems objectAtIndex:index];
    return [thisDict objectForKey:@"Title"];
}

- (NSString*) tickerView:(MKTickerView *)tickerView valueForItemAtIndex:(NSUInteger)index
{
    NSDictionary *thisDict = [self.tickerItems objectAtIndex:index];
    return [thisDict objectForKey:@"Description"];
}

- (UIImage*) tickerView:(MKTickerView*) tickerView imageForItemAtIndex:(NSUInteger) index
{
    NSString *imageFileName = @"blah";  //send BS link, we don't want an image
    return [UIImage imageNamed:imageFileName];
}

- (void)viewWillAppear:(BOOL)animated   {
    
    double tickerHeight = 28.0;
    self.tickerView = [[MKTickerView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height - tickerHeight, 320, tickerHeight)];
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

- (BOOL)shouldAutorotate {
    return YES;
}

- (NSUInteger)supportedInterfaceOrientations {
    return (UIInterfaceOrientationMaskPortrait | UIInterfaceOrientationMaskPortraitUpsideDown);
}

@end