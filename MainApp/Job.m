#import "Job.h"

@implementation Job

@synthesize answer;

- (id)initWithCoder:(NSCoder *)aDecoder {
	self = [super init];
	if (self) {
		// NSSecureCoding requires that we specify the class of the object while decoding it, using the decodeObjectOfClass:forKey: method.
		answer = [aDecoder decodeObjectOfClass: [NSString class] forKey:@"Job"];
	}
	return self;
}

// Because this class implements initWithCoder:, it must also return YES from this method.
+ (BOOL)supportsSecureCoding { return YES; }

- (void)encodeWithCoder:(NSCoder *)aCoder {
	[aCoder encodeObject:answer forKey:@"Job"];
}

@end
