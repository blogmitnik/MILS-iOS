#import "LoginViewController.h"
#import "SelfRegistrationViewController.h"
#import "MILSAppDelegate.h"
#import "ChangePasswordViewController.h"
#import "ForgotViewController.h"

@implementation LoginViewController



//Override init for passing title and icon to tab bar
- (id)initWithNibName:(NSString *)nibName bundle:(NSBundle *)nibBundle
{
    self = [super initWithNibName:nibName bundle:nibBundle];
    if (self) {
        self.title = NSLocalizedString(@"LoginTitleKey", @"");
    }
    return self;
}


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
		
    welcomeLoginMessageLabel.text = NSLocalizedString(@"WelcomeLoginMessageKey", @"");
	usernameField.placeholder = NSLocalizedString(@"UsernameKey", @"");
	passwordField.placeholder = NSLocalizedString(@"PasswordKey", @"");
	[loginButton setTitle:NSLocalizedString(@"LoginKey",@"") forState:UIControlStateNormal];
	newAccountMessageLabel.text = NSLocalizedString(@"NewAccountMessageKey", @"");
	[newAccountButton setTitle:NSLocalizedString(@"CreateAccountKey",@"") forState:UIControlStateNormal];
		
	NSLog(@"Login View Loaded");
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField {
	if (textField == usernameField) {
		[passwordField becomeFirstResponder];
	}	
	if(textField == passwordField) {
		[self loginButtonTouched:self];
	}

    return YES;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning]; // Releases the view if it doesn't have a superview
    // Release anything that's not essential, such as cached data
}

-(IBAction)loginButtonTouched: (id) sender {
	NSLog(@"Login: Login Button Touched");

	MILSAppDelegate *appDelegate = (MILSAppDelegate *)[[UIApplication sharedApplication] delegate];
	[appDelegate attemptLoginWithUserName:usernameField.text andPassword:passwordField.text]; 
    
	[usernameField resignFirstResponder];
	[passwordField resignFirstResponder];
}
-(void)changePassTouch{
    NSLog(@"Login: Change Password Button Touched");
	ForgotViewController *forgotPassViewController = [[ForgotViewController alloc] 
                                                                      initWithNibName:@"ForgotViewController" bundle:[NSBundle mainBundle]];
	
	//Put the view on the screen
	[[self navigationController] pushViewController:forgotPassViewController animated:YES];
	[forgotPassViewController release];
}
-(IBAction)newAccountButtonTouched: (id) sender{
	NSLog(@"Login: New User Button Touched");
	SelfRegistrationViewController *selfRegistrationViewController = [[SelfRegistrationViewController alloc] 
															initWithNibName:@"SelfRegistration" bundle:[NSBundle mainBundle]];
	
	//Put the view on the screen
	[[self navigationController] pushViewController:selfRegistrationViewController animated:YES];
	[selfRegistrationViewController release];
	
}


- (void)dealloc {
	[usernameField release];
	[passwordField release];
	[loginButton release];
    [welcomeLoginMessageLabel release];
	[newAccountMessageLabel release];
	[newAccountButton release];
    [super dealloc];
}


@end
