#import <Cocoa/Cocoa.h>
#import "WorkerProtocols.h"
#import "Constants.h"

@interface MainAppDel : NSObject <NSApplicationDelegate, WorkerReverseProtocol> {
}

@property (assign) IBOutlet NSWindow* window;
@property (weak) IBOutlet NSButton* button;
@property (weak) IBOutlet NSTextField* textInField;
@property (weak) IBOutlet NSTextField* textOutField;
@property (strong) NSXPCConnection* connection;
@property (strong) id <WorkerForwardProtocol> job;

- (IBAction) doWork:(id)sender;

@end
