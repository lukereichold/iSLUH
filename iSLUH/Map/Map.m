#import "Map.h"
#import "PBWebViewController.h"
#import "Convenience.h"

@interface Map ()

@property (strong, nonatomic) PBWebViewController *webController;
@property (nonatomic, strong) IBOutlet MKMapView *myMapView;

@end

@implementation Map

@synthesize coordinate;

- (MKAnnotationView *) mapView:(MKMapView *)mapView viewForAnnotation:(id)annotation {
	
    MKPinAnnotationView *customPinView = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:nil];
    customPinView.canShowCallout = YES;

    customPinView.rightCalloutAccessoryView = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
    customPinView.pinColor = (annotation == sluh) ? MKPinAnnotationColorRed : MKPinAnnotationColorGreen;
	
    customPinView.animatesDrop = YES;
    customPinView.canShowCallout = YES;
	
    return customPinView;
}
 
- (void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control  {
    
    NSString* address = view.annotation.subtitle;
    NSString* url = [NSString stringWithFormat: @"http://maps.apple.com/maps?daddr=%@",
                     [address stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    
    
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:url]];
    NSLog(@"callout annotation.title = %@", view.annotation.title);
}

- (void)viewDidLoad {
	self.navigationItem.title = @"Local Schools";
	
	//CLLocationCoordinate2D coordinate;
	coordinate.latitude = 38.628056;
	coordinate.longitude = -90.4002212;
    
    if ([Convenience isiPad])  {
        self.myMapView.region = MKCoordinateRegionMakeWithDistance(coordinate, 4000, 14000);
    }
    else {
        self.myMapView.region = MKCoordinateRegionMakeWithDistance(coordinate, 16000, 24000);
	}
    
    self.myMapView.delegate = self;
	self.myMapView.mapType = MKMapTypeHybrid;
	
	[self.view addSubview:self.myMapView];
		
	[self addAnnotations];
	[super viewDidLoad];

}

-(void)addAnnotations	{
	
	//Add SLUH to map
	CLLocationCoordinate2D sluhcoordinate = {38.628288, -90.268032};
	sluh = [[AdoptAnnotation alloc]initWithCoordinates:sluhcoordinate placeName:@"St. Louis University High School" description:@"4970 Oakland Ave 63110"];
	[self.myMapView addAnnotation:sluh];
    	
	//Add Vianney to map
	CLLocationCoordinate2D myCoordinate = {38.560952, -90.407288};
	AdoptAnnotation *vianney = [[AdoptAnnotation alloc]initWithCoordinates:myCoordinate placeName:@"St. John Vianney High School" description:@"1311 South Kirkwood Rd. 63122"];
	[self.myMapView addAnnotation:vianney];
    
	//Add CBC to map
	myCoordinate.latitude = 38.6397534; 	
	myCoordinate.longitude = -90.4587706;
	AdoptAnnotation *cbc = [[AdoptAnnotation alloc]initWithCoordinates:myCoordinate placeName:@"Christian Brothers College High School" description:@"1850 De La Salle Dr 63141"];
	[self.myMapView addAnnotation:cbc];	
	
	//Add DeSmet to map
	myCoordinate.latitude = 38.660579;
	myCoordinate.longitude = -90.44564;
	AdoptAnnotation *desmet = [[AdoptAnnotation alloc]initWithCoordinates:myCoordinate placeName:@"De Smet Jesuit High School" description:@"233 North New Ballas Rd 63141"];
	[self.myMapView addAnnotation:desmet];	
    	    
	//Add Priory to map
	myCoordinate.latitude = 38.6441933;
	myCoordinate.longitude = -90.4788494;
	AdoptAnnotation *priory = [[AdoptAnnotation alloc]initWithCoordinates:myCoordinate placeName:@"Saint Louis Priory School" description:@"500 S Mason Rd 63141"];
	[self.myMapView addAnnotation:priory];	
    
	//Add Chaminade to map
	myCoordinate.latitude = 38.6495981;
	myCoordinate.longitude = -90.4070694;
	AdoptAnnotation *chaminade = [[AdoptAnnotation alloc]initWithCoordinates:myCoordinate placeName:@"Chaminade College Preparatory School" description:@"425 S Lindbergh Blvd 63141"];
	[self.myMapView addAnnotation:chaminade];	

    
	//Add Oakville to map
	myCoordinate.latitude = 38.470731;
	myCoordinate.longitude = -90.321906;
	AdoptAnnotation *oakville = [[AdoptAnnotation alloc]initWithCoordinates:myCoordinate placeName:@"Oakville High School" description:@"5557 Milburn Rd 63129"];
	[self.myMapView addAnnotation:oakville];	
		
	//Add Webster to map
	myCoordinate.latitude = 38.590022;
	myCoordinate.longitude = -90.348742;
	AdoptAnnotation *webster = [[AdoptAnnotation alloc]initWithCoordinates:myCoordinate placeName:@"Webster Groves High School" description:@"100 Selma Ave 63119"];
	[self.myMapView addAnnotation:webster];	
	
	//Add Parkway North to map
	myCoordinate.latitude = 38.690356;
	myCoordinate.longitude = -90.470697;
	AdoptAnnotation *pnorth = [[AdoptAnnotation alloc]initWithCoordinates:myCoordinate placeName:@"Parkway North High School" description:@"12860 Fee Fee Rd 63146"];
	[self.myMapView addAnnotation:pnorth];	
	
	//Add St. Marys's to map
	myCoordinate.latitude = 38.5738998;
	myCoordinate.longitude = -90.2499115;
	AdoptAnnotation *stmarys = [[AdoptAnnotation alloc]initWithCoordinates:myCoordinate placeName:@"St. Mary's High School" description:@"4701 S Grand Blvd 63111"];
	[self.myMapView addAnnotation:stmarys];	
    
	//Add Eureka to map
	myCoordinate.latitude = 38.514736;
	myCoordinate.longitude = -90.625925;
	AdoptAnnotation *eureka = [[AdoptAnnotation alloc]initWithCoordinates:myCoordinate placeName:@"Eureka High School" description:@"4525 Missouri 109 63025"];
	[self.myMapView addAnnotation:eureka];	
	
	//Add Kirkwood to map
	myCoordinate.latitude = 38.591472;
	myCoordinate.longitude = -90.424222;
	AdoptAnnotation *kirkwood = [[AdoptAnnotation alloc]initWithCoordinates:myCoordinate placeName:@"Kirkwood High School" description:@"801 W Essex Ave 63122"];
	[self.myMapView addAnnotation:kirkwood];	
	
	//Add Villa to map
	myCoordinate.latitude = 38.640506;
	myCoordinate.longitude = -90.415911;
	AdoptAnnotation *villa = [[AdoptAnnotation alloc]initWithCoordinates:myCoordinate placeName:@"Ville Duchesne Oak Hill School" description:@"801 South Spoede Rd 63131"];
	[self.myMapView addAnnotation:villa];	
	
	//Add Parkway West to map
	myCoordinate.latitude = 38.620647;
	myCoordinate.longitude = -90.533922;
	AdoptAnnotation *pwest = [[AdoptAnnotation alloc]initWithCoordinates:myCoordinate placeName:@"Parkway West High School" description:@"14653 Clayton Rd 63011"];
	[self.myMapView addAnnotation:pwest];	
	
	//Add Ladue to map
	myCoordinate.latitude = 38.639142;
	myCoordinate.longitude = -90.396081;
	AdoptAnnotation *ladue = [[AdoptAnnotation alloc]initWithCoordinates:myCoordinate placeName:@"Ladue Horton Watkins High" description:@"1201 South Warson Rd 63124"];
	[self.myMapView addAnnotation:ladue];	

	//Add Parkway South to map
	myCoordinate.latitude = 38.576689;
	myCoordinate.longitude = -90.510867;
	AdoptAnnotation *psouth = [[AdoptAnnotation alloc]initWithCoordinates:myCoordinate placeName:@"Parkway South High School" description:@"801 Hanna Rd 63021"];
	[self.myMapView addAnnotation:psouth];	

	//Add Mehlville to map
	myCoordinate.latitude = 38.514458;
	myCoordinate.longitude = -90.313267;
	AdoptAnnotation *mehlville = [[AdoptAnnotation alloc]initWithCoordinates:myCoordinate placeName:@"Mehlville High School" description:@"3200 Lemay Ferry Rd 63125"];
	[self.myMapView addAnnotation:mehlville];	
	
	//Add Affton to map
	myCoordinate.latitude = 38.559603;
	myCoordinate.longitude = -90.324242;
	AdoptAnnotation *affton = [[AdoptAnnotation alloc]initWithCoordinates:myCoordinate placeName:@"Affton High School" description:@"8309 Mackenzie Rd 63123"];
	[self.myMapView addAnnotation:affton];	

	//Add Lindbergh to map
	myCoordinate.latitude = 38.528583;
	myCoordinate.longitude = -90.374389;
	AdoptAnnotation *lind = [[AdoptAnnotation alloc]initWithCoordinates:myCoordinate placeName:@"Lindbergh High School" description:@"4900 S Lindbergh Blvd 63126"];
	[self.myMapView addAnnotation:lind];	
	
	//Add Bishop Dubourg to map
	myCoordinate.latitude = 38.581347;
	myCoordinate.longitude = -90.295233;
	AdoptAnnotation *bishop = [[AdoptAnnotation alloc]initWithCoordinates:myCoordinate placeName:@"Bishop Dubourg High School" description:@"5850 Eichelberger St 63109"];
	[self.myMapView addAnnotation:bishop];	
    
    //Add Marquette to map
	myCoordinate.latitude = 38.6240101;
	myCoordinate.longitude = -90.5829586;
	AdoptAnnotation *marquette = [[AdoptAnnotation alloc]initWithCoordinates:myCoordinate placeName:@"Marquette High School" description:@"2351 Clarkson Rd 63017"];
	[self.myMapView addAnnotation:marquette];	
	    
    //Add Notre Dame to map
	myCoordinate.latitude = 38.5235376;
	myCoordinate.longitude = -90.2722264;
	AdoptAnnotation *notredame = [[AdoptAnnotation alloc]initWithCoordinates:myCoordinate placeName:@"Notre Dame High School" description:@"320 East Ripa Ave 63125"];
	[self.myMapView addAnnotation:notredame];	
    
}

- (BOOL)shouldAutorotate {
    return YES;
}

- (NSUInteger)supportedInterfaceOrientations {
    
    return ([Convenience isiPad]) ? UIInterfaceOrientationMaskAll : (UIInterfaceOrientationMaskPortrait | UIInterfaceOrientationMaskPortraitUpsideDown);
}

- (void)setBackButtonText:(NSString *)text {
    UIBarButtonItem *newBackButton = [[UIBarButtonItem alloc] initWithTitle:text style: UIBarButtonItemStyleBordered target: nil action: nil];
    [[self navigationItem] setBackBarButtonItem: newBackButton];
}


@end
