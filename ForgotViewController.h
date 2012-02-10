#import <UIKit/UIKit.h>

@interface ForgotViewController : UIViewController<UITextFieldDelegate> {
    IBOutlet UITextField *userField;
    IBOutlet UILabel *userLabel;

}
@property(nonatomic,retain)IBOutlet UITextField *userField;
@property(nonatomic,retain)IBOutlet UILabel *userLabel;


@end
