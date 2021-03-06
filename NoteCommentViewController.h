#import <UIKit/UIKit.h>
#import "Note.h"
#import "CameraViewController.h"
#import "AudioRecorderViewController.h"
#import "SCRRatingView.h"

@interface NoteCommentViewController : UIViewController <UITextViewDelegate,UITableViewDataSource,UITableViewDelegate>{
    IBOutlet UITableView *commentTable;
    IBOutlet UIButton *addPhotoButton;
    IBOutlet UIButton *addAudioButton;
    IBOutlet UIButton *addMediaFromAlbumButton;
    IBOutlet UIButton *addTextButton;
    IBOutlet UITextView *textBox;
    NSMutableArray *commentsList;
    Note *parentNote;
    Note *commentNote;
    int rating;
    NSIndexPath *myIndexPath;
    BOOL commentValid;
    SCRRatingView *starView;
    BOOL photoIconUsed, videoIconUsed, audioIconUsed,currNoteHasPhoto,currNoteHasAudio,currNoteHasVideo;

}
@property(nonatomic, retain)IBOutlet UITableView *commentTable;
@property(nonatomic, retain)NSMutableArray *commentsList;
@property(nonatomic, retain)IBOutlet UIButton *addPhotoButton;
@property(nonatomic, retain)IBOutlet UIButton *addAudioButton;
@property(nonatomic, retain)IBOutlet UIButton *addTextButton;
@property(nonatomic, retain)IBOutlet UIButton *addMediaFromAlbumButton;
@property(nonatomic, retain)IBOutlet UITextView *textBox;
@property(nonatomic, retain)Note *parentNote;
@property(nonatomic, retain)Note *commentNote;
@property(nonatomic, retain)NSIndexPath *myIndexPath;
@property(readwrite, assign)int rating;
@property(readwrite, assign)BOOL commentValid;
@property(readwrite,assign)BOOL photoIconUsed;
@property(readwrite,assign)BOOL audioIconUsed;
@property(readwrite,assign)BOOL videoIconUsed;
@property(readwrite,assign)BOOL currNoteHasPhoto;
@property(readwrite,assign)BOOL currNoteHasAudio;
@property(readwrite,assign)BOOL currNoteHasVideo;

@property(nonatomic,retain) IBOutlet SCRRatingView *starView;

-(IBAction)addPhotoButtonTouchAction;
-(IBAction)addAudioButtonTouchAction;
-(IBAction)addTextButtonTouchAction;
-(IBAction)addMediaFromAlbumButtonTouchAction;
-(void)addedVideo;
-(void)addedAudio;
-(void)addedText;
-(void)addedPhoto;
@end
