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
@property (retain) IBOutlet NSButton* button;
@property (retain) IBOutlet NSTextField* textInField;
@property (retain) IBOutlet NSTextField* textOutField;
@property (retain) NSXPCConnection* connection;
@property (retain) id<Worker> job;

- (IBAction) doWork:(id)sender;

@end
