#import <UIKit/UIKit.h>
#import "SCRRatingView.h"

@interface CommentCell : UITableViewCell {
	UITextView *commentLabel;
	UILabel *authorLabel;
	SCRRatingView *starView;
}

@property(nonatomic,retain) IBOutlet UITextView *commentLabel;
@property(nonatomic,retain) IBOutlet UILabel *authorLabel;
@property(nonatomic,retain) IBOutlet SCRRatingView *starView;

@end