#import "GamesMapAnnotation.h"

@implementation GamesMapAnnotation

@synthesize title, coordinate;
@synthesize gameId, rating, calculatedScore;

- (id)initWithTitle:(NSString *)ttl andCoordinate:(CLLocationCoordinate2D)c2d {
	[super init];
	title = ttl;
	coordinate = c2d;
	return self;
}

- (void)dealloc {
	[title release];
	[super dealloc];
}

@end

