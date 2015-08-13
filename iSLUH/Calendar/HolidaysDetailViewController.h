@class Calendar;

/*
 *    HolidaysDetailViewController
 *    ----------------------------
 *
 *  This view controller will be pushed onto the navigation stack
 *  when the user taps the row for a holiday beneath the calendar.
 */

@interface HolidaysDetailViewController : UIViewController
{
  Calendar *myEvent;
}

- (id)initWithEvent:(Calendar *)theEventCal;

@end
