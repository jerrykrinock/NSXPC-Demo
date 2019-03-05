#import "MainAppDel.h"

@implementation MainAppDel

@synthesize button, textInField, textOutField, connection, job;

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
	connection = [[NSXPCConnection alloc] initWithServiceName: kServiceName];
	[connection setRemoteObjectInterface: [NSXPCInterface interfaceWithProtocol: @protocol(Worker)]];
	[connection resume];
	
	job = [connection remoteObjectProxyWithErrorHandler:^(NSError *err) {
        /* UI access must be on main thread. */
        dispatch_queue_t mainQueue = dispatch_get_main_queue() ;
        dispatch_sync(mainQueue, ^{
            textOutField.stringValue = @"🙁 Too many characters";
        }) ;
	}];
}

- (IBAction)doWork:(id)sender {
    textOutField.stringValue = @"Waiting for Worker…";
	[job doWorkOn:[textInField stringValue]
                   reply: ^(Job *job) {
                       /* UI access must be on main thread. */
                       dispatch_queue_t mainQueue = dispatch_get_main_queue() ;
                       dispatch_sync(mainQueue, ^{
                           textOutField.stringValue = job.answer;
                       }) ;
	}];
}

@end
