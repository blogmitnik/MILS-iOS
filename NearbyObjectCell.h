#import <UIKit/UIKit.h>
#import "AsyncImageView.h"

@interface NearbyObjectCell : UITableViewCell {
	UILabel *title;
	UILabel *qty;
	AsyncImageView *iconView;
}

@property(nonatomic,retain) IBOutlet UILabel *title;
@property(nonatomic,retain) IBOutlet AsyncImageView *iconView;

@end
