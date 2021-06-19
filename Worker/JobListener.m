#import "JobListener.h"
#import "Job.h"

@interface JobListener()

@property (weak) NSXPCConnection* connection;

@end

@implementation JobListener

+ (NSInteger)hardCodedWorkerVersion {
    /* If you have any suspicion that the system may be running an older
     version of your Worker, change this.  Note that this code (JobListener)
     is only built into the Worker, not the MainApp.  */
    return 102;
}

- (BOOL)          listener:(NSXPCListener*)listener
 shouldAcceptNewConnection:(NSXPCConnection*)connection {
    self.connection = connection;

    NSXPCInterface* forwardInterface = [NSXPCInterface interfaceWithProtocol:@protocol(WorkerForwardProtocol)];
    connection.exportedInterface = forwardInterface;
    connection.exportedObject = self;

    /* This section is only needed if your XPC service needs the capability
     to initiate messages back to the main app. */
    NSXPCInterface* reverseInterface = [NSXPCInterface interfaceWithProtocol:@protocol(WorkerReverseProtocol)];
    connection.remoteObjectInterface = reverseInterface;

    [connection resume];

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
        job.workerVersion = [[self class] hardCodedWorkerVersion];

        NSString* message = @"You owe me $2 for my work.\n"
        @"Thank you for your business.";
        
        thenDo(job);

        NSTimeInterval delayForInvoice = 2.0;
        dispatch_after(
                       dispatch_time(DISPATCH_TIME_NOW, delayForInvoice * NSEC_PER_SEC),
                       dispatch_get_main_queue(), ^{
            [[self.connection remoteObjectProxy] workerInitiatedMessage:message];
        });
    }
}

@end
