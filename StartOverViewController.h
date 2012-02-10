#import <UIKit/UIKit.h>


@interface StartOverViewController : UIViewController {
	IBOutlet UIButton *startOverButton;
	IBOutlet UILabel *warningLabel;
    UIAlertView *alert;
}
@property (nonatomic, retain) UIAlertView *alert;
-(IBAction)startOverButtonPressed: (id) sender;
-(void)dismissAlert;
@end
