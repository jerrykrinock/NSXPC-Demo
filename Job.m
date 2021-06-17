#import "Job.h"

@implementation Job

- (id)initWithCoder:(NSCoder *)aDecoder {
	self = [super init];
	if (self) {
		self.answer = [aDecoder decodeObjectOfClass:[NSString class] forKey:@"Job"];
        self.workerVersion = [aDecoder decodeIntegerForKey:@"workerVersion"];
	}
	return self;
}

+ (BOOL)supportsSecureCoding {
    return YES;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
	[aCoder encodeObject:self.answer forKey:@"Job"];
    [aCoder encodeInteger:self.workerVersion forKey:@"workerVersion"];
}

@end
