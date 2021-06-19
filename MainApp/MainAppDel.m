#import "MainAppDel.h"
#import "Constants.h"

@implementation MainAppDel

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    self.connection = [[NSXPCConnection alloc] initWithServiceName:constServiceIdentifier];

    NSXPCInterface* forwardInterface = [NSXPCInterface interfaceWithProtocol:@protocol(WorkerForwardProtocol)];
    self.connection.remoteObjectInterface = forwardInterface;

    /* This section is only needed if your XPC service needs the capability
     to initiate messages back to the main app. */
    NSXPCInterface* reverseInterface = [NSXPCInterface interfaceWithProtocol:@protocol(WorkerReverseProtocol)];
    self.connection.exportedInterface = reverseInterface;
    self.connection.exportedObject = self;

    [self.connection resume];

    self.job = [self.connection remoteObjectProxyWithErrorHandler:^(NSError *error) {
        /* UI access must be on main thread. */
        dispatch_queue_t mainQueue = dispatch_get_main_queue() ;
        dispatch_sync(mainQueue, ^{
            self.textOutField.stringValue = [[NSString alloc] initWithFormat:
                                             @"%@:\n%@ %ld:\n%@",
                                             [NSDate date],
                                             error.domain,
                                             (long)error.code,
                                             error.localizedDescription];
        }) ;
    }];
}

- (IBAction)doWork:(id)sender {
    self.textOutField.stringValue = @"Waiting for Worker…";
    [self.job doWorkOn:[self.textInField stringValue]
                thenDo: ^(Job *job) {
                     /* UI access must be on main thread. */
                     dispatch_queue_t mainQueue = dispatch_get_main_queue() ;
                     dispatch_sync(mainQueue, ^{
                         self.textOutField.stringValue = [NSString stringWithFormat:
                                                          @"Answer from Worker v%ld:\n"
                                                          @"   %@",
                                                          job.workerVersion,
                                                          job.answer];
                     }) ;
                 }];
}

- (void)workerInitiatedMessage:(NSString*)message {
    /* UI access must be on main thread. */
    dispatch_queue_t mainQueue = dispatch_get_main_queue() ;
    dispatch_sync(mainQueue, ^{
        self.textOutField.stringValue = [NSString stringWithFormat:
                                         @"%@\n"
                                         @"\n"
                                         @"Got message from Worker:\n"
                                         @"%@",
                                         self.textOutField.stringValue,
                                         message];
    }) ;
}

@end
