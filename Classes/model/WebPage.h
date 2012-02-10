#import <Foundation/Foundation.h>
#import "NearbyObjectProtocol.h"


@interface WebPage : NSObject<NearbyObjectProtocol> {
    nearbyObjectKind	kind;
    int webPageId;
	NSString *name;
	NSString *url;    
	int iconMediaId; 

}

@property(readwrite, assign) int webPageId;
@property(nonatomic, retain) NSString *name;
@property(nonatomic, retain) NSString *url;
@property(readwrite, assign) int iconMediaId;
@property(readwrite, assign) nearbyObjectKind kind;

@end
