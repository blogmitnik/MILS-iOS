#import "Quest.h"


@implementation Quest

@synthesize questId;
@synthesize name, sortNum;
@synthesize description;
@synthesize iconMediaId;
@synthesize isNullQuest;

- (Quest *) init {
    if (self = [super init]) {
		sortNum = 0;
    }
    return self;	
}
- (void) dealloc {
	[name release];
	[description release];
	[super dealloc];
}


@end
