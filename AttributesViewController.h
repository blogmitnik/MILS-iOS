#import <UIKit/UIKit.h>
#import "AppModel.h"
#import "MILSAppDelegate.h"
#import "Item.h"
#import "ItemDetailsViewController.h"

@interface AttributesViewController : UIViewController<UITableViewDataSource,UITableViewDataSource> {
    int silenceNextServerUpdateCount;
	UITableView *attributesTable;
	NSArray *attributes;
    NSMutableArray *iconCache;
    AsyncImageView	*pcImage;
    UIButton *addGroupButton;
    UILabel *nameLabel;
    UILabel *groupLabel;

}
@property(nonatomic, retain) IBOutlet UITableView *attributesTable;
@property(nonatomic, retain) NSArray *attributes;
@property(nonatomic, retain) NSMutableArray *iconCache;
@property(nonatomic, retain) IBOutlet AsyncImageView	*pcImage;
@property(nonatomic, retain) IBOutlet UIButton  *addGroupButton;
@property(nonatomic, retain) IBOutlet UILabel *nameLabel;
@property(nonatomic, retain) IBOutlet UILabel *groupLabel;


- (void) refresh;
- (void)showLoadingIndicator;
-(IBAction)groupButtonPressed;

@end
