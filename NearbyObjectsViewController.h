#import <UIKit/UIKit.h>
#import "NearbyObjectProtocol.h"


@interface NearbyObjectsViewController : UIViewController <UITableViewDataSource,UITableViewDelegate> {
	NSMutableArray *oldNearbyLocationList;
	IBOutlet UITableView *nearbyTable;
}

@property(nonatomic,retain) NSMutableArray *oldNearbyLocationList;

- (void)refreshViewFromModel;
- (void)refresh;
- (void)dismissTutorial;


@end
