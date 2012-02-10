#import <UIKit/UIKit.h>
#import "AppModel.h"



@interface SelfRegistrationViewController : UIViewController <UITextFieldDelegate, UITextViewDelegate> {
	IBOutlet UITextField *userName;
	IBOutlet UITextField *password;
	IBOutlet UITextField *email;
	IBOutlet UIButton *createAccountButton;

	
}

@property (nonatomic, retain) IBOutlet UITextField *userName;
@property (nonatomic, retain) IBOutlet UITextField *password;
@property (nonatomic, retain) IBOutlet UITextField *email;


-(IBAction)submitButtonTouched: (id) sender;


@end
