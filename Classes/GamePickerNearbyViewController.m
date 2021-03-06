#import "GamePickerNearbyViewController.h"
#import "AppServices.h"
#import "Game.h"
#import "MILSAppDelegate.h"
#import "GameDetails.h"
#import "GamePickerCell.h"
#include <QuartzCore/QuartzCore.h>
#include "AsyncImageView.h"

@implementation GamePickerNearbyViewController

@synthesize gameTable;
@synthesize gameList, gameIcons;
@synthesize refreshButton,count;


//Override init for passing title and icon to tab bar
- (id)initWithNibName:(NSString *)nibName bundle:(NSBundle *)nibBundle
{
    self = [super initWithNibName:nibName bundle:nibBundle];
    if (self) {
        self.title = NSLocalizedString(@"NearbyTitle", @"");
        self.tabBarItem.image = [UIImage imageNamed:@"game.png"];
        self.gameIcons = [NSMutableArray arrayWithCapacity:[[AppModel sharedAppModel].gameList count]];
        NSNotificationCenter *dispatcher = [NSNotificationCenter defaultCenter];
        [dispatcher addObserver:self selector:@selector(refresh) name:@"PlayerMoved" object:nil];
        


    }
    return self;
}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	
    self.refreshButton = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:self action:@selector(refresh)];
    
    self.navigationItem.rightBarButtonItem = self.refreshButton;
  	[gameTable reloadData];

    [self refresh];

	NSLog(@"GamePickerViewController: View Loaded");
}

- (void)viewDidAppear:(BOOL)animated {
	NSLog(@"GamePickerViewController: View Appeared");	
	
	//self.gameList = [NSMutableArray arrayWithCapacity:1];

	[self refresh];
    
	NSLog(@"GamePickerViewController: view did appear");

}


-(void)refresh {
	NSLog(@"GamePickerViewController: Refresh Requested");
    

    
        //Calculate locational control value
    BOOL locational;
    if (locationalControl.selectedSegmentIndex == 0) {
     locational = YES;  
        distanceControl.enabled = YES;
        distanceControl.alpha = 1;
    }
    else
    {
      locational = NO;
        distanceControl.alpha = .2;
        distanceControl.enabled = NO;
    }
	
    //Calculate distance filer controll value
    int distanceFilter;
    switch (distanceControl.selectedSegmentIndex) {
        case 0:
            distanceFilter = 100;
            break;
        case 1:
            distanceFilter = 1000;
            break;
        case 2:
            distanceFilter = 50000;
            break;
    
    }
    if([AppModel sharedAppModel].playerLocation){
    //register for notifications
    NSNotificationCenter *dispatcher = [NSNotificationCenter defaultCenter];
    [dispatcher addObserver:self selector:@selector(refreshViewFromModel) name:@"NewGameListReady" object:nil];
    [dispatcher addObserver:self selector:@selector(removeLoadingIndicator) name:@"RecievedGameList" object:nil];
        [dispatcher addObserver:self selector:@selector(removeLoadingIndicator) name:@"ConnectionLost" object:nil];
    
    [[AppServices sharedAppServices] fetchGameListWithDistanceFilter:distanceFilter locational:locational];
        [self showLoadingIndicator];}
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning]; // Releases the view if it doesn't have a superview
    // Release anything that's not essential, such as cached data
}

#pragma mark custom methods, logic
-(void)showLoadingIndicator{
	UIActivityIndicatorView *activityIndicator = 
	[[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
	UIBarButtonItem * barButton = [[UIBarButtonItem alloc] initWithCustomView:activityIndicator];
	[activityIndicator release];
	[[self navigationItem] setRightBarButtonItem:barButton];
	[barButton release];
	[activityIndicator startAnimating];


}

-(void) viewWillAppear:(BOOL)animated{

}

-(void)removeLoadingIndicator{
	[[self navigationItem] setRightBarButtonItem:self.refreshButton];
    [gameTable reloadData];
}

- (void)refreshViewFromModel {
	NSLog(@"GamePickerViewController: Refresh View from Model");
    
    //unregister for notifications
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
	self.gameList = [[AppModel sharedAppModel].gameList sortedArrayUsingSelector:@selector(compareCalculatedScore:)];
    [gameTable reloadData];
}

#pragma mark Control Callbacks
-(IBAction)controlChanged:(id)sender{
        
    if (sender == locationalControl || 
        locationalControl.selectedSegmentIndex == 0) 
    [self refresh];

}
    

#pragma mark Table view methods
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if([self.gameList count] == 0 && [AppModel sharedAppModel].playerLocation) return 1;
	return [self.gameList count];
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	//NSLog(@"GamePickerVC: Cell requested for section: %d row: %d",indexPath.section,indexPath.row);

	static NSString *CellIdentifier = @"Cell";
    
    if([self.gameList count] == 0){
        UITableViewCell *cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] autorelease];
        cell.textLabel.text = NSLocalizedString(@"NoGamesFoundKey", @"");
        cell.detailTextLabel.text = NSLocalizedString(@"CreateNewGameKey", @"");
        return cell;
    }
    
    UITableViewCell *tempCell = (GamePickerCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (![tempCell respondsToSelector:@selector(starView)]){
        //[tempCell release];
        tempCell = nil;
    }
    GamePickerCell *cell = (GamePickerCell *)tempCell;
    if (cell == nil) {
		// Create a temporary UIViewController to instantiate the custom cell.
		UIViewController *temporaryController = [[UIViewController alloc] initWithNibName:@"GamePickerCell" bundle:nil];
		// Grab a pointer to the custom cell.
		cell = (GamePickerCell *)temporaryController.view;
		// Release the temporary UIViewController.
		[temporaryController release];
    }
	Game *currentGame = [self.gameList objectAtIndex:indexPath.row];

	cell.titleLabel.text = currentGame.name;
	double dist = currentGame.distanceFromPlayer;
	cell.distanceLabel.text = [NSString stringWithFormat:@"%1.1f %@",  dist/1000, NSLocalizedString(@"KilometersKey", @"") ];
	cell.authorLabel.text = currentGame.authors;
	cell.numReviewsLabel.text = [NSString stringWithFormat:@"%@ %@", [[NSNumber numberWithInt:currentGame.numReviews] stringValue], NSLocalizedString(@"ReviewsTitleKey", @"")];
    cell.starView.rating = currentGame.rating;
    cell.starView.backgroundColor = [UIColor clearColor];
	
    [cell.starView setStarImage:[UIImage imageNamed:@"small-star-halfselected.png"]
                               forState:kSCRatingViewHalfSelected];
    [cell.starView setStarImage:[UIImage imageNamed:@"small-star-highlighted.png"]
                               forState:kSCRatingViewHighlighted];
    [cell.starView setStarImage:[UIImage imageNamed:@"small-star-hot.png"]
                               forState:kSCRatingViewHot];
    [cell.starView setStarImage:[UIImage imageNamed:@"small-star-highlighted.png"]
                               forState:kSCRatingViewNonSelected];
    [cell.starView setStarImage:[UIImage imageNamed:@"small-star-selected.png"]
                               forState:kSCRatingViewSelected];
    [cell.starView setStarImage:[UIImage imageNamed:@"small-star-hot.png"]
                               forState:kSCRatingViewUserSelected];
    
  
    //Set up the Icon
    //Create a new iconView for each cell instead of reusing the same one
    AsyncImageView *iconView = [[AsyncImageView alloc] initWithFrame:CGRectMake(0, 0, 50, 50)];

        
		Media *iconMedia = [[Media alloc] initWithId:1 andUrlString:currentGame.iconMediaUrl ofType:@"Icon"];
    if(currentGame.iconMedia.image){
        iconView.image = currentGame.iconMedia.image;
    }
    else {
        if([currentGame.iconMediaUrl length] == 0) iconView.image = [UIImage imageNamed:@"Icon.png"];
        else{
        currentGame.iconMedia = iconMedia;
        [iconView loadImageFromMedia:iconMedia];
        [iconMedia release];
        }
    }

    iconView.layer.masksToBounds = YES;
    iconView.layer.cornerRadius = 10.0;
    
    //clear out icon view
    if([cell.iconView.subviews count]>0)
    [[cell.iconView.subviews objectAtIndex:0] removeFromSuperview];
    
    
    [cell.iconView addSubview: iconView];
   
    [iconView release];
    return cell;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    //Color the backgrounds
    if (indexPath.row % 2 == 0){  
        cell.backgroundColor = [UIColor colorWithRed:233.0/255.0  
                                               green:233.0/255.0  
                                                blue:233.0/255.0  
                                               alpha:1.0];  
    } else {  
        cell.backgroundColor = [UIColor colorWithRed:200.0/255.0  
                                               green:200.0/255.0  
                                                blue:200.0/255.0  
                                               alpha:1.0];  
    } 
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if([self.gameList count] == 0) return;
    //do select game notification;
    Game *selectedGame;
	selectedGame = [self.gameList objectAtIndex:indexPath.row];
	
	GameDetails *gameDetailsVC = [[GameDetails alloc]initWithNibName:@"GameDetails" bundle:nil];
	gameDetailsVC.game = selectedGame;
	[self.navigationController pushViewController:gameDetailsVC animated:YES];
	[gameDetailsVC release];	
		
}

- (void)tableView:(UITableView *)aTableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath{
	Game *selectedGame;
	selectedGame = [self.gameList objectAtIndex:indexPath.row];
	
	GameDetails *gameDetailsVC = [[GameDetails alloc]initWithNibName:@"GameDetails" bundle:nil];
	gameDetailsVC.game = selectedGame;
	[self.navigationController pushViewController:gameDetailsVC animated:YES];
	[gameDetailsVC release];	
}

-(CGFloat)tableView:(UITableView *)aTableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
	return 60;
}


/*
 // Override to support conditional editing of the table view.
 - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
 // Return NO if you do not want the specified item to be editable.
 return YES;
 }
 */


/*
 // Override to support editing the table view.
 - (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
 
 if (editingStyle == UITableViewCellEditingStyleDelete) {
 // Delete the row from the data source
 [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:YES];
 }   
 else if (editingStyle == UITableViewCellEditingStyleInsert) {
 // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
 }   
 }
 */


/*
 // Override to support rearranging the table view.
 - (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
 }
 */


/*
 // Override to support conditional rearranging of the table view.
 - (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
 // Return NO if you do not want the item to be re-orderable.
 return YES;
 }
 */


- (void)dealloc {
	[[NSNotificationCenter defaultCenter] removeObserver:self];
    [gameIcons release];
    [gameTable release];
    [gameList release];
    [refreshButton release];
    [super dealloc];
}


@end
