#import <UIKit/UIKit.h>
#import "CalendarDetailPhone.h"
#import "GradientButton.h"
#import "MKTickerView.h"

@class KalViewController;

@interface MainScreen : UIViewController <UITableViewDelegate> {
	KalViewController *kal;
	id dataSource;
}

@property (nonatomic, strong) CalendarDetailPhone *vc;

- (IBAction)loadSportsFeature:(id)sender;
- (IBAction)loadWebFeature:(id)sender;
- (IBAction)loadInfoFeature:(id)sender;
- (IBAction)loadCalendar:(id)sender;
- (IBAction)loadGamesIndex:(id)sender;
- (IBAction)loadMoreResources:(id)sender;


@end
