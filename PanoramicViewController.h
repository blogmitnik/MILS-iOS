#import <UIKit/UIKit.h>
#import "Panoramic.h"
#import "PLView.h"
#import "Media.h"

@interface PanoramicViewController : UIViewController <UIImagePickerControllerDelegate>{
    Panoramic *panoramic;
    IBOutlet PLView	*plView;
    NSURLConnection *connection;
    NSMutableData* data; //keep reference to the data so we can collect it as it downloads
    Media *media;
    UIImagePickerController *imagePickerController;
    IBOutlet UISlider *slider;
    BOOL viewHasAlreadyAppeared;
    int numTextures;
    int lblSpacing;
    NSObject *delegate;
    BOOL showedAlignment;
}

@property (nonatomic,retain) Panoramic *panoramic;
@property (nonatomic, retain) NSObject *delegate;
@property(nonatomic, retain) IBOutlet PLView *plView;
@property (nonatomic, retain) NSURLConnection *connection;
@property (nonatomic, retain) NSMutableData* data;
@property (nonatomic, retain) Media *media;
@property (nonatomic, retain) UIImagePickerController *imagePickerController;
@property (readwrite,assign) BOOL viewHasAlreadyAppeared;
@property (readwrite,assign) BOOL showedAlignment;
@property (nonatomic,retain) IBOutlet UISlider *slider;
@property (readwrite,assign) int numTextures;
@property (readwrite,assign) int lblSpacing;


- (void)loadImageFromMedia:(Media *) aMedia;
-(IBAction) touchScreen;
-(IBAction) sliderValueChanged: (id) sender;
- (void)showPanoView;
@end
