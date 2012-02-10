#import <Foundation/Foundation.h>
#import "ARGeoCoordinate.h"
#import "Location.h"


@interface NearbyObjectARCoordinate : ARGeoCoordinate {
	int mediaId;
}

@property(readwrite, assign) int mediaId;

+ (NearbyObjectARCoordinate *)coordinateWithNearbyLocation:(Location *)aNearbyLocation;


@end
