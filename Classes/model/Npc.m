#import "MILSAppDelegate.h"
#import "AppModel.h"
#import "DialogViewController.h"
#import "Npc.h"

@implementation Npc
@synthesize npcId;
@synthesize name;
@synthesize greeting,closing;
@synthesize description;
@synthesize mediaId;
@synthesize iconMediaId;
@synthesize kind;
@synthesize forcedDisplay;


-(nearbyObjectKind) kind {
	return NearbyObjectNPC;
}

- (Npc *)init {
	self = [super init];
    if (self) {
    }
    return self;	
}

- (int) iconMediaId {
	if (iconMediaId < 1) return 1;
	else return iconMediaId;
}

- (int) mediaId {
	if (mediaId < 1) return 1; 
	else return mediaId;
}

- (void) display{
	NSLog(@"Npc: Display Self Requested");
	DialogViewController *dialogController = [[DialogViewController alloc] initWithNibName:@"Dialog"
																					bundle:[NSBundle mainBundle]];
	[dialogController beginWithNPC:self];
	MILSAppDelegate *appDelegate = (MILSAppDelegate *) [[UIApplication sharedApplication] delegate];
	[appDelegate displayNearbyObjectView:dialogController];
	[dialogController release];
}


- (void) dealloc {
	[name release];
	[description release];
	[greeting release];
	[location release];
	[super dealloc];
}
 

@end
