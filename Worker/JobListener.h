#import <Foundation/Foundation.h>
#import "Worker.h"

#define kServiceName @"com.sheepsystems.XPCDemoWorker"

@interface JobListener : NSObject <NSXPCListenerDelegate, Worker>

@end
