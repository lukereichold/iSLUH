#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>
#import <MapKit/MKAnnotation.h>


@interface AdoptAnnotation : UIViewController <MKAnnotation> {
	CLLocationCoordinate2D coordinate;
	NSString *__weak title;
	NSString *subTitle;
}


@property (nonatomic, readonly) CLLocationCoordinate2D coordinate;
@property (weak, nonatomic, readonly) NSString *title;
@property (weak, nonatomic, readonly) NSString *subtitle;

-(id)initWithCoordinates:(CLLocationCoordinate2D)location placeName:placeName description:description;

@end
