#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

%hook UIWebView

- (void)loadRequest:(NSURLRequest *)request {
    NSURL *url = [request URL];
    NSString *host = [url host];
    
    if (host && ([host isEqualToString:@"www.google.com"] || 
                 [host isEqualToString:@"google.com"])) {
        
        NSMutableURLRequest *mutableRequest = [request mutableCopy];
        NSString *modernUserAgent = @"Mozilla/5.0 (iPhone; CPU iPhone OS 7_0 like Mac OS X) AppleWebKit/537.51.1 (KHTML, like Gecko) Version/7.0 Mobile/11A465 Safari/9537.53";
        [mutableRequest setValue:modernUserAgent forHTTPHeaderField:@"User-Agent"];
        
        %orig(mutableRequest);
    } else {
        %orig;
    }
}

%end
