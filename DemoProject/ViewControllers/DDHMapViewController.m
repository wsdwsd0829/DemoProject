//
//  DDHMapViewController.m
//  DoorDashProject
//
//  Created by MAX on 11/29/16.
//  Copyright © 2016 MAX. All rights reserved.
//

#import "DDHMapViewController.h"
#import <MapKit/MapKit.h>

static NSString* kCenterAnnotationIdentifier = @"kCenterAnnotationIdentifier";

@interface DDHMapViewController () <CLLocationManagerDelegate, MKMapViewDelegate> {
    DDHAddress* address;
    CLGeocoder* geocoder;
    CLLocationManager *locationManager;
    MKPointAnnotation *centerAnnotation;
}

@property (nonatomic, weak) IBOutlet MKMapView* mapView;
@property (nonatomic, weak) IBOutlet UIButton* confirmButton;
@property (nonatomic, weak) IBOutlet UILabel* label;

@end

@implementation DDHMapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    address = [DDHAddress new];
    //setup location manager
    locationManager = [[CLLocationManager alloc] init];
    locationManager.delegate = self;
    locationManager.distanceFilter = kCLDistanceFilterNone;
    locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    [locationManager requestWhenInUseAuthorization];
    [locationManager startUpdatingLocation];
    
    //geocoding
    geocoder = [CLGeocoder new];
    
    //setup annotation
    //[self setAnnotationPoint];
    
    //set up mapView
    self.mapView.showsUserLocation = YES;
    self.mapView.delegate = self;
}

-(void) setAnnotationPoint {
   // [centerAnnotation setCoordinate: [self.mapView convertPoint:self.mapView.center toCoordinateFromView:self.mapView]];
    /*
    [self.mapView removeAnnotation:centerAnnotation];
    MKPointAnnotation *pa = [[MKPointAnnotation alloc] init];
    pa.coordinate = [self.mapView convertPoint:self.mapView.center toCoordinateFromView:self.mapView];
    pa.title = @"Map Center";
    pa.subtitle = [NSString stringWithFormat:@"%f, %f", pa.coordinate.latitude, pa.coordinate.longitude];
    centerAnnotation = pa;
    [self.mapView addAnnotation:pa];*/
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//MARK: action
- (IBAction)dismissMap:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)confirmClicked:(id)sender {
    address.longitude = self.mapView.centerCoordinate.longitude;
    address.latitude = self.mapView.centerCoordinate.latitude;
    [self.delegate didSelectAddress: address fromViewController:self];
    [self dismissViewControllerAnimated:YES completion:nil];
}

//MARK: map
-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations {
    [locationManager stopUpdatingLocation];  //TODO: add locate current to start;
    CLLocation* location = locations.lastObject;
    CLLocationDistance regionRadius = 1000;
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(location.coordinate, regionRadius*2.0, regionRadius*2.0);
    [self.mapView setRegion: [self.mapView regionThatFits:region] animated:YES];
    
}
-(void)mapView:(MKMapView *)mapView regionDidChangeAnimated:(BOOL)animated {
    [self setAnnotationPoint];
    //get address string
    CLLocation* location = [[CLLocation alloc] initWithLatitude:self.mapView.centerCoordinate.latitude longitude:self.mapView.centerCoordinate.longitude];
    [self geocodeLocation:location forAnnotation:centerAnnotation];
    [self setAnnotationPoint];
}

-(MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation {
    if ([annotation isKindOfClass:MKUserLocation.class]) {
        //((MKUserLocation*)annotation).blue
        //user location view is being requested,
        //return nil so it uses the default which is a blue dot...
        return nil;
    }
    
    MKAnnotationView* annotationView = [mapView dequeueReusableAnnotationViewWithIdentifier:kCenterAnnotationIdentifier];
    if(!annotationView) {
        annotationView = [[MKAnnotationView alloc] initWithAnnotation:centerAnnotation reuseIdentifier:kCenterAnnotationIdentifier];
        annotationView.accessibilityLabel = @"center location to search";
    }
    return annotationView;
}
 

- (void)geocodeLocation:(CLLocation*)location forAnnotation:(MKPointAnnotation*)annotation
{
    [geocoder reverseGeocodeLocation:location completionHandler:
     ^(NSArray* placemarks, NSError* error){
         if ([placemarks count] > 0)
         {
             CLPlacemark* placemark = [placemarks objectAtIndex:0];
             dispatch_async(dispatch_get_main_queue(), ^{
                 self.label.text = [NSString stringWithFormat:@"%@ %@ %@ %@ %@",
                                    placemark.thoroughfare ?:@"",
                                    placemark.subThoroughfare ?:@"",
                                    placemark.postalCode ?:@"",
                                    placemark.locality ?:@"",
                                    placemark.country ?:@""];
             });
         }
     }];
}
@end
