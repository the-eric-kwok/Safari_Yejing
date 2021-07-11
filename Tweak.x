#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>

%group Inject
    %hook WKWebView
    - (bool)_didCommitLoadForMainFrame {
        [self evaluateJavaScript: 
        // This massive string is the entirty of dark reader and my script to run it.
        // See script.js for more info
        @"function main(){const w=window;const key=encodeURIComponent('Safari_Yejing:执行判断');if(w[key]){return};w[key]=true;try{const script=document.createElement('script');script.src='https://cdn.jsdelivr.net/gh/the-eric-kwok/Safari_Yejing/野径云俱黑，江船火独明.js';script.defer=true;document.body.append(script);console.log('Safari_Yejing injected')}catch(err){console.log('Safari_Yejing：',err)}}window.onload=main();"
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
