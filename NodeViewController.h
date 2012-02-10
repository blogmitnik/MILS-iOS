#import <UIKit/UIKit.h>
#import "AppModel.h"
#import "Node.h"
#import "MILSMoviePlayerViewController.h"
#import "AsyncImageView.h"

@interface NodeViewController : UIViewController <UITableViewDataSource,UITableViewDelegate,UIWebViewDelegate>
{
	Node *node;
	MPMoviePlayerViewController *mMoviePlayer; //only used if item is a video
	UITableView *tableView;
	UIButton *mediaPlaybackButton;
    BOOL isLink;
    BOOL hasMedia;
    BOOL imageLoaded, webLoaded;
    
    AsyncImageView *mediaImageView;
    UIActivityIndicatorView *webViewSpinner;
    NSArray *cellArray;
}

@property(readwrite, retain) Node *node;
@property(readwrite, assign) BOOL isLink;
@property(readwrite, assign) BOOL hasMedia;
@property(nonatomic, retain) IBOutlet UITableView *tableView;
@property(nonatomic, retain)UIActivityIndicatorView *webViewSpinner;
@property(nonatomic,retain)AsyncImageView *mediaImageView;
@property(nonatomic, retain)NSArray *cellArray;

@end

