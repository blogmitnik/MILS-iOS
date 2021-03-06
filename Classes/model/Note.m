#import "Note.h"
#import "MILSAppDelegate.h"
#import "AppModel.h"
#import "NoteViewController.h"
#import "DataCollectionViewController.h"
#import "NearbyObjectsViewController.h"

@implementation Note
@synthesize comments,contents, creatorId,noteId,parentNoteId,parentRating,shared,text,title,kind,averageRating,numRatings,username,delegate,dropped,showOnMap,showOnList;

-(nearbyObjectKind) kind { return NearbyObjectNote; }

- (Note *) init {
    self = [super init];
    if (self) {
		kind = NearbyObjectNote;
        iconMediaId = 71;
        self.comments = [NSMutableArray arrayWithCapacity:5];
        self.contents = [NSMutableArray arrayWithCapacity:5];
    }
    return self;	
}



- (void) display{
	NSLog(@"WebPage: Display Self Requested");
	
	//Create a reference to the delegate using the application singleton.
	MILSAppDelegate *appDelegate = (MILSAppDelegate *) [[UIApplication sharedApplication] delegate];
    
    
    if(self.creatorId == [AppModel sharedAppModel].playerId){
        
        NoteViewController *noteVC = [[[NoteViewController alloc] initWithNibName:@"NoteViewController" bundle:nil]autorelease];
        noteVC.note = self;
        noteVC.delegate = self;
        if([self.delegate isKindOfClass:[NearbyObjectsViewController class]]) {
            [[(NearbyObjectsViewController *)self.delegate navigationController]pushViewController:noteVC animated:YES]; 
        }        //[noteVC release];
    }
    else{
        //open up note viewer
        DataCollectionViewController *dataVC = [[[DataCollectionViewController alloc] initWithNibName:@"DataCollectionViewController" bundle:nil]autorelease];
        dataVC.note = self;
        dataVC.delegate = self;
        if([self.delegate isKindOfClass:[NearbyObjectsViewController class]]) {
            [[(NearbyObjectsViewController *)self.delegate navigationController]pushViewController:dataVC animated:YES]; 
        }
        //[dataVC release];
    }


}



- (void) dealloc {
	[comments release];
    [contents release];
	[text release];
    [title release];
    [username release];
	[super dealloc];
}

- (NSString *) name {
    return self.name;
}

- (int)	iconMediaId {
    return 71; 
}

@end
