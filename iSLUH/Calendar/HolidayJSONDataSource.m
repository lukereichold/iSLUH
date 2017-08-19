//#import "JSON/JSON.h"

#import "HolidayJSONDataSource.h"
#import "Calendar.h"

static BOOL IsDateBetweenInclusive(NSDate *date, NSDate *begin, NSDate *end)
{
  return [date compare:begin] != NSOrderedAscending && [date compare:end] != NSOrderedDescending;
}

@interface HolidayJSONDataSource ()
- (NSArray *)holidaysFrom:(NSDate *)fromDate to:(NSDate *)toDate;
- (NSArray *)markedDatesFrom:(NSDate *)fromDate to:(NSDate *)toDate;
@end

@implementation HolidayJSONDataSource

@synthesize array;

+ (HolidayJSONDataSource *)dataSource
{
  return [[[[self class] alloc] init] autorelease];
}

- (id)init
{
  if ((self = [super init])) {
    items = [[NSMutableArray alloc] init];
    events = [[NSMutableArray alloc] init];
    buffer = [[NSMutableData alloc] init];
  }
  return self;
}

- (Calendar *)eventAtIndexPath:(NSIndexPath *)indexPath
{
  return [items objectAtIndex:indexPath.row];
}

#pragma mark UITableViewDataSource protocol conformance

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
  static NSString *identifier = @"MyCell";
  UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
  if (!cell) {
    cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier] autorelease];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.imageView.contentMode = UIViewContentModeScaleAspectFill;
  }

  Calendar *holiday = [self eventAtIndexPath:indexPath];
  //cell.imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"flags/%@.gif", holiday.country]];
  cell.textLabel.text = holiday.name;
  return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
  return [items count];
}

#pragma mark Fetch from the internet

- (void)fetchHolidays {
    
    NSString *path = @"http://tiny.cc/sluhCalendar";
    NSLog(@"Fetching calendar: %@", path);
    dataReady = NO;
    [events removeAllObjects];
    NSURLConnection *conn = [NSURLConnection connectionWithRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:path]] delegate:self];
    [conn start];
}


- (void)loadCalendarWithEvents	{
	NSAutoreleasePool *pool = [[NSAutoreleasePool alloc]init];
	
	NSString *str = [[[NSString alloc] initWithData:buffer encoding:NSUTF8StringEncoding] autorelease];
	array = [[NSArray alloc]init];
	array = [str JSONValue];
	if (!array)
		return;
	
	for (NSDictionary *dict in array) {
		
		CGFloat myStart = [[dict objectForKey:@"start"]floatValue];
		NSDate *startTime = [NSDate dateWithTimeIntervalSince1970:myStart];
		
		CGFloat end = [[dict objectForKey:@"end"]floatValue];
		NSDate *endTime = [NSDate dateWithTimeIntervalSince1970:end];
		
		
		[events addObject:[Calendar eventNamed:[dict objectForKey:@"title"] description:[dict objectForKey:@"description"] date:startTime endDate:endTime location:[dict objectForKey:@"location"] ]];
		startTime = [startTime dateByAddingTimeInterval:86401];
		while([endTime laterDate:startTime] == endTime) {
			[events addObject:[Calendar eventNamed:[dict objectForKey:@"title"] description:[dict objectForKey:@"description"] date:startTime endDate:endTime location:[dict objectForKey:@"location"] ]];
			startTime = [startTime dateByAddingTimeInterval:86400];
		}
	}
	
	dataReady = YES;		// When dataReady = YES (flag)
	
	//Stop the spinner
	[UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
	
	
	[callback loadedDataSource:self];
	
	// These 2 methods store array and buffer in order to use when there is no internet connection
	[self archiveArray];
	[self archiveBuffer];
	[pool release];
}


- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
  [buffer setLength:0];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
  [buffer appendData:data];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
	// Not using NSInvocationConnection or NSQueue simply b/c this is shorter and does what it needs to do
	// When user taps 'Back' button on calendar: nothing happens until the calendar data is loaded, should only take a few seconds as it does not depend on the internet connection
	[self performSelector:@selector(loadCalendarWithEvents) withObject: nil];

}

-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    
	
	UIAlertView *cannotUpdateCalendar = [[UIAlertView alloc]initWithTitle:@"Update Failed" message:@"NOTE: You need to have access to the internet to update this calendar." delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
	[cannotUpdateCalendar show];
	[cannotUpdateCalendar release];
	
	//Basically do the same thing if there was an internet connection, just using archived array and buffer from most recent & successful connection
	
	//Here I retrieve archived array and data, set it equal to local vars
	array = [NSKeyedUnarchiver unarchiveObjectWithFile:[self archivePathForArray]];
	buffer = [NSKeyedUnarchiver unarchiveObjectWithFile:[self archivePathForBuffer]];
	
	
	NSString *str = [[[NSString alloc] initWithData:buffer encoding:NSUTF8StringEncoding] autorelease];
	array = [[NSArray alloc]init];
	array = [str JSONValue];
	if (!array)
		return;
	
	if (buffer.length != 0)	{				// or array is not nil
        
		for (NSDictionary *dict in array) {
			
			CGFloat myStart = [[dict objectForKey:@"start"]floatValue];
			NSDate *startTime = [NSDate dateWithTimeIntervalSince1970:myStart];    // dd = the start time
            
			CGFloat end = [[dict objectForKey:@"end"]floatValue];
			NSDate *endTime = [NSDate dateWithTimeIntervalSince1970:end];
            
			[events addObject:[Calendar eventNamed:[dict objectForKey:@"title"] description:[dict objectForKey:@"description"] date:startTime endDate:endTime location:[dict objectForKey:@"location"] ]];
			startTime = [startTime dateByAddingTimeInterval:86401];
			while([endTime laterDate:startTime] == endTime) {
				[events addObject:[Calendar eventNamed:[dict objectForKey:@"title"] description:[dict objectForKey:@"description"] date:startTime endDate:endTime location:[dict objectForKey:@"location"] ]];
				startTime = [startTime dateByAddingTimeInterval:86400];
			}
		}
	}      
	
	
	dataReady = YES;
	
	//Stop the spinner
	[UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
	
	[callback loadedDataSource:self];
	NSLog(@"HolidaysCalendarDataSource connection failure: %@", error);
}

#pragma mark KalDataSource protocol conformance

- (void)presentingDatesFrom:(NSDate *)fromDate to:(NSDate *)toDate delegate:(id<KalDataSourceCallbacks>)delegate
{
  /* 
   * In this example, I load the entire dataset in one HTTP request, so the date range that is 
   * being presented is irrelevant. So all I need to do is make sure that the data is loaded
   * the first time and that I always issue the callback to complete the asynchronous request
   * (even in the trivial case where we are responding synchronously).
   */
  
  if (dataReady) {
    [callback loadedDataSource:self];
    return;
  }
  
  callback = delegate;
  [self fetchHolidays];
}

- (NSArray *)markedDatesFrom:(NSDate *)fromDate to:(NSDate *)toDate
{
  if (!dataReady)
    return [NSArray array];
  
  return [[self holidaysFrom:fromDate to:toDate] valueForKeyPath:@"date"];
}


-(NSString *)archivePathForArray
{
	NSString *arrayDir = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
	return [arrayDir stringByAppendingPathComponent:@"array.dat"];
}

-(NSString *)archivePathForBuffer
{
	NSString *bufferDir = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
	return [bufferDir stringByAppendingPathComponent:@"buffer.dat"];
}

-(void)archiveArray
{
	[NSKeyedArchiver archiveRootObject:array toFile:[self archivePathForArray]];
}

-(void)archiveBuffer
{
	[NSKeyedArchiver archiveRootObject:buffer toFile:[self archivePathForBuffer]];
}



- (void)loadItemsFromDate:(NSDate *)fromDate toDate:(NSDate *)toDate
{
  if (!dataReady)
    return;
  
  [items addObjectsFromArray:[self holidaysFrom:fromDate to:toDate]];
}

- (void)removeAllItems
{
  [items removeAllObjects];
}

#pragma mark -

- (NSArray *)holidaysFrom:(NSDate *)fromDate to:(NSDate *)toDate
{
  NSMutableArray *matches = [NSMutableArray array];
  for (Calendar *holiday in events)
    if (IsDateBetweenInclusive(holiday.date, fromDate, toDate))
      [matches addObject:holiday];
  
  return matches;
}

- (void)dealloc
{
  [items release];
  [events release];
  [buffer release];
  [super dealloc];
}

@end
