#import <UIKit/UIKit.h>
#import "TutorialPopupView.h"

@interface TutorialViewController : UIViewController {

	
}

- (void) showTutorialPopupPointingToTabForViewController:(UIViewController*)vc 
													type:(tutorialPopupType)type
												   title:(NSString *)title 
												 message:(NSString *)message;

- (void) dismissTutorialPopupWithType:(tutorialPopupType)type;

- (void) dismissAllTutorials;

@end
