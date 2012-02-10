#import <UIKit/UIKit.h>
#import "Note.h"
#import "NoteContent.h"
#import "MILSMoviePlayerViewController.h"

@interface DataCollectionViewController : UIViewController <UIScrollViewDelegate> {
    IBOutlet UIScrollView *scrollView;
    IBOutlet UIPageControl *pageControl;
    NSMutableArray *viewControllers;
    id delegate;
    int pageNumber;
    int numPages;
   // UIButton *mediaPlaybackButton;

    //MILSMoviePlayerViewController *mMoviePlayer;
    Note *note;
}

@property(nonatomic, retain) id delegate;
@property(nonatomic, retain) IBOutlet UIScrollView *scrollView;
@property(nonatomic, retain) IBOutlet UIPageControl *pageControl;
@property(nonatomic, retain) NSMutableArray *viewControllers;
//@property(nonatomic, retain) MILSMoviePlayerViewController *mMoviePlayer;
@property(nonatomic,retain)Note *note;
- (IBAction)saveButtonTouchAction;
- (IBAction)changePage:(id) sender;
- (void)loadNewPageWithContent:(NoteContent *)content;
- (void)showComments;
- (IBAction)playMovie:(id)sender;

@end
