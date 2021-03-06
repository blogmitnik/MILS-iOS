#import <UIKit/UIKit.h>
#import "AppModel.h"
#import "Location.h"
#import <MapKit/MapKit.h>
#import "DDAnnotation.h"

@interface DropOnMapViewController : UIViewController <MKMapViewDelegate, UIActionSheetDelegate>{
    IBOutlet MKMapView *mapView;
	NSArray *locations;
	BOOL tracking;
	BOOL appSetNextRegionChange;
	IBOutlet UIBarButtonItem *mapTypeButton;
	IBOutlet UIBarButtonItem *dropButton;

	IBOutlet UIToolbar *toolBar;
    
	int silenceNextServerUpdateCount;
	int newItemsSinceLastView;
	NSTimer *refreshTimer;
    int noteId;
    DDAnnotation *myAnnotation;
    id delegate;
}

-(void) refresh;
-(void) zoomAndCenterMap;
-(void) showLoadingIndicator;
-(void)dismissTutorial;
- (IBAction)changeMapType: (id) sender;
- (IBAction)dropButtonAction: (id) sender;



@property (nonatomic, retain) MKMapView *mapView;
@property (nonatomic, retain) NSArray *locations;
@property (nonatomic, retain) DDAnnotation *myAnnotation;
@property(readwrite,assign)int noteId;

@property BOOL tracking;

@property(nonatomic,retain)id delegate;
@property (nonatomic, retain) IBOutlet UIBarButtonItem *mapTypeButton;
@property (nonatomic, retain) IBOutlet UIBarButtonItem *dropButton;

@property (nonatomic, retain) IBOutlet UIToolbar *toolBar;

@end
