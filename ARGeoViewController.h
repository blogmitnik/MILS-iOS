#import <Foundation/Foundation.h>

#import "ARViewController.h"

@interface ARGeoViewController : ARViewController {
	CLLocation *centerLocation;
}

@property (nonatomic, retain) CLLocation *centerLocation;

@end
