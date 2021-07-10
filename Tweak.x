#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>

%group Inject
    %hook WKWebView
    - (bool)_didCommitLoadForMainFrame {
        [self evaluateJavaScript: 
        // This massive string is the entirty of dark reader and my script to run it.
        // See script.js for more info
        @"(function(){try{const lib=document.createElement('script');lib.src='https://cdn.jsdelivr.net/gh/the-eric-kwok/safari-yejing/yejing.js';lib.defer=true;document.body.append(lib)}catch(err){console.log('DarkReader：',err)}})();"
         completionHandler: nil];
        return %orig;
    }
    %end
%end


%ctor {
    // This prevents us from injecting into springboard and making Xen HTML widgets dark mode.
    // Thanks to Galactic-Dev who I stole this from.
    NSArray *args = [[NSClassFromString(@"NSProcessInfo") processInfo] arguments];
    if(args.count != 0) {
        NSString *executablePath = args[0];
        if(executablePath) {      
            BOOL isApplication = [executablePath rangeOfString:@"/Application"].location != NSNotFound 
            && [executablePath rangeOfString:@"Safari"].location != NSNotFound;
            /*
            && [executablePath rangeOfString:@"Spotlight"].location == NSNotFound // Fix Spotlight dictionary glitches
            && [executablePath rangeOfString:@"Cydia"].location == NSNotFound // Cydia crashes for some people and it doesn't even affect it at all.
            && [executablePath rangeOfString:@"WeChat"].location == NSNotFound; // Fix WeChat chatting page blank black screen issue
            */
            if(isApplication) {
               %init(Inject);
            } else {
                NSLog(@"[Yejing] 无需注入");
            }
        }
    }
}
