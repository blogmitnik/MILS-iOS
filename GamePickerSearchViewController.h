#import <UIKit/UIKit.h>
#import "AppModel.h"

@interface GamePickerSearchViewController : UIViewController <UITableViewDelegate,UITableViewDataSource, UISearchDisplayDelegate, UISearchBarDelegate>{
    
	NSArray *gameList;
    UISearchBar *theSearchBar;
    UIView *disableViewOverlay;
	UITableView *gameTable;
    UIBarButtonItem *refreshButton;
    NSString *searchText;
}

-(void)refresh;
-(void)showLoadingIndicator;
- (void)searchBar:(UISearchBar *)searchBar activate:(BOOL) active;

@property(retain) UIView *disableViewOverlay;
@property (nonatomic, copy) NSArray *gameList;
@property (nonatomic, retain) NSString *searchText;
@property (nonatomic, retain) IBOutlet UITableView *gameTable;
@property (nonatomic, retain) IBOutlet UIBarButtonItem *refreshButton;
@property (nonatomic, retain) IBOutlet UISearchBar *theSearchBar;

@end
