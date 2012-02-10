#import <UIKit/UIKit.h>
#import "AsyncImageView.h"
#import "Media.h"
@interface ImageViewer : UIViewController {
    IBOutlet AsyncImageView *imageView;
    Media *media;
}
@property(nonatomic,retain)IBOutlet AsyncImageView *imageView;
@property(nonatomic,retain) Media *media;

-(void)updateImage;
@end
