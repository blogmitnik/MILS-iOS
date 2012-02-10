#import <Foundation/Foundation.h>


@interface Comment : NSObject {
    NSString *text;
    NSString *playerName;
    int rating;
}

@property(copy, readwrite) NSString *text;
@property(copy, readwrite) NSString *playerName;  
@property(readwrite) int rating;

@end
