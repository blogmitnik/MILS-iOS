#import "MILSMoviePlayerViewController.h"

@implementation MILSMoviePlayerViewController

- (void)viewDidLoad
{
	self.view.backgroundColor = [UIColor blackColor];
	[super viewDidLoad];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
	/*
	if((interfaceOrientation == UIInterfaceOrientationLandscapeLeft)
	   || (interfaceOrientation == UIInterfaceOrientationLandscapeRight))
		return YES;
	else if((interfaceOrientation == UIInterfaceOrientationPortrait)
			|| (interfaceOrientation == UIInterfaceOrientationPortraitUpsideDown))
		return NO;
	 */
	return YES;
}

@end