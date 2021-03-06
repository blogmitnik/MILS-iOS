#import "GamePickerRecentViewController.h"
#import "AppServices.h"
#import "Game.h"
#import "MILSAppDelegate.h"
#import "GameDetails.h"
#import "GamePickerCell.h"
#include <QuartzCore/QuartzCore.h>

@implementation GamePickerRecentViewController

@synthesize gameTable;
@synthesize gameList;
@synthesize refreshButton;


//Override init for passing title and icon to tab bar
- (id)initWithNibName:(NSString *)nibName bundle:(NSBundle *)nibBundle
{
    self = [super initWithNibName:nibName bundle:nibBundle];
    if (self) {
        self.title = NSLocalizedString(@"RecentGamesTitleKey", @"");

        self.tabBarItem = [[UITabBarItem alloc] initWithTabBarSystemItem:UITabBarSystemItemRecents tag:0];	
        NSNotificationCenter *dispatcher = [NSNotificationCenter defaultCenter];
        [dispatcher addObserver:self selector:@selector(refresh) name:@"PlayerMoved" object:nil];
        [dispatcher addObserver:self selector:@selector(removeLoadingIndicator) name:@"ConnectionLost" object:nil];

    }
    return self;
}

- (void)dealloc {
	[[NSNotificationCenter defaultCenter] removeObserver:self];

    [gameList release];
    [refreshButton release];
    [distanceControl release];
    [locationalControl release];
	[gameTable release];
    [super dealloc];
}



#pragma mark - View lifecycle

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	
    self.refreshButton = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:self action:@selector(refresh)];
    
    self.navigationItem.rightBarButtonItem = self.refreshButton;
    self.gameList = [NSArray array];
    [self refresh];
	NSLog(@"GamePickerViewController: View Loaded");
}

- (void)viewDidAppear:(BOOL)animated {
	NSLog(@"GamePickerViewController: View Appeared");	
    [gameTable reloadData];
	[self refresh];
    
	NSLog(@"GamePickerRecentViewController: view did appear");
}


-(void)refresh {
	NSLog(@"GamePickerRecentViewController: Refresh Requested");
    
    //register for notifications
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshViewFromModel) name:@"NewRecentGameListReady" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(removeLoadingIndicator) name:@"RecievedGameList" object:nil];
    
    [[AppServices sharedAppServices] fetchRecentGameListForPlayer];
	
    [self showLoadingIndicator];
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

-(void)removeLoadingIndicator{
    
	[[self navigationItem] setRightBarButtonItem:self.refreshButton];
    [gameTable reloadData];
}


- (void)refreshViewFromModel {
	NSLog(@"GamePickerViewController: Refresh View from Model");
	
    //unregister for notifications
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
	self.gameList = [AppModel sharedAppModel].recentGameList;
    
	[gameTable reloadData];
}


#pragma mark Table view methods
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}


// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return [self.gameList count];
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	//NSLog(@"GamePickerVC: Cell requested for section: %d row: %d",indexPath.section,indexPath.row);
    
	
	static NSString *CellIdentifier = @"Cell";
    GamePickerCell *cell = (GamePickerCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
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

-(void)controlChanged:(id)sender{
    //Do nothing...
}



- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}



@end
