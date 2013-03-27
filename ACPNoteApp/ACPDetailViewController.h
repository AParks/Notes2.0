//
//  ACPDetailViewController.h
//  ACPNotes
//
//  Created by Anna Parks on 3/14/13.
//  Copyright (c) 2013 Anna Parks. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface ACPDetailViewController : UIViewController <UITextViewDelegate, CLLocationManagerDelegate>
@property (weak, nonatomic) IBOutlet MKMapView *mapView;
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations;


@property (strong, nonatomic) id detailItem;
@property (weak, nonatomic) IBOutlet UITextView *noteDescription;
@property (weak, nonatomic) IBOutlet UITextField *noteTitle;
@property CLLocationCoordinate2D location;

@property BOOL isEditable;
@property BOOL showDetail;
@property BOOL addNote;

@end
