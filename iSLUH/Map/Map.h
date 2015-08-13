#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "AdoptAnnotation.h"

@interface Map : UIViewController <MKMapViewDelegate, MKAnnotation> {
	CLLocationCoordinate2D coordinate;
	AdoptAnnotation *sluh;
}

@property (nonatomic, readonly) CLLocationCoordinate2D coordinate;

- (void)addAnnotations;

@end
