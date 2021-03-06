#import <Foundation/Foundation.h>
#import "JSONResult.h"


@interface JSONConnection : NSObject{
	NSURL *jsonServerURL;
	NSString *serviceName;
	NSString *methodName;
	NSArray *arguments;
	NSMutableData *asyncData;
	NSURL *completeRequestURL;
}

@property(nonatomic, retain) NSURL *jsonServerURL;
@property(nonatomic, retain) NSString *serviceName;
@property(nonatomic, retain) NSString *methodName;
@property(nonatomic, retain) NSArray *arguments;
@property(nonatomic, retain) NSURL *completeRequestURL;


- (JSONConnection*)initWithServer: (NSURL *)server
					andServiceName:(NSString *)serviceName 
					andMethodName:(NSString *)methodName
					andArguments:(NSArray *)arguments;

- (JSONResult*) performSynchronousRequest;
- (void) performAsynchronousRequestWithParser: (SEL)parser;

@end
