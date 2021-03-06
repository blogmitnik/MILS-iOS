#import "ItemActionViewController.h"
#import "MILSAppDelegate.h"
#import "AppServices.h"
#import "Media.h"

@implementation ItemActionViewController
@synthesize item,itemInInventory;
@synthesize mode;
@synthesize numItems,max;
@synthesize infoLabel,backButton,actionButton,badValLabel;
@synthesize delegate;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)dealloc
{
    [super dealloc];
    [backButton release];
    [actionButton release];
    [infoLabel release];
    [item release];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    // Do any additional setup after loading the view from its nib.
    actionButton.titleLabel.textAlignment = UITextAlignmentCenter;
    actionButton.titleLabel.font = [UIFont boldSystemFontOfSize:24];
    self.infoLabel.text = @"";
    self.infoLabel.font = [UIFont boldSystemFontOfSize:18];
    switch (self.mode) {
        case kItemDetailsPickingUp:
            [actionButton setTitle: NSLocalizedString(@"ItemPickupKey", @"") forState: UIControlStateNormal];
            [actionButton setTitle: NSLocalizedString(@"ItemPickupKey", @"") forState: UIControlStateHighlighted];

            self.max = self.item.maxQty - itemInInventory.qty;
            while ((self.max*item.weight + [AppModel sharedAppModel].currentGame.currentWeight) > [AppModel sharedAppModel].currentGame.inventoryWeightCap) {
                self.max--;
            }
            break;
        case kItemDetailsDropping:
            [actionButton setTitle: NSLocalizedString(@"ItemDropKey", @"") forState: UIControlStateNormal];
            [actionButton setTitle: NSLocalizedString(@"ItemDropKey", @"") forState: UIControlStateHighlighted];
            self.max = self.itemInInventory.qty;
            break;
        case kItemDetailsDestroying:
            [actionButton setTitle: NSLocalizedString(@"ItemDeleteKey", @"") forState: UIControlStateNormal];
            [actionButton setTitle: NSLocalizedString(@"ItemDeleteKey", @"") forState: UIControlStateHighlighted];            
            self.max = self.itemInInventory.qty;
            break;
        default:
            break;
    }
    
    self.navigationItem.leftBarButtonItem = 
	[[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"BackButtonKey",@"")
									 style: UIBarButtonItemStyleBordered
									target:self 
									action:@selector(backButtonTouchAction:)];	
    [super viewDidLoad];
    
}
- (IBAction)backButtonTouchAction: (id) sender{
	NSLog(@"ItemActionViewController: Notify server of Item view and Dismiss Item Details View");
	
	//Notify the server this item was displayed
	[[AppServices sharedAppServices] updateServerItemViewed:item.itemId];
	
	
	[self.navigationController popToRootViewControllerAnimated:YES];
	[self dismissModalViewControllerAnimated:NO];
	
}
-(void)viewDidAppear:(BOOL)animated{
    self.badValLabel.hidden = YES;
    actionButton.titleLabel.textAlignment = UITextAlignmentCenter;
    actionButton.titleLabel.font = [UIFont boldSystemFontOfSize:24];
    self.infoLabel.text = @"";
    [picker selectRow:1 inComponent:0 animated:NO];
    self.itemInInventory = [[AppModel sharedAppModel].inventory objectForKey:[NSString stringWithFormat:@"%d",item.itemId]];
    self.navigationItem.title = self.item.name;
    switch (self.mode) {
        case kItemDetailsPickingUp:
            self.actionButton.titleLabel.text = NSLocalizedString(@"ItemPickupKey", @"");
            self.max = self.item.maxQty - itemInInventory.qty;
            self.numItems = 1;
            while ((self.max*item.weight + [AppModel sharedAppModel].currentGame.currentWeight) > [AppModel sharedAppModel].currentGame.inventoryWeightCap) {
                self.max--;
            }
            break;
        case kItemDetailsDropping:
            self.actionButton.titleLabel.text = NSLocalizedString(@"ItemDropKey", @"");
            self.max = self.itemInInventory.qty;
            self.numItems = 1;
            break;
        case kItemDetailsDestroying:
            self.actionButton.titleLabel.text = NSLocalizedString(@"ItemDeleteKey",@"");
            self.max = self.itemInInventory.qty;
            self.numItems = 1;
            break;
        default:
            break;
    }


 

}

- (IBAction)actionButtonTouchAction:(id)sender{
    [self doActionWithMode:self.mode quantity:self.numItems];
    [self.navigationController popToRootViewControllerAnimated:YES];
	[self dismissModalViewControllerAnimated:NO];
    [delegate updateQuantityDisplay];
}

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    if(self.mode == kItemDetailsPickingUp)
    return (item.qty + 1);
    else 
    {
        self.itemInInventory = [[AppModel sharedAppModel].inventory objectForKey:[NSString stringWithFormat:@"%d",item.itemId]];
    }return (itemInInventory.qty + 1);
}

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    if (row == 0) return @"Max";
    else return [NSString stringWithFormat:@"%d",row];
}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    if(row == 0) {
        self.numItems = self.max;
        self.infoLabel.text = @"";
        self.badValLabel.hidden = YES;
        self.actionButton.userInteractionEnabled = YES;
        self.actionButton.alpha = 1;
    }
    else {
      self.numItems = row;
        if(self.mode == kItemDetailsPickingUp){
        if((self.numItems) > self.max)
        {
            self.infoLabel.text = [NSString stringWithFormat:@"%@ %d %@",NSLocalizedString(@"CanOnlyCarryTitleKey", @""),self.max,NSLocalizedString(@"OfThisItemTitleKey", @"")];
            self.badValLabel.hidden = NO;
            self.actionButton.userInteractionEnabled = NO;
            self.actionButton.alpha = .7;
        }
        else{ 
            self.infoLabel.text = @"";
            self.badValLabel.hidden = YES;
            self.actionButton.userInteractionEnabled = YES;
            self.actionButton.alpha = 1;
        }
        }
    }
}



-(void)doActionWithMode: (ItemDetailsModeType) itemMode quantity: (int) quantity {
    MILSAppDelegate* appDelegate = (MILSAppDelegate *)[[UIApplication sharedApplication] delegate];
	[appDelegate playAudioAlert:@"drop" shouldVibrate:YES];
	
	//Determine the Quantity Effected based on the button touched
    
	
	
	//Do the action based on the mode of the VC
	if (mode == kItemDetailsDropping) {
		NSLog(@"ItemDetailsVC: Dropping %d",quantity);
		[[AppServices sharedAppServices] updateServerDropItemHere:item.itemId qty:quantity];
		[[AppModel sharedAppModel] removeItemFromInventory:item qtyToRemove:quantity];
        
    }
	else if (mode == kItemDetailsDestroying) {
		NSLog(@"ItemDetailsVC: Destroying %d",quantity);
		[[AppServices sharedAppServices] updateServerDestroyItem:self.item.itemId qty:quantity];
		[[AppModel sharedAppModel] removeItemFromInventory:item qtyToRemove:quantity];
		
	}
	else if (mode == kItemDetailsPickingUp) {
        NSString *errorMessage;
        
		//Determine if this item can be picked up
		self.itemInInventory = [[AppModel sharedAppModel].inventory objectForKey:[NSString stringWithFormat:@"%d",item.itemId]];
		if (itemInInventory.qty + quantity > item.maxQty && item.maxQty != -1) {
            
			[appDelegate playAudioAlert:@"error" shouldVibrate:YES];
			
			if (itemInInventory.qty < item.maxQty) {
				quantity = item.maxQty - itemInInventory.qty;
                
                if([AppModel sharedAppModel].currentGame.inventoryWeightCap != 0){
                    while((quantity*item.weight + [AppModel sharedAppModel].currentGame.currentWeight) > [AppModel sharedAppModel].currentGame.inventoryWeightCap){
                        quantity--;
                    }
                }
				errorMessage = [NSString stringWithFormat:@"%@ %d", NSLocalizedString(@"CantCarryThatMuchKey", @""), quantity];
                
			}
			else if (item.maxQty == 0) {
				errorMessage = NSLocalizedString(@"ItemCannotPickedUpTitleKey", @"");
				quantity = 0;
			}
            else {
				errorMessage = NSLocalizedString(@"ItemDuplicateMessageKey", @"");
				quantity = 0;
			}
            
			UIAlertView *alert = [[UIAlertView alloc] initWithTitle: NSLocalizedString(@"InventoryOverLimitTitleKey", @"")
															message: errorMessage
														   delegate: self cancelButtonTitle: NSLocalizedString(@"OkKey", @"") otherButtonTitles: nil];
			[alert show];
			[alert release];
            
            
		}
        else if (((quantity*item.weight +[AppModel sharedAppModel].currentGame.currentWeight) > [AppModel sharedAppModel].currentGame.inventoryWeightCap)&&([AppModel sharedAppModel].currentGame.inventoryWeightCap != 0)){
            while ((quantity*item.weight + [AppModel sharedAppModel].currentGame.currentWeight) > [AppModel sharedAppModel].currentGame.inventoryWeightCap) {
                quantity--;
            }
            errorMessage = [NSString stringWithFormat:@"%@ %d", NSLocalizedString(@"CantCarryThatMuchKey", @""), quantity];
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle: @"Inventory over Limit"
															message: errorMessage
														   delegate: self cancelButtonTitle: NSLocalizedString(@"OkKey", @"") otherButtonTitles: nil];
			[alert show];
			[alert release];
        }
        
		if (quantity > 0) {
			[[AppServices sharedAppServices] updateServerPickupItem:self.item.itemId fromLocation:self.item.locationId qty:quantity];
			[[AppModel sharedAppModel] modifyQuantity:-quantity forLocationId:self.item.locationId];
			item.qty -= quantity; //the above line does not give us an update, only the map
			
        }
		
	}
		
	//Possibly Dismiss Item Details View
	if (item.qty < 1) {
		[self.navigationController popToRootViewControllerAnimated:YES];
		[self dismissModalViewControllerAnimated:NO];
        MILSAppDelegate *appDelegate = (MILSAppDelegate *)[[UIApplication sharedApplication] delegate];
        appDelegate.modalPresent = NO;
	}
	
    
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
