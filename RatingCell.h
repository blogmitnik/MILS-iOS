#import <UIKit/UIKit.h>
#import "SCRRatingView.h"


@interface RatingCell : UITableViewCell {
    SCRRatingView *ratingView;
    UILabel *reviewsLabel;
}

@property (nonatomic,retain) IBOutlet SCRRatingView *ratingView;
@property (nonatomic,retain) IBOutlet UILabel *reviewsLabel;


@end
