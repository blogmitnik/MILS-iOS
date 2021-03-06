#import <UIKit/UIKit.h>
#import "AppModel.h"
#import "Comment.h"
@interface GamePickerRecentViewController : UIViewController <UITableViewDelegate,UITableViewDataSource, UISearchDisplayDelegate, UISearchBarDelegate>{

	NSArray *gameList;
    IBOutlet UISegmentedControl *distanceControl;
    IBOutlet UISegmentedControl *locationalControl;
	UITableView *gameTable;
    UIBarButtonItem *refreshButton;
    
}

-(void)refresh;
-(void)showLoadingIndicator;
-(void)controlChanged:(id)sender;
- (void)refreshViewFromModel;

@property (nonatomic, copy) NSArray *gameList;
@property (nonatomic, retain) IBOutlet UITableView *gameTable;
@property (nonatomic, retain) IBOutlet UIBarButtonItem *refreshButton;



@end
