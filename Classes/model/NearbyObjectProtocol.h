#import <CoreLocation/CoreLocation.h>

enum {
	NearbyObjectNil			= 0,
	NearbyObjectNPC			= 1,
	NearbyObjectItem		= 2,
	NearbyObjectNode		= 3,
	NearbyObjectPlayer		= 4,
    NearbyObjectWebPage     = 5,
    NearbyObjectPanoramic   = 6,
    NearbyObjectNote        = 7,
};
typedef UInt32 nearbyObjectKind;


@protocol NearbyObjectProtocol
- (NSString *)			name; 
- (nearbyObjectKind)	kind;
- (BOOL)				forcedDisplay;
- (void)				display;
- (int)					iconMediaId;
//- (CLLocation *)		location;

@end
