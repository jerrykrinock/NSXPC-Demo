#import "JobListener.h"
#import "Job.h"

@implementation JobListener

- (BOOL)          listener:(NSXPCListener *)listener
 shouldAcceptNewConnection:(NSXPCConnection *)newConnection {
    [newConnection setExportedInterface: [NSXPCInterface interfaceWithProtocol:@protocol(Worker)]];
    [newConnection setExportedObject: self];

    [newConnection resume];

    NSLog(@"Worker got request for connection") ;
    return YES;
}

- (void)doWorkOn:(NSString *)textIn
          thenDo:(void (^)(Job *))thenDo {
    NSLog(@"Worker got work: %@", textIn) ;

    [NSThread sleepForTimeInterval:0.3];

    if (textIn.length > 5) {
        exit(77);
    } else {
        Job *job = nil;
        job = [Job new];

        NSMutableString* answer = [NSMutableString new];
        for (NSInteger i=0; i<textIn.length; i++) {
            unichar aChar = [textIn characterAtIndex:i];
            NSString* aCharString = [NSString stringWithCharacters:&aChar
                                                            length:1];
            [answer insertString:aCharString
                         atIndex:0];
        }

        job.answer = [answer copy];

        thenDo(job);
    }
}

@end
