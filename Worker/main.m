#import <Foundation/Foundation.h>
#import "JobListener.h"

int main(int argc, const char *argv[]) {
	/* An XPCService should use this singleton instance of serviceListener.
     It is preconfigured to listen on the name advertised by this XPCService's
     Info.plist. */
	NSXPCListener *listener = [NSXPCListener serviceListener];
	
	JobListener* delegate = [JobListener new];
	listener.delegate = delegate;
	
	/* This method never returns.  It will wait for incoming connections using
     CFRunLoop or a dispatch queue, as appropriate. */
	[listener resume];
	return 0;
}	
