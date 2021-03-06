#import "AsyncImageView.h"


@implementation AsyncImageView

@synthesize connection;
@synthesize data;
@synthesize media;
@synthesize delegate,isLoading,loaded;


- (void)loadImageFromMedia:(Media *) aMedia {
	self.media = aMedia;
    self.image = nil;

	if(self.isLoading){
        NSLog(@"AsyncImageView: loadImageFromMedia: Already loading another request...returning");
      //  [self.connection release];
       // [self.data release];
        //clear out the spinner
    }
    self.isLoading = YES;

	//check if the media already as the image, if so, just grab it
	if (self.media.image) {
		[self updateViewWithNewImage:self.media.image];
        self.loaded = YES;
		return;
	}

    if (!self.media.url) {
        NSLog(@"AsyncImageView: loadImageFromMedia with null url! ImageId:%@", self.media.uid);
        return;
    }
	
    self.loaded = NO;

	//set up indicators
	[UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
	
	//put a spinner in the view
	UIActivityIndicatorView *spinner = 
	[[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
	[spinner startAnimating];
	
	spinner.center = self.center;
	[self addSubview:spinner];
	
	if (connection!=nil) { [connection release]; }
    //if (data!=nil) { [self.data release]; }
	NSLog(@"AsyncImageView: Loading Image at %@",self.media.url);
    NSURLRequest *request = [NSURLRequest requestWithURL:[[NSURL alloc]initWithString:self.media.url]
											 cachePolicy:NSURLRequestUseProtocolCachePolicy
										 timeoutInterval:60.0];
    self.connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
}


- (void)connection:(NSURLConnection *)theConnection didReceiveData:(NSData *)incrementalData {
    if (self.data==nil) {
		self.data = [[NSMutableData alloc] initWithCapacity:2048];
    }
    [self.data appendData:incrementalData];
}

- (void)connectionDidFinishLoading:(NSURLConnection*)theConnection {
	//end the UI indicator
	[UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
	
    //clear out the spinner
    while ([[self subviews] count] > 0) {
		[[[self subviews] lastObject] removeFromSuperview];
    }
    
	//throw out the connection
    [self.connection release];
    self.connection=nil;
	
	//turn the data into an image
	UIImage* image = [UIImage imageWithData:data];
	
	//throw out the data
	[self.data release];
    self.data=nil;
	
	//Save the image in the media
	self.media.image = image;
    self.loaded = YES;
	self.isLoading= NO;
	[self updateViewWithNewImage:image];
    [[NSNotificationCenter defaultCenter] postNotification:[NSNotification notificationWithName:@"ImageReady" object:nil]];

}

- (void) updateViewWithNewImage:(UIImage*)image {
	[UIView beginAnimations:@"async" context:nil];
	[UIView setAnimationCurve:UIViewAnimationCurveLinear];
	[UIView setAnimationDuration:0.1];
	self.alpha = 0;
	[UIView commitAnimations];

	self.image = image;
	[UIView beginAnimations:@"async" context:nil];
	[UIView setAnimationCurve:UIViewAnimationCurveLinear];
	[UIView setAnimationDuration:0.25];
	self.alpha = 1.0;
	[UIView commitAnimations];
    [self setNeedsDisplay];
    if (self.delegate && [self.delegate respondsToSelector:@selector(imageFinishedLoading)]){
        [delegate imageFinishedLoading];
    }

}

- (void) setImage:(UIImage*)image {
    super.image = image;
    [self setNeedsLayout];
    [self setNeedsDisplay];
	[self.superview setNeedsLayout];
}

- (void)dealloc {
    [connection cancel];
    [connection release];
    [data release];
	[media release];
    [delegate release];
    [super dealloc];
}









@end
