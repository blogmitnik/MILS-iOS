#import <UIKit/UIKit.h>
#import "WebPage.h"
#import "AppModel.h"

@interface webpageViewController : UIViewController <UIWebViewDelegate>{
    IBOutlet	UIWebView	*webView;
    WebPage     *webPage;
    IBOutlet UIView  *blackView;
    NSObject *delegate;
    IBOutlet	UIActivityIndicatorView *activityIndicator;
}

@property(nonatomic, retain) IBOutlet UIWebView		*webView;
@property(nonatomic,retain) WebPage *webPage;
@property(nonatomic,retain) NSObject  *delegate;
@property(nonatomic, retain) IBOutlet UIActivityIndicatorView *activityIndicator;
@property(nonatomic,retain)IBOutlet UIView *blackView;

- (BOOL)webView:(UIWebView*)webView shouldStartLoadWithRequest: (NSURLRequest*)req navigationType:(UIWebViewNavigationType)navigationType;
- (void) showWaitingIndicator;
- (void) dismissWaitingIndicator;
- (void)refreshConvos;

@end
