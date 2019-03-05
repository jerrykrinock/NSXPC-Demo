#import <Foundation/Foundation.h>
#import "Job.h"

@protocol Worker

- (void)doWorkOn:(NSString*)textIn
          thenDo:(void (^)(Job *job))job;

@end
