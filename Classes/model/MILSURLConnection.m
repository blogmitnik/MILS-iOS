#import "MILSURLConnection.h"


@implementation MILSURLConnection
@synthesize parser;

- (id)initWithRequest:(NSURLRequest *)request delegate:(id)delegate parser:(SEL)aParser {
	if (self = [self initWithRequest:(NSURLRequest *)request delegate:(id)delegate]) {
		self.parser = aParser;
	}
	return self;
}


@end
