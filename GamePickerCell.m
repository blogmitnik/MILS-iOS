#import "GamePickerCell.h"


@implementation GamePickerCell

@synthesize titleLabel;
@synthesize distanceLabel;
@synthesize authorLabel;
@synthesize numReviewsLabel;
@synthesize iconView;
@synthesize starView;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code.
    }
    return self;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state.
}

- (void)dealloc {
	[titleLabel release];
	[distanceLabel release];
	[authorLabel release];
	[numReviewsLabel release];
	[iconView release];
	[starView release];
    [super dealloc];
}


@end
