#import <Foundation/Foundation.h>


@interface Tab : NSObject {
    NSString *tabName;
    int tabIndex;
}

@property(nonatomic,retain)NSString *tabName;
@property(readwrite,assign)int tabIndex;

@end
