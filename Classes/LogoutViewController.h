#import <UIKit/UIKit.h>


@interface LogoutViewController : UIViewController {
	IBOutlet UIButton *logoutButton;
	IBOutlet UILabel *warningLabel;
}

-(IBAction)logoutButtonPressed: (id) sender;

@end
