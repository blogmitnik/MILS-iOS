#import "CommentCell.h"


@implementation CommentCell

@synthesize commentLabel;
@synthesize authorLabel;
@synthesize starView;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code.
    }
    return self;
}

- (void)dealloc
{
    [super dealloc];
    [commentLabel release];
    [authorLabel release];
    [starView release];
}

@end
