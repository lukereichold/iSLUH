@interface Calendar : NSObject {}

// Properties of every Calendar (or event) object
@property (nonatomic, strong) NSDate *date;
@property (nonatomic, strong) NSDate *endDate;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *eventDescription;
@property (nonatomic, strong) NSString *location;

+ (Calendar *)eventNamed:(NSString *)name description:(NSString *)description date:(NSDate *)date endDate:(NSDate *)endDate location:(NSString *)location;
- (id)initWithName:(NSString *)aName description:(NSString *)aDescription date:(NSDate *)aDate endDate:(NSDate *)aEndDate location:(NSString *)aLocation;
- (NSComparisonResult)compare:(Calendar *)otherHoliday;

@end
