#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>
#import "Media.h"
#import "NearbyObjectProtocol.h"
#import "Location.h"

@interface Annotation : NSObject <MKAnnotation> {
	CLLocationCoordinate2D coordinate;
	NSString *title;
	NSString *subtitle;
	int iconMediaId;
	nearbyObjectKind kind;
	Location *location;
}

@property (nonatomic, readonly) CLLocationCoordinate2D coordinate;
@property (readwrite, copy) NSString *title;
@property (readwrite, copy) NSString *subtitle;
@property(readwrite, assign) int iconMediaId;
@property(readwrite, assign) nearbyObjectKind kind;
@property (nonatomic, retain) Location *location;


- (id)initWithCoordinate:(CLLocationCoordinate2D) coordinate;

@end
