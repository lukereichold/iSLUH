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

@end
