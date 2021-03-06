#import "Item.h"
#import "ItemDetailsViewController.h"
#import "AppModel.h"
#import "MILSAppDelegate.h"


@implementation Item

@synthesize name,url;
@synthesize kind,creatorId;
@synthesize forcedDisplay, hasViewed;

@synthesize itemId;
@synthesize mediaId;
@synthesize iconMediaId;
@synthesize locationId;
@synthesize weight,type;
@synthesize qty,maxQty;
@synthesize description;

@synthesize dropable;
@synthesize	destroyable,isAttribute;

-(nearbyObjectKind) kind {
	return NearbyObjectItem;
}

-(int)iconMediaId {
	if (iconMediaId == 0) return 2;
	else return iconMediaId;
}

- (void) display{
	NSLog(@"Item: Display Self Requested");
	
	//Create a reference to the delegate using the application singleton.
	MILSAppDelegate *appDelegate = (MILSAppDelegate *) [[UIApplication sharedApplication] delegate];
		
	ItemDetailsViewController *itemDetailsViewController = [[ItemDetailsViewController alloc] 
															initWithNibName:@"ItemDetailsView" bundle:[NSBundle mainBundle]];
	itemDetailsViewController.item = self;
	itemDetailsViewController.navigationItem.title = name;
	itemDetailsViewController.inInventory = NO;

	//Have AppDelegate display
	[appDelegate displayNearbyObjectView:itemDetailsViewController];
	[itemDetailsViewController release];
	
}

- (BOOL)isEqual:(id)anObject {
	if (![anObject isKindOfClass:[Item class]]) return NO;
	Item *anItem = (Item*)anObject;
	if (anItem.itemId == self.itemId) return YES;
	return NO;
}

- (NSUInteger)hash {
	return itemId;
}


- (void)dealloc {
	[name release];
	[description release];
    [super dealloc];
}
 

@end
