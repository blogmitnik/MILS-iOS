#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@interface Player : NSObject {
	NSString *name;
	CLLocation *location;
	BOOL hidden;
}

@property(copy, readwrite) NSString *name;
@property(copy, readwrite) CLLocation *location;
@property(readwrite) BOOL hidden;

@end
