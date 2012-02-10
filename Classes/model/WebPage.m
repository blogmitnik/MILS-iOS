#import "WebPage.h"
#import "MILSAppDelegate.h"
#import "AppModel.h"
#import "webpageViewController.h"


@implementation WebPage
@synthesize iconMediaId,webPageId,name,url,kind;
-(nearbyObjectKind) kind { return NearbyObjectWebPage; }

- (WebPage *) init {
    self = [super init];
    if (self) {
		kind = NearbyObjectWebPage;
        iconMediaId = 4;
    }
    return self;	
}



- (void) display{
	NSLog(@"WebPage: Display Self Requested");
	
	//Create a reference to the delegate using the application singleton.
	MILSAppDelegate *appDelegate = (MILSAppDelegate *) [[UIApplication sharedApplication] delegate];
    
	webpageViewController *webPageViewController = [[webpageViewController alloc] initWithNibName:@"webpageViewController" bundle: [NSBundle mainBundle]];
	webPageViewController.webPage = self;
	[appDelegate displayNearbyObjectView:webPageViewController];
	[webPageViewController release];
}



- (void) dealloc {
	[name release];
	[url release];
	[super dealloc];
}

- (NSString *) name {
    return self.name;
}

- (int)	iconMediaId {
    return 4; 
}

@end
