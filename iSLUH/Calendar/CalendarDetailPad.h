#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@class Calendar;

@interface CalendarDetailPad : UIViewController {
    Calendar *myEvent;
}

- (id)initWithEvent:(Calendar *)event;

@end
