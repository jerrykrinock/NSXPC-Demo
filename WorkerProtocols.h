#import <Foundation/Foundation.h>
#import "Job.h"

@protocol WorkerForwardProtocol

- (void)doWorkOn:(NSString*)textIn
          thenDo:(void (^)(Job *job))job;

@end

/* WorkerReverseProtocol is only needed if your XPC service needs the capability
 to initiate messages back to the main app. */
@protocol WorkerReverseProtocol

- (void)workerInitiatedMessage:(NSString*)message;

@end
