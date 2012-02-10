#import <Foundation/Foundation.h>


@interface MILSURLConnection : NSURLConnection {
	
	SEL parser;
}

@property(readwrite) SEL parser;

- (id)initWithRequest:(NSURLRequest *)request delegate:(id)delegate parser:(SEL)parser;

@end
