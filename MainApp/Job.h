#import <Foundation/Foundation.h>

@interface Job : NSObject <NSSecureCoding> {
	NSString* answer;
}

@property (copy) NSString* answer;

@end
