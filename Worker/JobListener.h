#import <Foundation/Foundation.h>
#import "Constants.h"
#import "Worker.h"

@interface JobListener : NSObject <NSXPCListenerDelegate, Worker>

@end
