#import <Foundation/Foundation.h>
#import "NearbyObjectProtocol.h"

@interface Panoramic : NSObject<NearbyObjectProtocol> {
    NSString *name;
    NSString *description;
    int iconMediaId;
    NSArray *media;
    int alignMediaId;
    int panoramicId;
    nearbyObjectKind kind;
    NSArray *textureArray;
}

@property(nonatomic, retain) NSString *name;
@property(nonatomic, retain) NSString *description;
@property(nonatomic, retain) NSArray *textureArray;
@property(readwrite, assign) int iconMediaId;
@property(nonatomic, retain) NSArray *media;
@property(readwrite, assign) int alignMediaId;
@property(readwrite, assign) int panoramicId;
@property(readwrite, assign) nearbyObjectKind kind;

@end
