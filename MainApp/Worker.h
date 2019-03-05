#import <Foundation/Foundation.h>
#import "Job.h"

@protocol Worker

- (void)doWorkOn:(NSString*)textIn
           reply:(void (^)(Job *job))job;

@end
