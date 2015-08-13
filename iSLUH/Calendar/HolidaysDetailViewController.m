#import "HolidaysDetailViewController.h"
#import "Calendar.h"

@implementation HolidaysDetailViewController

- (id)initWithEvent:(Calendar *)theEventCal
{
    if ((self = [super init])) {
        myEvent = [theEventCal retain];
    }
    return self;
}

- (void)loadView
{
    UILabel *label = [[[UILabel alloc] initWithFrame:[[UIScreen mainScreen] applicationFrame]] autorelease];
    label.textAlignment = NSTextAlignmentCenter;
    self.view = label;
}

- (void)dealloc
{
    [myEvent release];
    [super dealloc];
}


@end
