#import <UIKit/UIKit.h>


@interface WaitingIndicatorView : UIAlertView {
	UIProgressView *progressView;
}

@property(nonatomic, retain) UIProgressView *progressView;
@property(nonatomic, copy) NSString *waitingMessage;

-(void) setWaitingMessage: (NSString*) newMessage;

- (id)initWithWaitingMessage: (NSString*)m showProgressBar:(BOOL)showProgress;
- (void)show;
- (void)dismiss;


@end
