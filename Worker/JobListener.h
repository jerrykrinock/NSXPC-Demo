#import <Foundation/Foundation.h>
#import "Constants.h"
#import "WorkerProtocols.h"

@interface JobListener : NSObject <NSXPCListenerDelegate, WorkerForwardProtocol>

@end
