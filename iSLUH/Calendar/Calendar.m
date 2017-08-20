#import "Calendar.h"

@implementation Calendar

+ (Calendar*)eventNamed:(NSString *)aName description:(NSString *)aCountry date:(NSDate *)aDate endDate:(NSDate *)aEndDate location:(NSString *)aLocation;
{
	return [[Calendar alloc] initWithName:aName description:aCountry date:aDate endDate:aEndDate location:aLocation];
}


- (id)initWithName:(NSString *)aName description:(NSString *)aDescription date:(NSDate *)aDate endDate:(NSDate *)aEndDate location:(NSString *)aLocation
{
	if ((self = [super init])) {
		self.name = [aName copy];
		self.eventDescription = [aDescription copy];
		self.date = aDate;
		self.endDate = aEndDate;
		self.location = [aLocation copy];
	}
	return self;
}

- (NSComparisonResult)compare:(Calendar *)otherHoliday
{
	NSComparisonResult comparison = [self.date compare:otherHoliday.date];
	if (comparison == NSOrderedSame)
		return [self.name compare:otherHoliday.name];
	else
		return comparison;
}


@end


