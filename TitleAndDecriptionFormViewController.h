#import <UIKit/UIKit.h>
#import "Item.h"

@interface TitleAndDecriptionFormViewController : UIViewController <UITextFieldDelegate>{
	IBOutlet UITableView *formTableView;
	UITextField *titleField;
	UITextField *descriptionField;
	id delegate;
    Item *item;
}

@property (nonatomic, retain) IBOutlet UITableView *formTableView;
@property (nonatomic, retain) UITextField *titleField;
@property (nonatomic, retain) UITextField *descriptionField;
@property (nonatomic, retain) id delegate;
@property (nonatomic, retain) Item *item;


-(void)notifyDelegate;

@end
