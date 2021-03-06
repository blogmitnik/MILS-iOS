#import "NodeOption.h"

@implementation NodeOption
@synthesize text, nodeId, hasViewed;

- (NodeOption *) initWithText:(NSString *)optionText andNodeId: (int)optionNodeId andHasViewed:(BOOL)hasViewedB{
	if (self = [super init]) {
		self.text = optionText;
		self.nodeId = optionNodeId;
        self.hasViewed = hasViewedB;
	}
	return self;
}

- (void) dealloc {
	[text release];
	[super dealloc];
}

@end
