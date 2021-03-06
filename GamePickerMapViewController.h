#import <UIKit/UIKit.h>
#import "AppModel.h"
#import "Location.h"
#import <MapKit/MapKit.h>
#import "Annotation.h"

@interface GamePickerMapViewController : UIViewController<MKMapViewDelegate,UIActionSheetDelegate> {
    IBOutlet MKMapView *mapView;
	NSArray *locations;
	BOOL tracking;
	BOOL appSetNextRegionChange;
	IBOutlet UIBarButtonItem *mapTypeButton;
	IBOutlet UIBarButtonItem *playerTrackingButton;
	IBOutlet UIToolbar *toolBar;
    IBOutlet UIBarButtonItem *refreshButton;
	int silenceNextServerUpdateCount;
	int newItemsSinceLastView;
    
	NSTimer *refreshTimer;
    
}

- (void) refresh;
- (void)refreshViewFromModel;
- (void) zoomAndCenterMap;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil;
- (void)dealloc;
- (void)didReceiveMemoryWarning;
- (void)viewDidLoad;
- (void)showLoadingIndicator;
- (void)removeLoadingIndicator;
- (void)viewWillDisappear:(BOOL)animated;
- (void)viewDidUnload;
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation;
- (IBAction)changeMapType: (id) sender;
- (void)mapView:(MKMapView *)mapView regionWillChangeAnimated:(BOOL)animated;
- (MKAnnotationView *)mapView:(MKMapView *)myMapView viewForAnnotation:(id <MKAnnotation>)annotation;
- (void)mapView:(MKMapView *)aMapView didSelectAnnotationView:(MKAnnotationView *)view;
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex;
- (IBAction)refreshButtonAction: (id) sender;
- (void) goToGame;
- (IBAction)gameWasSelected:(id)sender;

@property (nonatomic, retain) MKMapView *mapView;
@property (nonatomic, copy) NSArray *locations;
@property BOOL tracking;
@property (nonatomic, retain) IBOutlet UIBarButtonItem *mapTypeButton;
@property (nonatomic, retain) IBOutlet UIBarButtonItem *playerTrackingButton;
@property (nonatomic, retain) IBOutlet UIToolbar *toolBar;
@property (nonatomic, retain) IBOutlet UIBarButtonItem *refreshButton;



@end
