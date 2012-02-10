#import <UIKit/UIKit.h>
#import "AppModel.h"
#import "Game.h"
#import "MILSAppDelegate.h"
#import "CommentCell.h"
#import "Comment.h"

@interface commentsViewController :UIViewController <UITableViewDelegate,UITableViewDataSource> {
	UITableView *tableView;
    int defaultRating;
    Game *game;
}
-(void)showLoadingIndicator;
-(void)addComment: (Comment *) comment;
-(int)calculateTextHeight:(NSString *)text;
@property(nonatomic, retain) IBOutlet UITableView *tableView;
@property(nonatomic) int defaultRating;
@property(nonatomic, retain) Game *game;
@end
