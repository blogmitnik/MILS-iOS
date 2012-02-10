#import <Foundation/Foundation.h>


@interface NodeOption : NSObject {
	NSString *text;
	NSInteger nodeId;
    BOOL hasViewed;
}

@property(readwrite, copy) NSString *text;
@property(readwrite, assign) NSInteger nodeId;
@property(readwrite, assign) BOOL hasViewed;

- (NodeOption *) initWithText:(NSString *)text andNodeId: (int)nodeId andHasViewed:(BOOL)hasViewedB;

@end