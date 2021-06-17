#import <Foundation/Foundation.h>
#import "Job.h"

@protocol WorkerProtocol

- (void)doWorkOn:(NSString*)textIn
          thenDo:(void (^)(Job *job))job;

@end
