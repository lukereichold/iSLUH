#import <UIKit/UIKit.h>
#import "CalendarDetailPad.h"
#import "GradientButton.h"

@class KalViewController;

@interface MainScreeniPad : UIViewController <UITableViewDelegate> {
    
	KalViewController *kal;
	id dataSource;
}

@property (nonatomic, strong) CalendarDetailPad *vc;

- (IBAction)loadSportsFeature:(id)sender;
- (IBAction)loadWebFeature:(id)sender;
- (IBAction)loadInfoFeature:(id)sender;
- (IBAction)loadCalendar:(id)sender;
- (IBAction)loadGamesIndex:(id)sender;
- (IBAction)loadMoreResources:(id)sender;

@end
