#import "JobListener.h"
#import "Job.h"

@implementation JobListener

- (BOOL)          listener:(NSXPCListener *)listener
 shouldAcceptNewConnection:(NSXPCConnection *)newConnection {
    [newConnection setExportedInterface: [NSXPCInterface interfaceWithProtocol:@protocol(WorkerProtocol)]];
    [newConnection setExportedObject: self];

    [newConnection resume];

    return YES;
}

- (void)doWorkOn:(NSString *)textIn
          thenDo:(void (^)(Job *))thenDo {

    [NSThread sleepForTimeInterval:0.3];
    Job *job =  [Job new];

    if ([textIn.lowercaseString isEqualToString:@"kill"]) {
        exit(97);
    } else {

        NSMutableString* answer = [NSMutableString new];
        for (NSInteger i=0; i<textIn.length; i++) {
            unichar aChar = [textIn characterAtIndex:i];
            NSString* aCharString = [NSString stringWithCharacters:&aChar
                                                            length:1];
            [answer insertString:aCharString
                         atIndex:0];
        }

        job.answer = [answer copy];
        /* We hard code the workerVersion here.  Change it to verify that the
         newest version of the agent is being launched by macOS.  Note that
         this code (JobListener) is only built into the Worker, not the
         MainApp.  */
        job.workerVersion = 101;

        thenDo(job);
    }
}

@end
