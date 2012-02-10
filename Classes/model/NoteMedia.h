#import <Foundation/Foundation.h>


@interface NoteMedia : NSObject {
    NSString *text;
    int mediaId;
}

@property(nonatomic, retain) NSString *text;
@property(readwrite, assign) int mediaId;

@end
