#import "MainAppDel.h"
#import "Constants.h"

@implementation MainAppDel

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    self.connection = [[NSXPCConnection alloc] initWithServiceName:constServiceIdentifier];
    [self.connection setRemoteObjectInterface: [NSXPCInterface interfaceWithProtocol: @protocol(WorkerProtocol)]];
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
                                                          @"Answer from Worker\nversion %ld:\n\n%@",
                                                          job.workerVersion,
                                                          job.answer];
                     }) ;
                 }];
}

@end
