//
//  ViewController.m
//  MapKitTask
//
//  Created by Aleksandr on 04/12/2019.
//  Copyright © 2019 Aleksandr Shushkov. All rights reserved.
//

#import "ViewController.h"
#import <MapKit/MapKit.h>
#import "Student.h"
#import "Extensions/UIView+MKAnnotationView.h"
#import "InfoPopoverTableViewController.h"
#import "DatePlace.h"

@interface ViewController () <MKMapViewDelegate>

@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (strong, nonatomic) CLGeocoder *geoCoder;
@property (weak, nonatomic) IBOutlet UILabel *zone5label;
@property (weak, nonatomic) IBOutlet UILabel *zone10label;
@property (weak, nonatomic) IBOutlet UILabel *zone15label;
@property (strong, nonatomic) MKDirections* directions;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.geoCoder = [[CLGeocoder alloc] init];
}

- (void)dealloc
{
    if ([self.geoCoder isGeocoding]) {
        [self.geoCoder cancelGeocode];
    }
    if ([self.directions isCalculating]) {
        [self.directions cancel];
    }
}

#pragma mark - Actions

- (IBAction)addStudents:(UIBarButtonItem *)sender {
    
    for (id<MKAnnotation> annotation in self.mapView.annotations) {
        if (![annotation isKindOfClass:[MKUserLocation class]]) {
            [self.mapView removeAnnotation:annotation];
        }
    }
    
    MKCoordinateRegion region = self.mapView.region;
    
    NSInteger count = 10 + arc4random_uniform(21);
    
    NSInteger zone5counter = 0;
    NSInteger zone10counter = 0;
    NSInteger zone15counter = 0;
    
    for (int i = 0; i < count; i++) {
        Student *student = [Student new];
        
        student.title = [NSString stringWithFormat:@"%@, %@", student.name, student.secondName];
        student.subtitle = [student getYearOfBirthStringRepresentation];
        
        CLLocationDegrees startedLatitude = region.center.latitude - (region.span.latitudeDelta / 2);
        CLLocationDegrees latitude = startedLatitude + (CLLocationDegrees)arc4random_uniform(region.span.latitudeDelta * 100000) / 100000;
        CLLocationDegrees startedLongitude = region.center.longitude - (region.span.longitudeDelta / 2);
        CLLocationDegrees longitude = startedLongitude + (CLLocationDegrees)arc4random_uniform(region.span.longitudeDelta * 100000) / 100000;
        CLLocationCoordinate2D coordinate = CLLocationCoordinate2DMake(latitude, longitude);
        student.coordinate = coordinate;
        
        MKMapPoint studentPoint = MKMapPointForCoordinate(coordinate);
        MKMapPoint datePoint = MKMapPointForCoordinate(region.center);
        CLLocationDistance distance = MKMetersBetweenMapPoints(studentPoint, datePoint);
        
        if (distance < 5000) {
            zone5counter = zone5counter + 1;
        } else if (distance < 10000) {
            zone10counter = zone10counter + 1;
        } else if (distance < 15000) {
            zone15counter = zone15counter + 1;
        }
        
        [self.mapView addAnnotation:student];
        
    }
    
    self.zone5label.text = [NSString stringWithFormat:@"5km:\t%ld", (long)zone5counter];
    self.zone10label.text = [NSString stringWithFormat:@"10km:\t%ld", (long)zone10counter];
    self.zone15label.text = [NSString stringWithFormat:@"15km:\t%ld", (long)zone15counter];
    
    
    [self.mapView removeOverlays:self.mapView.overlays];
    DatePlace *datePlace = [DatePlace new];
    datePlace.coordinate = region.center;
    NSMutableArray *circles = [NSMutableArray array];
    for (int i = 1; i <= 3; i++) {
        [circles addObject:[MKCircle circleWithCenterCoordinate:region.center radius:5000*i]];
    }
    [self.mapView addOverlays:circles];
    
    [self.mapView addAnnotation:datePlace];
}

- (IBAction)showStudents:(UIBarButtonItem *)sender {
    
    MKMapRect zoomRect = MKMapRectNull;
    
    for (id <MKAnnotation> annotation in self.mapView.annotations) {
        
        CLLocationCoordinate2D location = annotation.coordinate;
        MKMapPoint center = MKMapPointForCoordinate(location);
        
        static double delta = 8000;
        
        MKMapRect rect = MKMapRectMake(center.x - delta, center.y - delta, delta * 2, delta * 2);
        
        zoomRect = MKMapRectUnion(zoomRect, rect);
    }
    
    zoomRect = [self.mapView mapRectThatFits:zoomRect];
    
    [self.mapView setVisibleMapRect:zoomRect edgePadding:UIEdgeInsetsMake(50, 50, 50, 50) animated:YES];
}

- (void)actionDescription:(UIButton *)sender {
    
    MKAnnotationView *annotationView = [sender rootAnnotationView];
    
    if (!annotationView) {
        return;
    }
    
    Student *student = annotationView.annotation;
    
    if ([self.geoCoder isGeocoding]) {
        [self.geoCoder cancelGeocode];
    }
    
    CLLocation *location = [[CLLocation alloc] initWithLatitude:student.coordinate.latitude longitude:student.coordinate.longitude];
    
    [self.geoCoder reverseGeocodeLocation:location completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        
        InfoPopoverTableViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"InfoPopoverTableViewController"];
        vc.name = student.name;
        vc.secondName = student.secondName;
        vc.dateOfBirth = [student getYearOfBirthStringRepresentation];
        vc.sex = [student getSexStringRepresentation];
        
        if (error) {
            vc.address = @"Address not found";
        } else {
            CLPlacemark *placemark = [placemarks firstObject];
            
            NSArray *address = @[placemark.country?:@"",
                                 placemark.administrativeArea?:@"",
                                 placemark.locality?:@"",
                                 placemark.thoroughfare?:@"",
                                 placemark.subThoroughfare?:@""];
            address = [address filteredArrayUsingPredicate:[NSPredicate predicateWithBlock:^BOOL(NSString *  _Nullable evaluatedObject, NSDictionary<NSString *,id> * _Nullable bindings) {
                if ([evaluatedObject isEqualToString:@""]) {
                    return NO;
                }
                return YES;
            }]];
            
            vc.address = [address componentsJoinedByString:@", "];
        }
        
        vc.popoverPresentationController.sourceView = sender.superview;
        vc.popoverPresentationController.sourceRect = sender.frame;
        [self presentViewController:vc animated:YES completion:nil];
    }];
}

- (IBAction)makeRoute:(UIBarButtonItem *)sender {
    if ([self.directions isCalculating]) {
        [self.directions cancel];
    }
    
    NSMutableArray<id<MKOverlay>> *routeOverlays = [NSMutableArray array];
    for (id<MKOverlay> overlay in self.mapView.overlays) {
        if ([overlay isKindOfClass:[MKPolyline class]]) {
            [routeOverlays addObject:overlay];
        }
    }
    [self.mapView removeOverlays:routeOverlays];
    
    DatePlace *datePlace;
    NSMutableArray<Student *> *students = [NSMutableArray array];
    
    
    for (id<MKAnnotation> annotation in self.mapView.annotations) {
        if ([annotation isKindOfClass:[Student class]]) {
            [students addObject:annotation];
        } else if ([annotation isKindOfClass:[DatePlace class]]) {
            datePlace = annotation;
        }
    }
    
    if (students.count == 0 || [datePlace isEqual:nil]) {
        return;
    }
    
    MKMapPoint datePlacePoint = MKMapPointForCoordinate(datePlace.coordinate);
    NSMutableArray<Student *> *acceptedStudents = [NSMutableArray array];
    
    for (Student *student in students) {
        MKMapPoint studentPoint = MKMapPointForCoordinate(student.coordinate);
        
        CLLocationDistance distance = MKMetersBetweenMapPoints(datePlacePoint, studentPoint);
        if (distance < 5000) {
            if (arc4random_uniform(10) < 9) {
                [acceptedStudents addObject:student];
            }
        } else if (distance < 10000) {
            if (arc4random_uniform(10) >= 5) {
                [acceptedStudents addObject:student];
            }
        } else if (distance < 15000) {
            if (arc4random_uniform(10) >= 9) {
                [acceptedStudents addObject:student];
            }
        }
    }
    
    if (acceptedStudents.count < 1) {
        return;
    }
    
    MKPlacemark *datePlacePlacemark = [[MKPlacemark alloc] initWithCoordinate:datePlace.coordinate];
    MKMapItem *destination = [[MKMapItem alloc] initWithPlacemark:datePlacePlacemark];
    
    for (Student *student in acceptedStudents) {
        MKDirectionsRequest *request = [[MKDirectionsRequest alloc] init];
        request.destination = destination;
        request.transportType = MKDirectionsTransportTypeAutomobile;
        request.requestsAlternateRoutes = NO;
        
        MKPlacemark *studentPlacemark = [[MKPlacemark alloc] initWithCoordinate:student.coordinate];
        MKMapItem *source = [[MKMapItem alloc] initWithPlacemark:studentPlacemark];
        request.source = source;
        
        self.directions = [[MKDirections alloc] initWithRequest:request];
        [self.directions calculateDirectionsWithCompletionHandler:^(MKDirectionsResponse * _Nullable response, NSError * _Nullable error) {
            if (error) {
                return;
            } else if (response.routes.count == 0) {
                return;
            } else {
                NSMutableArray *routes = [NSMutableArray array];
                
                for (MKRoute *route in response.routes) {
                    [routes addObject:route.polyline];
                }
                
                [self.mapView addOverlays:routes level:MKOverlayLevelAboveRoads];
            }
        }];
    }
    
    
    
}

#pragma mark - MKMapViewDelegate

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation {
    if ([annotation isKindOfClass:[MKUserLocation class]]) {
        return nil;
    }
    
    if ([annotation isKindOfClass:[Student class]]) {
        Student *currentStudent = (Student *)annotation;
        
        static NSString *femaleIdentifier = @"femaleIdentifier";
        static NSString *maleIdentifier = @"maleIdentifier";
        
        NSString *identifier = currentStudent.sex == StudentSexMale ? maleIdentifier : femaleIdentifier;
        
        MKAnnotationView *annotationView = [mapView dequeueReusableAnnotationViewWithIdentifier:identifier];
        
        if (!annotationView) {
            annotationView = [[MKAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:identifier];
            NSString *imageName = [currentStudent getSexStringRepresentation];
            UIImage *img = [UIImage imageNamed:imageName];
            CGSize size = CGSizeMake(20, 40);
            UIGraphicsBeginImageContext(size);
            [img drawInRect:CGRectMake(0, 0, size.width, size.height)];
            img = UIGraphicsGetImageFromCurrentImageContext();
            annotationView.image = img;
            annotationView.canShowCallout = YES;
            annotationView.draggable = NO;
            
            UIButton *descriptionButton = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
            [descriptionButton addTarget:self action:@selector(actionDescription:) forControlEvents:UIControlEventTouchUpInside];
            annotationView.rightCalloutAccessoryView = descriptionButton;
            
            
        } else {
            annotationView.annotation = annotation;
        }
        return annotationView;
    }
    
    if ([annotation isKindOfClass:[DatePlace class]]) {
        DatePlace *datePlace = (DatePlace *)annotation;
        
        MKAnnotationView *annotationView = [mapView dequeueReusableAnnotationViewWithIdentifier:NSStringFromClass([DatePlace class])];
        
        if (!annotationView) {
            annotationView = [[MKAnnotationView alloc] initWithAnnotation:datePlace reuseIdentifier:NSStringFromClass([DatePlace class])];
            UIImage *img = [UIImage imageNamed:@"DatePlace"];
            CGSize size = CGSizeMake(40, 40);
            UIGraphicsBeginImageContext(size);
            [img drawInRect:CGRectMake(0, 0, size.width, size.height)];
            img = UIGraphicsGetImageFromCurrentImageContext();
            annotationView.image = img;
            annotationView.canShowCallout = NO;
            annotationView.draggable = YES;
            
        } else {
            annotationView.annotation = annotation;
        }
        return annotationView;
    }
    
    return nil;
}

- (MKOverlayRenderer *)mapView:(MKMapView *)mapView rendererForOverlay:(id<MKOverlay>)overlay {
    if ([overlay isKindOfClass:[MKCircle class]]) {
        MKCircle *circle = (MKCircle *)overlay;
        MKCircleRenderer *renderer = [[MKCircleRenderer alloc] initWithCircle:circle];
        renderer.lineWidth = 1.f;
        renderer.strokeColor = [UIColor colorWithRed:0.0f green:0.8f blue:0.f alpha:0.5f];
        renderer.fillColor = [UIColor colorWithRed:1.0f green:0.f blue:0.f alpha:0.2f];
        return renderer;
    } else if ([overlay isKindOfClass:[MKPolyline class]]) {
        MKPolylineRenderer* renderer = [[MKPolylineRenderer alloc] initWithOverlay:overlay];
        renderer.lineWidth = 2.f;
        renderer.strokeColor = [UIColor colorWithRed:0.f green:0.f blue:1.f alpha:0.9f];
        return renderer;
    }
    return nil;
}

- (void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view didChangeDragState:(MKAnnotationViewDragState)newState fromOldState:(MKAnnotationViewDragState)oldState {
    if (newState == MKAnnotationViewDragStateEnding) {
        [mapView removeOverlays:mapView.overlays];
        NSMutableArray *circles = [NSMutableArray array];
        for (int i = 1; i <= 3; i++) {
            [circles addObject:[MKCircle circleWithCenterCoordinate:view.annotation.coordinate radius:5000*i]];
        }
        
        NSInteger zone5counter = 0;
        NSInteger zone10counter = 0;
        NSInteger zone15counter = 0;
        
        for (id<MKAnnotation> annotation in self.mapView.annotations) {
            if ([annotation isKindOfClass:[Student class]]) {
                Student *student = (Student *)annotation;
                
                MKMapPoint studentPoint = MKMapPointForCoordinate(student.coordinate);
                MKMapPoint datePoint = MKMapPointForCoordinate(view.annotation.coordinate);
                CLLocationDistance distance = MKMetersBetweenMapPoints(studentPoint, datePoint);
                
                if (distance < 5000) {
                    zone5counter = zone5counter + 1;
                } else if (distance < 10000) {
                    zone10counter = zone10counter + 1;
                } else if (distance < 15000) {
                    zone15counter = zone15counter + 1;
                }
            }
        }
        
        self.zone5label.text = [NSString stringWithFormat:@"5km:\t%ld", (long)zone5counter];
        self.zone10label.text = [NSString stringWithFormat:@"10km:\t%ld", (long)zone10counter];
        self.zone15label.text = [NSString stringWithFormat:@"15km:\t%ld", (long)zone15counter];
        
        [self.mapView addOverlays:circles];
    }
}

@end
