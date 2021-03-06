#import <UIKit/UIKit.h>
#import "AppModel.h"
#import "Item.h"
#import "itemDetailsMode.h"

@interface ItemActionViewController : UIViewController<UIPickerViewDelegate, UIPickerViewDataSource> {
    IBOutlet UIButton *backButton;
    IBOutlet UIButton *actionButton;
    IBOutlet UILabel *infoLabel;
    IBOutlet UILabel *badValLabel;
    IBOutlet UIPickerView *picker;
    ItemDetailsModeType mode;
    Item *item;
    Item *itemInInventory;
    int numItems;
    int max;
    id delegate;
}
@property(readwrite,assign) int numItems;
@property(readwrite,assign) int max;

@property(readwrite) ItemDetailsModeType mode;
@property(nonatomic,retain)	IBOutlet UILabel *infoLabel;
@property(nonatomic,retain)	IBOutlet UILabel *badValLabel;

@property(nonatomic,retain) IBOutlet UIButton *backButton;
@property(nonatomic,retain) IBOutlet UIButton *actionButton;
@property(nonatomic,retain) Item *item;
@property(nonatomic,retain) Item *itemInInventory;

@property(nonatomic,retain)	id delegate;


-(void)doActionWithMode: (ItemDetailsModeType) itemMode quantity: (int) quantity;
- (IBAction)backButtonTouchAction: (id) sender;
- (IBAction)actionButtonTouchAction: (id) sender;

@end
