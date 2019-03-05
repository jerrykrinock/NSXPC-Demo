#import <Cocoa/Cocoa.h>
#import "Worker.h"
#import "Constants.h"

@interface MainAppDel : NSObject <NSApplicationDelegate> {
}

@property (assign) IBOutlet NSWindow* window;
@property (weak) IBOutlet NSButton* button;
@property (weak) IBOutlet NSTextField* textInField;
@property (weak) IBOutlet NSTextField* textOutField;
@property (strong) NSXPCConnection* connection;
@property (strong) id <Worker> job;

- (IBAction) doWork:(id)sender;

@end
