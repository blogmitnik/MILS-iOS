#import <UIKit/UIKit.h>
#import "AppModel.h";
#import "Location.h";

@interface DeveloperViewController : UIViewController {	
	UITableView *locationTable;
	NSMutableArray *locationTableData;
	UIButton *clearEventsButton;
	UIButton *clearItemsButton;
	UILabel *accuracyLabelValue;
}

@property(nonatomic, retain) IBOutlet UITableView *locationTable;
@property(nonatomic, retain) IBOutlet NSMutableArray *locationTableData;
@property(nonatomic, retain) IBOutlet UIButton *clearEventsButton;
@property(nonatomic, retain) IBOutlet UIButton *clearItemsButton;
@property(nonatomic, retain) IBOutlet UILabel *accuracyLabelValue;

-(IBAction)clearEventsButtonTouched: (id) sender;
-(IBAction)clearItemsButtonTouched: (id) sender;

-(void) refresh;
@end
