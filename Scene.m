#import "Scene.h"


@implementation Scene

@synthesize text;
@synthesize isPc;
@synthesize imageMediaId;
@synthesize imageRect;
@synthesize zoomTime;
@synthesize foreSoundMediaId;	
@synthesize backSoundMediaId;
@synthesize exitToTabWithTitle,videoId,panoId,webId,plaqueId,itemId,exitToType;

- (id) initWithText:(NSString *)theText 
               isPc:(Boolean)isPcYorN 
       imageMediaId:(int)iMediaId 
          imageRect:(CGRect)rect 
           zoomTime:(float)seconds
          foreSoundMediaId:(int)fgMediaId 
       backSoundMediaId:(int)bgMediaId
   exitToTabWithTitle:(NSString*)tabTitle 
exitToType:(NSString *)type videoId:(int)vidId panoramicId:(int)pId webpageId:(int)wId plaqueId:(int)nodeId itemId:(int)iId {
	
	if ((self = [super init])) {
        self.text = [[theText copy] retain];
        self.isPc = isPcYorN;
        self.imageMediaId = iMediaId;
        self.imageRect = rect;
        self.zoomTime = seconds;
        self.foreSoundMediaId = fgMediaId;	
        self.backSoundMediaId = bgMediaId;
        self.exitToTabWithTitle = tabTitle;
        self.videoId = vidId;
        self.panoId = pId;
        self.webId = wId;
        self.plaqueId = nodeId;
        self.itemId = iId;
        self.exitToType = type;
	}
	return self;
}

- (void) dealloc {
	[text release];
	[super dealloc];
}
@end
