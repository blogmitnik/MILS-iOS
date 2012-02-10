#import <Foundation/Foundation.h>

@interface Media : NSObject {
	NSInteger	uid;
	NSString	*url;
	NSString	*type;
	
	//Image Specific Vars
	UIImage		*image; //cache of the image data	
}

@property(readonly) NSInteger	uid;
@property(readonly)	NSString	*url;
@property(readonly) NSString	*type;
@property(nonatomic, retain) UIImage	*image;


- (id) initWithId:(NSInteger)anId andUrlString:(NSString *)aUrl ofType:(NSString *)aType;

@end
