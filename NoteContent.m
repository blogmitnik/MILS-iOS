#import "NoteContent.h"


@implementation NoteContent
@synthesize contentId,mediaId,noteId,sortIndex,type,text,title;

- (NoteContent *) init {
    if (self = [super init]) {
    }
    return self;	
}
- (void) dealloc {
	[type release];
	[text release];
    [title release];
	[super dealloc];
}
@end
