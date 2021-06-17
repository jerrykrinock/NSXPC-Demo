#import <Foundation/Foundation.h>

@interface Job : NSObject <NSSecureCoding> {
}

@property (copy) NSString* answer;
@property (assign) NSInteger workerVersion;

@end
