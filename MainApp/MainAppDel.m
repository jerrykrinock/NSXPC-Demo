#import "MainAppDel.h"

@implementation MainAppDel

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    self.connection = [[NSXPCConnection alloc] initWithServiceName: kServiceName];
    [self.connection setRemoteObjectInterface: [NSXPCInterface interfaceWithProtocol: @protocol(Worker)]];
    [self.connection resume];

    self.job = [self.connection remoteObjectProxyWithErrorHandler:^(NSError *err) {
        /* UI access must be on main thread. */
        dispatch_queue_t mainQueue = dispatch_get_main_queue() ;
        dispatch_sync(mainQueue, ^{
            self.textOutField.stringValue = @"🙁 Too many characters";
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
                         self.textOutField.stringValue = job.answer;
                     }) ;
                 }];
}

@end
