#import <Foundation/Foundation.h>
#import "Constants.h"
#import "WorkerProtocol.h"

@interface JobListener : NSObject <NSXPCListenerDelegate, WorkerProtocol>

@end
