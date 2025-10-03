#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

%ctor {
    @autoreleasepool {
        NSString *modernUserAgent = @"Mozilla/5.0 (iPhone; CPU iPhone OS 7_0 like Mac OS X) AppleWebKit/537.51.1 (KHTML, like Gecko) Version/7.0 Mobile/11A465 Safari/9537.53";
        [[NSUserDefaults standardUserDefaults] setObject:modernUserAgent forKey:@"UserAgent"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
}

%hook NSURLRequest

- (id)initWithURL:(NSURL *)URL {
    NSURLRequest *request = %orig;
    
    NSString *host = [URL host];
    if (host && [host rangeOfString:@"google."].location != NSNotFound) {
        NSMutableURLRequest *mutableRequest = [request mutableCopy];
        NSString *modernUserAgent = @"Mozilla/5.0 (iPhone; CPU iPhone OS 7_0 like Mac OS X) AppleWebKit/537.51.1 (KHTML, like Gecko) Version/7.0 Mobile/11A465 Safari/9537.53";
        [mutableRequest setValue:modernUserAgent forHTTPHeaderField:@"User-Agent"];
        return mutableRequest;
    }
    
    return request;
}

- (id)initWithURL:(NSURL *)URL cachePolicy:(NSURLRequestCachePolicy)cachePolicy timeoutInterval:(NSTimeInterval)timeoutInterval {
    NSURLRequest *request = %orig;
    
    NSString *host = [URL host];
    if (host && [host rangeOfString:@"google."].location != NSNotFound) {
        NSMutableURLRequest *mutableRequest = [request mutableCopy];
        NSString *modernUserAgent = @"Mozilla/5.0 (iPhone; CPU iPhone OS 7_0 like Mac OS X) AppleWebKit/537.51.1 (KHTML, like Gecko) Version/7.0 Mobile/11A465 Safari/9537.53";
        [mutableRequest setValue:modernUserAgent forHTTPHeaderField:@"User-Agent"];
        return mutableRequest;
    }
    
    return request;
}

%end

%hook NSUserDefaults

- (id)init {
    id result = %orig;
    NSString *modernUserAgent = @"Mozilla/5.0 (iPhone; CPU iPhone OS 7_0 like Mac OS X) AppleWebKit/537.51.1 (KHTML, like Gecko) Version/7.0 Mobile/11A465 Safari/9537.53";
    NSDictionary *userAgentDict = @{@"UserAgent": modernUserAgent};
    [result registerDefaults:userAgentDict];
    return result;
}

%end

%hook UIWebView

- (NSString *)stringByEvaluatingJavaScriptFromString:(NSString *)script {
    if ([script rangeOfString:@"navigator.userAgent"].location != NSNotFound) {
        return @"Mozilla/5.0 (iPhone; CPU iPhone OS 7_0 like Mac OS X) AppleWebKit/537.51.1 (KHTML, like Gecko) Version/7.0 Mobile/11A465 Safari/9537.53";
    }
    
    if ([script rangeOfString:@"navigator.platform"].location != NSNotFound) {
        return @"iPhone";
    }
    
    return %orig;
}

%end
