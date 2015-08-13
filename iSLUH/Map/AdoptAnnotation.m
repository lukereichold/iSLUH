#import "AdoptAnnotation.h"

@implementation AdoptAnnotation

@synthesize coordinate, title, subtitle;

- (id)initWithCoordinates:(CLLocationCoordinate2D)location placeName: placeName description:description	{
	self = [super init];
	if (self != nil)	{
		coordinate = location;
		title = placeName;
		subtitle = description;
	}
	return self;
}

@end
