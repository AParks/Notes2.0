//
//  ACPDetailViewController.m
//  ACPNotes
//
//  Created by Anna Parks on 3/14/13.
//  Copyright (c) 2013 Anna Parks. All rights reserved.
//

#import "ACPDetailViewController.h"
#import "ACPNote.h"


@interface ACPDetailViewController ()
- (void)configureView;
- (void)setUpMap;
- (void)setUpDescription;


@property (strong, nonatomic) CLLocationManager *locationManager;

@end

@implementation ACPDetailViewController

#pragma mark - Managing the detail item


- (void)setDetailItem:(id) newDetailItem
{
    if (_detailItem != newDetailItem) {
        _detailItem = newDetailItem;
        
        // Update the view.
        [self configureView];
    }
}

- (void)configureView
{
    // Update the user interface for the detail item.
    
    if (self.detailItem) {
        self.noteTitle.text = [self.detailItem valueForKey:@"title"];
        self.noteDescription.textColor = [UIColor blackColor];
        self.noteDescription.text = [self.detailItem valueForKey:@"noteDescription"];
        double lat = [[self.detailItem valueForKey:@"latitude"] doubleValue];
        double lon = [[self.detailItem valueForKey:@"longitude"] doubleValue];
        self.location = CLLocationCoordinate2DMake(lat, lon);
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    if (self.showDetail)
        [self setUpEditDone];
    
    [self.noteTitle becomeFirstResponder];
    [self setUpMap];
    [self setUpDescription];
    [self configureView];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)setUpEditDone{
    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemEdit target:self action:@selector(editView:)];
    self.noteTitle.enabled = NO;
    self.navigationItem.rightBarButtonItem = rightButton;
}

- (IBAction)dismissView:(id)sender {
    
    self.noteTitle.enabled = NO;
    self.noteDescription.editable = NO;
    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemEdit target:self action:@selector(editView:)];
    self.navigationItem.rightBarButtonItem = rightButton;

    ACPNote *note = self.detailItem;
    [note setNoteDescription:self.noteDescription.text];
    [note setTitle:self.noteTitle.text];
    
    
}

- (IBAction)editView:(id)sender {
    self.noteTitle.enabled = YES;
    self.noteDescription.editable = YES;
    [self.noteTitle becomeFirstResponder];
    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(dismissView:)];
    self.navigationItem.rightBarButtonItem = rightButton;
}

#pragma mark - description methods

-(void)setUpDescription{
    
    UIImage *patternImage = [UIImage imageNamed:@"Post-it-note-white-bg.jpg"];
    self.noteDescription.backgroundColor = [UIColor colorWithPatternImage:patternImage];
    self.noteDescription.delegate = self;
    self.noteDescription.text = @"Add a description...";
    self.noteDescription.textColor = [UIColor lightTextColor];
    self.noteDescription.editable = self.isEditable;
}

- (BOOL) textViewShouldBeginEditing:(UITextView *)textView
{
    if(textView.tag == 0) {
        textView.text = @"";
        textView.textColor = [UIColor blackColor];
        textView.tag = 1;
    }
    return YES;
}

- (void)textViewDidEndEditing:(UITextView *)textView
{
    if([textView.text length] == 0)
    {
        textView.text = @"Add a description...";
        textView.textColor = [UIColor whiteColor];
        textView.tag = 0;
    }
}


#pragma mark - CLLocationManagerDelegate methods
-(void)setUpMap{
    if (!self.locationManager)
        self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.delegate = self;
    self.locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters;
    self.locationManager.distanceFilter = 1000;
    
    if(self.addNote)
        [self.locationManager startMonitoringSignificantLocationChanges];
    
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(self.location, 2000, 2000);
    [self.mapView setRegion:region animated:NO];
    [self.mapView setCenterCoordinate:self.location animated:YES];
    [self addPinToMapAtLocation];
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    CLLocation *location = [locations lastObject];
    
    self.location = location.coordinate;

    [self.locationManager stopMonitoringSignificantLocationChanges];
}

- (void)addPinToMapAtLocation
{
    MKPointAnnotation *pin = [[MKPointAnnotation alloc] init];
    pin.coordinate = self.location;
    [self.mapView addAnnotation:pin];
}


@end
