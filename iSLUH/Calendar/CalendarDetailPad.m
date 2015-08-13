#import "CalendarDetailPad.h"
#import "Calendar.h"
#import "NSString+FontAwesome.h"
#import <EventKit/EventKit.h>

@interface CalendarDetailPad ()

@property (nonatomic, strong) IBOutlet UILabel *titleLabel;
@property (nonatomic, strong) IBOutlet UILabel *startTimeLabel;
@property (nonatomic, strong) IBOutlet UILabel *locationLabel;
@property (nonatomic, strong) IBOutlet UILabel *descriptionLabel;
@property (nonatomic, strong) IBOutlet UITextView *descriptionTextView;

@property (nonatomic, strong) IBOutlet UILabel *mapMarkerLabel;
@property (nonatomic, strong) IBOutlet UILabel *descriptionIconLabel;
@property (nonatomic, strong) IBOutlet UILabel *startTimeIconLabel;

@end

@implementation CalendarDetailPad

- (void)viewDidLoad
{
    self.navigationItem.title = @"Event Info";
    
    if ([self respondsToSelector:@selector(edgesForExtendedLayout)])
        self.edgesForExtendedLayout = UIRectEdgeNone;
    
    [self createBackgroundGradientWithTopColor:[UIColor colorWithRed:250/255.0 green:250/255.0 blue:250/255.0 alpha:1] bottomColor:[UIColor sluhWarmGrey]];
    
    if ([Convenience is4InchScreen]) {
        self.descriptionTextView.frame = CGRectMake(5, 263, 310, 285);
    }
    
    // FontAwesome "images"
    self.mapMarkerLabel.font = [UIFont fontWithName:@"FontAwesome" size:20.0];
    self.descriptionIconLabel.font = [UIFont fontWithName:@"FontAwesome" size:20.0];
    self.startTimeIconLabel.font = [UIFont fontWithName:@"FontAwesome" size:20.0];
    
    self.titleLabel.text = myEvent.name;
    self.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
    self.titleLabel.numberOfLines = 0;
    
	NSDateFormatter *format = [[NSDateFormatter alloc] init];
	[format setDateFormat:@"EE M-d-yyyy 'at' h:mm a"];
	[format setLocale:[NSLocale currentLocale]];
	if (myEvent.date != nil && myEvent.endDate != nil) {
		NSString *newStartDate = [format stringFromDate:myEvent.date];
        self.startTimeIconLabel.text = @"\uf042";
		self.startTimeLabel.text = [NSString stringWithFormat:@"%@", newStartDate];
	}
	
	if ([myEvent.location length]) {
        self.locationLabel.text = myEvent.location;
        self.mapMarkerLabel.text = @"\uf041";
    } else {
		[self.locationLabel setHidden: YES];
        [self.mapMarkerLabel setHidden: YES];
	}
    
	if ([myEvent.description length]) {
		self.descriptionTextView.text = [NSString stringWithFormat:@"%@", myEvent.description];
        self.descriptionIconLabel.text = @"\uf0e5";
    } else {
        [self.descriptionIconLabel setHidden: YES];
		[self.descriptionLabel setHidden: YES];
		[self.descriptionTextView setHidden: YES];
	}
}

- (BOOL)shouldAutorotate {
    return YES;
}

- (NSUInteger)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskAll;
}

- (id)initWithEvent:(Calendar *)theEventCal
{
    if ((self = [super init])) {
        myEvent = theEventCal;
    }
    return self;
}



- (IBAction)addEventToCalendar {
    
    EKEventStore* eventStore = [[EKEventStore alloc] init];
    
    if([eventStore respondsToSelector:@selector(requestAccessToEntityType:completion:)]) {
        // >= iOS 6
        
        [eventStore requestAccessToEntityType:EKEntityTypeEvent
                                   completion:^(BOOL granted, NSError *error) {
                                       
                                       // may return on background thread
                                       dispatch_async(dispatch_get_main_queue(), ^{
                                           if (granted) {
                                               EKEvent *event  = [EKEvent eventWithEventStore:eventStore];
                                               event.title     = myEvent.name;
                                               event.location = myEvent.location;
                                               event.startDate = myEvent.date;
                                               event.endDate   = myEvent.endDate;
                                               
                                               [event setCalendar:[eventStore defaultCalendarForNewEvents]];
                                               NSError *err;
                                               
                                               BOOL isSuceess=[eventStore saveEvent:event span:EKSpanThisEvent error:&err];
                                               
                                               if (isSuceess){
                                                   UIAlertView *alertview = [[UIAlertView alloc] initWithTitle:@"Event" message:@"Event successfully added to calendar." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
                                                   [alertview show];
                                               } else {
                                                   NSLog(@"Unable to add to calendar - %@", err);
                                               }
                                               
                                           } else {
                                               NSLog(@"Unable to add to calendar - %@", error);
                                           }
                                       });
                                   }];
    }
    
}

- (void)createBackgroundGradientWithTopColor:(UIColor*)topColor bottomColor:(UIColor*)bottomColor {
    
    CAGradientLayer *gradient = [CAGradientLayer layer];
    gradient.frame = CGRectMake(0, 0, 1024.0, 1024.0);
    gradient.colors = [NSArray arrayWithObjects:(id)[topColor CGColor], (id)[bottomColor CGColor], nil];
    [self.view.layer insertSublayer:gradient atIndex:0];
}

@end