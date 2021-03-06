#import "GameDetails.h"
#import "AppServices.h"
#import "AppModel.h"
#import "MILSAppDelegate.h"
#import "commentsViewController.h"
#import <MapKit/MKReverseGeocoder.h>
#import "RatingCell.h"

#include <QuartzCore/QuartzCore.h>


NSString *const kGameDetailsHtmlTemplate = 
@"<html>"
@"<head>"
@"	<title>MILS</title>"
@"	<style type='text/css'><!--"
@"	body {"
@"		background-color: transparent;"
@"		color: #000000;"
@"		font-size: 17px;"
@"		font-family: Helvetia, Sans-Serif;"
@"		margin: 0px;"
@"	}"
@"	a {color: #FFFFFF; text-decoration: underline; }"
@"	--></style>"
@"</head>"
@"<body>%@</body>"
@"</html>";




@implementation GameDetails

@synthesize descriptionIndexPath;
@synthesize descriptionWebView;
@synthesize game;
@synthesize tableView;
@synthesize titleLabel;
@synthesize authorsLabel;
@synthesize descriptionLabel;
@synthesize locationLabel;
@synthesize scrollView;
@synthesize contentView;
@synthesize segmentedControl, newHeight, mediaImageView, splashMedia;


 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
        // Custom initialization
        self.mediaImageView = [[[AsyncImageView alloc]initWithFrame:CGRectMake(0, 0, 320, 200)] autorelease];
        self.splashMedia = [[Media alloc] init];
        self.descriptionIndexPath = [[NSIndexPath alloc] init];
    }
    return self;
}


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
	
    self.title = self.game.name;
    self.authorsLabel.text = NSLocalizedString(@"AuthorsLabelKey", @""); 
    self.authorsLabel.text = [self.authorsLabel.text stringByAppendingString:self.game.authors];
    self.descriptionLabel.text = NSLocalizedString(@"DescryptionLabelKey", @""); 
    //self.descriptionLabel.text = [self.descriptionLabel.text stringByAppendingString:self.game.description];
	[descriptionWebView setBackgroundColor:[UIColor clearColor]];
    [self.segmentedControl setTitle:[NSString stringWithFormat: @"Rating: %d",game.rating] forSegmentAtIndex:0];
    
    [super viewDidLoad];

}

- (void)viewWillAppear:(BOOL)animated {
	NSLog(@"GameDetails: View Will Appear, Refresh");
	
	
	scrollView.contentSize = CGSizeMake(contentView.frame.size.width,contentView.frame.size.height);
	
	NSString *htmlDescription = [NSString stringWithFormat:kGameDetailsHtmlTemplate, self.game.description];
	NSLog(@"GameDetails: HTML Description: %@", htmlDescription);
	descriptionWebView.delegate = self;
    descriptionWebView.hidden = NO;
	[descriptionWebView loadHTMLString:htmlDescription baseURL:nil];
    
}

- (void)webViewDidFinishLoad:(UIWebView *)descriptionView {
	//Content Loaded, now we can resize
	
	float nHeight = [[descriptionView stringByEvaluatingJavaScriptFromString:@"document.body.offsetHeight;"] floatValue];
	self.newHeight = nHeight;
	NSLog(@"GameDetails: Description View Calculated Height is: %f",newHeight);
	
	CGRect descriptionFrame = [descriptionView frame];	
	descriptionFrame.size = CGSizeMake(descriptionFrame.size.width,newHeight);
	[descriptionView setFrame:descriptionFrame];	
	NSLog(@"GameDetails: description UIWebView frame set to {%f, %f, %f, %f}", 
		  descriptionFrame.origin.x, 
		  descriptionFrame.origin.y, 
		  descriptionFrame.size.width,
		  descriptionFrame.size.height);
    NSArray *reloadArr = [[NSArray alloc] initWithObjects:self.descriptionIndexPath, nil];
    [tableView reloadRowsAtIndexPaths: reloadArr   
 withRowAnimation:UITableViewRowAnimationFade];
	
	
}

//////////////////////////////////////////////////////////////////////////////////
 

 
 - (BOOL)webView:(UIWebView *)webView  
 shouldStartLoadWithRequest:(NSURLRequest *)request  
 navigationType:(UIWebViewNavigationType)navigationType; {  
 
 NSURL *requestURL = [ [ request URL ] retain ];  
 // Check to see what protocol/scheme the requested URL is.  
 if ( ( [ [ requestURL scheme ] isEqualToString: @"http" ]  
 || [ [ requestURL scheme ] isEqualToString: @"https" ] )  
 && ( navigationType == UIWebViewNavigationTypeLinkClicked ) ) {  
 return ![ [ UIApplication sharedApplication ] openURL: [ requestURL autorelease ] ];  
 }  
 // Auto release  
 [ requestURL release ];  
 // If request url is something other than http or https it will open  
 // in UIWebView. You could also check for the other following  
 // protocols: tel, mailto and sms  
 return YES;  
 } 
 
 
 
 
 
 
 
 

//////////////////////////////////////////////////////////////////////////////////


#pragma mark -
#pragma mark Table view methods
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    switch (section){
        case 0:
            return 1;
            break;
        case 1:
            return 2;
            break;
        case 2:
            return 1;
            break;
    }
    return 0; //Should never get here
    
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
  
    
    if(section == 2) {
        return  NSLocalizedString(@"GameDescryptionKey", @"");
    }
     
    return @""; 
}
// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)aTableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	//NSLog(@"GamePickerVC: Cell requested for section: %d row: %d",indexPath.section,indexPath.row);
    
	NSString *CellIdentifier = [NSString stringWithFormat: @"Cell%d%d",indexPath.section,indexPath.row];
    UITableViewCell *cell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
		// Create a temporary UIViewController to instantiate the custom cell.
		UITableViewCell *tempCell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault 
                                                           reuseIdentifier:CellIdentifier] autorelease];
        cell = tempCell;
    }
	
    if (indexPath.section == 0 && indexPath.row == 0) {
        
        if ([self.game.mediaUrl length] > 0) {
            [self.splashMedia initWithId:1 andUrlString:self.game.mediaUrl ofType:@"Splash"];
            [self.mediaImageView loadImageFromMedia:splashMedia];
        }
        else self.mediaImageView.image = [UIImage imageNamed:@"Default.png"];
        self.mediaImageView.frame = CGRectMake(0, 0, 320, 200);
        self.mediaImageView.contentMode = UIViewContentModeScaleAspectFit;

        cell.backgroundView = mediaImageView;
        cell.backgroundView.layer.masksToBounds = YES;
        cell.backgroundView.layer.cornerRadius = 10.0;
        cell.userInteractionEnabled = NO;
    }
    else if (indexPath.section == 1 && indexPath.row == 1) {
        UIViewController *temporaryController = [[UIViewController alloc] initWithNibName:@"RatingCell" bundle:nil];
		// Grab a pointer to the custom cell
		cell = (RatingCell *)temporaryController.view;
		// Release the temporary UIViewController.
		[temporaryController release];
        RatingCell *ratingCell = (RatingCell *)cell;
        ratingCell.ratingView.rating = self.game.rating;
        ratingCell.reviewsLabel.text = [NSString stringWithFormat:@"%d %@",self.game.numReviews, NSLocalizedString(@"ReviewsTitleKey", @"")];
        [ratingCell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
        
        [ratingCell.ratingView setStarImage:[UIImage imageNamed:@"small-star-halfselected.png"]
                             forState:kSCRatingViewHalfSelected];
        [ratingCell.ratingView setStarImage:[UIImage imageNamed:@"small-star-highlighted.png"]
                             forState:kSCRatingViewHighlighted];
        [ratingCell.ratingView setStarImage:[UIImage imageNamed:@"small-star-hot.png"]
                             forState:kSCRatingViewHot];
        [ratingCell.ratingView setStarImage:[UIImage imageNamed:@"small-star-highlighted.png"]
                             forState:kSCRatingViewNonSelected];
        [ratingCell.ratingView setStarImage:[UIImage imageNamed:@"small-star-selected.png"]
                             forState:kSCRatingViewSelected];
        [ratingCell.ratingView setStarImage:[UIImage imageNamed:@"small-star-hot.png"]
                             forState:kSCRatingViewUserSelected];
        ratingCell.ratingView.userInteractionEnabled = NO;
        
    }
    else if (indexPath.section == 1 && indexPath.row ==0) {
        cell.textLabel.text = NSLocalizedString(@"PlayNowKey", @"");
        cell.textLabel.textAlignment = UITextAlignmentCenter;
    }
    else {
        descriptionIndexPath = [indexPath copy];
        cell.userInteractionEnabled = NO;
        CGRect descriptionFrame = [descriptionWebView frame];
        descriptionWebView.opaque = NO;
        descriptionWebView.backgroundColor = [UIColor clearColor];
        descriptionFrame.origin.x = 15;
        descriptionFrame.origin.y = 15;
        [descriptionWebView setFrame:descriptionFrame];
        [cell.contentView addSubview:descriptionWebView];
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 1 && indexPath.row ==0) cell.backgroundColor = [UIColor colorWithRed:182/255.0 green:230/255.0 blue:154/255.0 alpha:1.0];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 1 && indexPath.row == 1) {
        commentsViewController *commentsVC = [[commentsViewController alloc]initWithNibName:@"commentsView" bundle:nil];
        commentsVC.game = self.game;
        [self.navigationController pushViewController:commentsVC animated:YES];
        [commentsVC release];
    }
    else if  (indexPath.section == 1 && indexPath.row == 0) {
        NSDictionary *dictionary = [NSDictionary dictionaryWithObject:self.game
                                                               forKey:@"game"];
        
        [[AppServices sharedAppServices] silenceNextServerUpdate];
        NSNotification *gameSelectNotification = [NSNotification notificationWithName:@"SelectGame" object:self userInfo:dictionary];
        [[NSNotificationCenter defaultCenter] postNotification:gameSelectNotification];
        [self.navigationController popViewControllerAnimated:NO];
    }
}

- (void)tableView:(UITableView *)aTableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath{
		
}

-(CGFloat)tableView:(UITableView *)aTableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0 && indexPath.row == 0) return 200;
    else if(indexPath.section ==2 && indexPath.row ==0){
        if(self.newHeight) return self.newHeight+30;
        else return 40;
    }
    else return 40;
}







/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

#pragma mark -
#pragma mark Memory Management

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
    [descriptionWebView release];
    [game release];
    [authorsLabel release];
    [descriptionLabel release];
    [locationLabel release];
    [scrollView release];
    [contentView release];
    [tableView release];
    [segmentedControl release];
    [super dealloc];
}


@end
