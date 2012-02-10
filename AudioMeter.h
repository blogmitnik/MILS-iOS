#import <UIKit/UIKit.h>


@interface AudioMeter : UIView {

	NSMutableArray *barViews;
	int numberofBars;
	int spacingBetweenBars;
	UIColor *activeColor;
	UIColor *inactiveColor;
}

@property(readwrite, retain) NSMutableArray *barViews;
@property(readwrite) int numberofBars;
@property(readwrite) int spacingBetweenBars;
@property(readwrite, retain) UIColor *activeColor;
@property(readwrite, retain) UIColor *inactiveColor;


- (void)updateLevel:(double)level;

@end
