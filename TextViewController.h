#import <UIKit/UIKit.h>
#import "Note.h"

@interface TextViewController : UIViewController <UITextViewDelegate>{
    IBOutlet UITextView *textBox;
    IBOutlet UIButton *keyboardButton;
    NSString *textToDisplay;
    int noteId;
    BOOL editMode;
    BOOL previewMode;
    id delegate;
    int contentId;
}
@property(nonatomic,retain) IBOutlet UITextView *textBox;
@property(nonatomic, retain) IBOutlet UIButton *keyboardButton;
@property(nonatomic, retain) id delegate;
@property(nonatomic,retain)NSString *textToDisplay;
@property(readwrite, assign) int noteId;
@property(readwrite, assign) int contentId;

@property(readwrite,assign)BOOL editMode;
@property(readwrite,assign)BOOL previewMode;

- (IBAction)saveButtonTouchAction;
- (IBAction) hideKeyboard;
-(void)updateContentTouchAction;
@end
