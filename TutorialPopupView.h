#import <UIKit/UIKit.h>

enum {
	tutorialPopupKindNearbyTab		= 0,
	tutorialPopupKindQuestsTab		= 1,
	tutorialPopupKindMapTab			= 2,
	tutorialPopupKindInventoryTab	= 3,
};
typedef UInt32 tutorialPopupType;


@interface TutorialPopupView : UIView {
	CGFloat pointerXpos;
	NSString *title;
	NSString *message;
	tutorialPopupType type;
	UIViewController *associatedViewController;
}

@property (readwrite) CGFloat pointerXpos;
@property (nonatomic,retain) NSString *title;
@property (nonatomic,retain) NSString *message;
@property (readwrite) tutorialPopupType type;
@property (nonatomic,retain) UIViewController *associatedViewController;

-(void) updatePointerPosition;

@end
