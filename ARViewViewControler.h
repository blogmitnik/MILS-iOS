#import <UIKit/UIKit.h>
#import "AppModel.h"
#import "MILSAppDelegate.h"
#import "ARGeoViewController.h"
#import "NearbyObjectARCoordinate.h"


@interface ARViewViewControler : UIViewController <UIApplicationDelegate, ARViewDelegate>{
	NSMutableArray *locations;
	ARGeoViewController *ARviewController;
}

@property(nonatomic, retain) NSMutableArray *locations;

- (UIView *)viewForCoordinate:(NearbyObjectARCoordinate *)coordinate;
- (void) refresh;


@end
