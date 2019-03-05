#import <Cocoa/Cocoa.h>
#import "Worker.h"

@interface MainAppDel : NSObject <NSApplicationDelegate> {
}

#define kServiceName @"com.sheepsystems.XPCDemoWorker"

@property (assign) IBOutlet NSWindow* window;
@property (weak) IBOutlet NSButton* button;
@property (weak) IBOutlet NSTextField* textInField;
@property (weak) IBOutlet NSTextField* textOutField;
@property (strong) NSXPCConnection* connection;
@property (strong) id <Worker> job;

- (IBAction) doWork:(id)sender;

@end
