#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface GamesMapAnnotation : NSObject <MKAnnotation> {
    
	NSString *title;
	CLLocationCoordinate2D coordinate;
    int gameId;
    int rating;
    int calculatedScore;
}

@property (nonatomic, copy) NSString *title;
@property (nonatomic, readonly) CLLocationCoordinate2D coordinate;
@property int gameId;
@property int rating;
@property int calculatedScore;

- (id)initWithTitle:(NSString *)ttl andCoordinate:(CLLocationCoordinate2D)c2d;

@end
