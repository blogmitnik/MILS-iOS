#import <UIKit/UIKit.h>
#import "AppModel.h"
#import "Comment.h"

@interface GamePickerNearbyViewController : UIViewController <UITableViewDelegate,UITableViewDataSource>{
	NSArray *gameList;
    IBOutlet UISegmentedControl *distanceControl;
    IBOutlet UISegmentedControl *locationalControl;
	UITableView *gameTable;
    UIBarButtonItem *refreshButton;
    NSInteger count;
    NSArray *gameIcons;
}

-(void)refresh;
-(void)showLoadingIndicator;
-(IBAction)controlChanged:(id)sender;
- (void)refreshViewFromModel;

@property (nonatomic, copy) NSArray *gameList;
@property (nonatomic, retain) IBOutlet UITableView *gameTable;
@property (nonatomic, retain) IBOutlet UIBarButtonItem *refreshButton;
@property (nonatomic, retain) NSArray *gameIcons;
@property (assign) NSInteger count;

@end
