#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import "NearbyObjectProtocol.h"

@interface Location : NSObject <NearbyObjectProtocol> {
	int locationId;
	int iconMediaId;
	NSString *name;
	CLLocation *location;
	double error;
	NSString *objectType;
	nearbyObjectKind kind; //for the protocol
	int objectId;
	bool hidden;
	bool forcedDisplay;	
	bool allowsQuickTravel;
	int qty;
    id delegate;
}

@property(readwrite, assign) int locationId;
@property(copy, readwrite) NSString *name;
@property(readwrite, assign) int iconMediaId;

@property(copy, readwrite) CLLocation *location;
@property(readwrite) double error;
@property(copy, readwrite) NSString *objectType;
@property(readonly) nearbyObjectKind kind;
- (nearbyObjectKind) kind;
@property(readonly) NSObject<NearbyObjectProtocol> *object;

@property(readwrite) int objectId;
@property(readwrite) bool hidden;
@property(readwrite) bool forcedDisplay;
@property(readwrite) bool allowsQuickTravel;
@property(readwrite) int qty;
@property(nonatomic,retain)id delegate;
- (void) display;

@end
