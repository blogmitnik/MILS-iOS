#import "Panoramic.h"
#import "MILSAppDelegate.h"
#import "AppModel.h"
#import "PanoramicViewController.h"

@implementation Panoramic
@synthesize name,description,media,iconMediaId,alignMediaId,kind,panoramicId,textureArray;
-(nearbyObjectKind) kind { return NearbyObjectPanoramic; }

- (Panoramic *) init {
    self = [super init];
    if (self) {
		kind = NearbyObjectPanoramic;
        iconMediaId = 5;
    }
    return self;	
}



- (void) display{
	NSLog(@"Panoramic: Display Self Requested");
	
	//Create a reference to the delegate using the application singleton.
	MILSAppDelegate *appDelegate = (MILSAppDelegate *) [[UIApplication sharedApplication] delegate];
    
	PanoramicViewController *panoramicViewController = [[PanoramicViewController alloc] initWithNibName:@"PanoramicViewController" bundle: [NSBundle mainBundle]];
	panoramicViewController.panoramic = self;
	[appDelegate displayNearbyObjectView:panoramicViewController];
	[panoramicViewController release];
}



- (void) dealloc {
	[name release];
	[description release];
	[super dealloc];
}

@end
