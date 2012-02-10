#import "CommentsFormCell.h"
#import "AppServices.h"

@implementation CommentsFormCell
@synthesize ratingView;
@synthesize textField;
@synthesize saveButton;
@synthesize game,commentsVC;
@synthesize alert;


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code.
    }
    return self;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    
    //[super setSelected:selected animated:animated];
    
    // Configure the view for the selected state.
}

- (IBAction)saveComment:(id)sender {
    if([self.textField.text length] == 0){
        self.alert = [[UIAlertView alloc] initWithTitle: NSLocalizedString(@"Error", @"")
                                                message: NSLocalizedString(@"EnterCommentKey", @"")
                                               delegate: self cancelButtonTitle: NSLocalizedString(@"OK", @"") otherButtonTitles: nil];
        [self.alert show];
        [self.alert release];
    }
    else if(self.ratingView.userRating == 0){
        self.alert = [[UIAlertView alloc] initWithTitle: NSLocalizedString(@"Error", @"")
                                                message: NSLocalizedString(@"GiveRatingKey", @"")
                                               delegate: self cancelButtonTitle: NSLocalizedString(@"OK", @"") otherButtonTitles: nil];
        [self.alert show];
        [self.alert release];
    }
    else{
        self.alert = [[UIAlertView alloc] initWithTitle: NSLocalizedString(@"SuccessKey", @"a")
                                                message: NSLocalizedString(@"SuccessfullyPostedKey", @"")
                                               delegate: self cancelButtonTitle: NSLocalizedString(@"OK", @"") otherButtonTitles: nil];
        [self.alert show];
        [self.alert release];
        [[AppServices sharedAppServices] saveComment:self.textField.text game:self.game.gameId starRating:self.ratingView.userRating];
        
        self.commentsVC.defaultRating = self.ratingView.userRating;
        
        //Add comment client side
        Comment *comment = [[Comment alloc]init];
        comment.text = self.textField.text;
        comment.rating = self.ratingView.userRating;
        comment.playerName = NSLocalizedString(@"DialogPlayerName", @"");
        [self.commentsVC addComment:comment];
        [self.commentsVC.tableView reloadData];
        [comment release];
        //End client side manipulation
    }
}
-(void)textViewDidBeginEditing:(UITextView *)textView{
    [textView setText:@""];
}

- (void)dealloc
{
    [ratingView release];
    [textField release];
    [saveButton release];
    [super dealloc];

}


@end
