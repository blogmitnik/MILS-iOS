#import <Foundation/Foundation.h>


@interface Quest : NSObject {
	int questId;
	NSString *name;
	NSString *description;
	int iconMediaId;
    int sortNum;
    BOOL isNullQuest;
}

@property(readwrite, assign) int questId;
@property(copy, readwrite) NSString *name;
@property(copy, readwrite) NSString *description;
@property(readwrite, assign) int iconMediaId;
@property(readwrite, assign) int sortNum;
@property(readwrite, assign) BOOL isNullQuest;

@end
