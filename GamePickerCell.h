#import <UIKit/UIKit.h>
#import "AsyncImageView.h"
#import "SCRRatingView.h"

@interface GamePickerCell : UITableViewCell {
	UILabel *titleLabel;
	UILabel *distanceLabel;
	UILabel *authorLabel;
	UILabel *numReviewsLabel;
	AsyncImageView *iconView;
	SCRRatingView *starView;
}

@property(nonatomic,retain) IBOutlet UILabel *titleLabel;
@property(nonatomic,retain) IBOutlet UILabel *distanceLabel;
@property(nonatomic,retain) IBOutlet UILabel *authorLabel;
@property(nonatomic,retain) IBOutlet UILabel *numReviewsLabel;
@property(nonatomic,retain) IBOutlet AsyncImageView *iconView;
@property(nonatomic,retain) IBOutlet SCRRatingView *starView;

@end
