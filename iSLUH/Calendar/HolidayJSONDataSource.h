#import "Kal.h"

@class Calendar;

/*
 *    HolidayJSONDataSource
 *    ---------------------
 *
 *  This example data source retrieves world holidays
 *  from a JSON resource located at http://keith.lazuka.org/holidays.json.
 *  It uses Stig Brautaset's JSON library to parse the JSON and store
 *  it in an array of Holiday objects.
 *
 */
@interface HolidayJSONDataSource : NSObject <KalDataSource>
{
  NSMutableArray *items;
  NSMutableArray *events;
  NSMutableData *buffer;
  id<KalDataSourceCallbacks> callback;
    NSArray *array;
  BOOL dataReady;
}

@property (nonatomic, retain) NSArray *array;

-(void) loadCalendarWithEvents;
-(NSString *)archivePathForArray;
-(NSString *)archivePathForBuffer;
-(void)archiveArray;
-(void)archiveBuffer;
+ (HolidayJSONDataSource *)dataSource;
- (Calendar *)eventAtIndexPath:(NSIndexPath *)indexPath;  // exposed for HolidayAppDelegate so that it can implement the UITableViewDelegate protocol.

@end
