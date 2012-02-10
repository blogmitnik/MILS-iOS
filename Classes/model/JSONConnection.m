#import "JSONConnection.h"
#import "AppModel.h"
#import "MILSAppDelegate.h"
#import "AppServices.h"
#import "MILSURLConnection.h"
#import "ASIHTTPRequest.h"

@implementation JSONConnection

@synthesize jsonServerURL;
@synthesize serviceName;
@synthesize methodName;
@synthesize arguments;
@synthesize completeRequestURL;

- (JSONConnection*)initWithServer:(NSURL *)server
			   andServiceName:(NSString *)service 
				andMethodName:(NSString *)method
				 andArguments:(NSArray *)args{
	
	self.jsonServerURL = server;
	self.serviceName = service;
	self.methodName = method;	
	self.arguments = args;	

	//Compute the Arguments
    NSString *servicePackage = @"mils_1_5";

	NSMutableString *requestParameters = [NSMutableString stringWithFormat:@"json.php/%@.%@.%@", servicePackage, self.serviceName, self.methodName];	
	NSEnumerator *argumentsEnumerator = [self.arguments objectEnumerator];
	NSString *argument;
	while (argument = [argumentsEnumerator nextObject]) {
		[requestParameters appendString:@"/"];
		[requestParameters appendString:argument];
	}
	
	//Convert into a NSURLRequest
	self.completeRequestURL = [server URLByAppendingPathComponent:requestParameters];
	NSLog(@"JSONConnection: complete URL is : %@", self.completeRequestURL);

	
	return self;
}

- (JSONResult*) performSynchronousRequest{
	
	ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:self.completeRequestURL];
	[request setNumberOfTimesToRetryOnTimeout: 2];

	
	// Make synchronous request
	[UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
	[(MILSAppDelegate *)[[UIApplication sharedApplication] delegate] showNewWaitingIndicator: NSLocalizedString(@"LoadingKey", @"") displayProgressBar:NO];
	
	[request startSynchronous];
				  
	[UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
	[(MILSAppDelegate *)[[UIApplication sharedApplication] delegate] removeNewWaitingIndicator];

	NSError *error = [request error];
	if (error) {
		NSLog(@"*** JSONConnection: performSynchronousRequest Error: %@ %@",
			  [error localizedDescription],
			  [[error userInfo] objectForKey:NSURLErrorFailingURLStringErrorKey]);
		[(MILSAppDelegate *)[[UIApplication sharedApplication] delegate] showNetworkAlert];
		return nil;		
	}				  
	
		
	NSString *jsonString = [[NSString alloc] initWithData:[request responseData] encoding:NSUTF8StringEncoding];
	
	//Get the JSONResult here
	JSONResult *jsonResult = [[[JSONResult alloc] initWithJSONString:jsonString] autorelease];
	[jsonString release];
	
	return jsonResult;
}

- (void) performAsynchronousRequestWithParser: (SEL)parser{
	
	ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:self.completeRequestURL];
	[request setNumberOfTimesToRetryOnTimeout:2];
	[request setDelegate:self];
	[request setTimeOutSeconds:10];


	//Store the parser in the request
	if (parser) [request setUserInfo:[NSDictionary dictionaryWithObject:NSStringFromSelector(parser) forKey:@"parser"]]; 
	[self retain];
	
	[request startAsynchronous];
	
	
	//Set up indicators
	[UIApplication sharedApplication].networkActivityIndicatorVisible = YES;

}


- (void)requestFinished:(ASIHTTPRequest *)request {
	NSLog(@"JSONConnection: requestFinished");
	
	//end the loading and spinner UI indicators
	[UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
	[(MILSAppDelegate *)[[UIApplication sharedApplication] delegate] removeNetworkAlert];	
	
	NSString *jsonString = [[NSString alloc] initWithData:[request responseData] 
												 encoding:NSUTF8StringEncoding];
	
	//Get the JSONResult here
	JSONResult *jsonResult = [[JSONResult alloc] initWithJSONString:jsonString];
	[jsonString release];
	
	SEL parser = NSSelectorFromString([[request userInfo] objectForKey:@"parser"]);   

	if (parser) {
		[[AppServices sharedAppServices] performSelector:parser withObject:jsonResult];
	}
	
	[jsonResult release];
}

- (void)requestFailed:(ASIHTTPRequest *)request {	
	NSError *error = [request error];
	[[NSNotificationCenter defaultCenter] postNotification:[NSNotification notificationWithName:@"ConnectionLost" object:nil]];
	// inform the user
    NSLog(@"*** JSONConnection: requestFailed: %@ %@",
          [error localizedDescription],
          [[error userInfo] objectForKey:NSURLErrorFailingURLStringErrorKey]);
	[(MILSAppDelegate *)[[UIApplication sharedApplication] delegate] resetCurrentlyFetchingVars];
	[UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    [(MILSAppDelegate *)[[UIApplication sharedApplication] delegate] removeNewWaitingIndicator];	
	[(MILSAppDelegate *)[[UIApplication sharedApplication] delegate] showNetworkAlert];	
	
}



- (void)dealloc {
	[jsonServerURL release];
	[serviceName release];
	[methodName release];
	[arguments release];
	[asyncData release];
    [completeRequestURL release];
    [super dealloc];
}
 



@end
