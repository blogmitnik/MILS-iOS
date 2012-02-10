#import "Annotation.h"


@implementation Annotation

@synthesize coordinate, title, subtitle, iconMediaId, kind, location;

-(id)initWithCoordinate:(CLLocationCoordinate2D) c{
	if (self == [super init]) {
		coordinate=c;
	}
	NSLog(@"Item annotation created");
	return self;
}


@end
