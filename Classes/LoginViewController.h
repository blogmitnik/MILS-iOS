#import <UIKit/UIKit.h>
#import "AppModel.h"

@interface LoginViewController : UIViewController {

	IBOutlet UITextField *usernameField;
	IBOutlet UITextField *passwordField;
	IBOutlet UIButton *loginButton;
	IBOutlet UIButton *newAccountButton;
    IBOutlet UIButton *changePassButton;

	IBOutlet UILabel *newAccountMessageLabel;
    IBOutlet UILabel *welcomeLoginMessageLabel;
}

-(IBAction)newAccountButtonTouched: (id) sender;
-(IBAction)loginButtonTouched: (id) sender;
-(IBAction)changePassTouch;

@end
