#import <Cocoa/Cocoa.h>
#import "Worker.h"

@interface MainAppDel : NSObject <NSApplicationDelegate> {
	NSXPCConnection *connection;
	NSObject <Worker> * job;
	NSButton* button;
	NSTextField* textInField;
    NSTextField* textOutField;
}

#define kServiceName @"com.sheepsystems.XPCDemoWorker"

@property (assign) IBOutlet NSWindow* window;
@property (strong) IBOutlet NSButton* button;
@property (strong) IBOutlet NSTextField* textInField;
@property (strong) IBOutlet NSTextField* textOutField;
@property (strong) NSXPCConnection* connection;
@property (strong) id<Worker> job;

- (IBAction) doWork:(id)sender;

@end
