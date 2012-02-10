#import "Node.h"
#import "MILSAppDelegate.h"
#import "AppModel.h"
#import "NodeViewController.h"

@implementation Node
@synthesize nodeId, name, text, mediaId, iconMediaId, kind, forcedDisplay, numberOfOptions, options;
@synthesize answerString, nodeIfCorrect, nodeIfIncorrect;

-(nearbyObjectKind) kind { return NearbyObjectNode; }

- (Node *) init {
    if (self = [super init]) {
		kind = NearbyObjectNode;
		options = [[NSMutableArray alloc] init];
    }
    return self;	
}

- (int) iconMediaId {
	return 3; 
}

- (void) display{
	NSLog(@"Node: Display Self Requested");
	
	//Create a reference to the delegate using the application singleton.
	MILSAppDelegate *appDelegate = (MILSAppDelegate *) [[UIApplication sharedApplication] delegate];

	NodeViewController *nodeViewController = [[NodeViewController alloc] initWithNibName:@"Node" bundle: [NSBundle mainBundle]];
	nodeViewController.node = self; //currentNode;
	
	[appDelegate displayNearbyObjectView:nodeViewController];
	[nodeViewController release];
}

- (NSInteger) numberOfOptions {
	return [options count];
}

- (void) addOption:(NodeOption *)newOption{
	[options addObject:newOption];
}


- (void) dealloc {
	[name release];
	[text release];
	[options release];
	[answerString release];
	[super dealloc];
}
 


@end
