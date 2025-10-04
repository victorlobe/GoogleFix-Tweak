#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

static NSString * const kModernUA =
@"Mozilla/5.0 (iPhone; CPU iPhone OS 7_0 like Mac OS X) AppleWebKit/537.51.1 (KHTML, like Gecko) Version/7.0 Mobile/11A465 Safari/9537.53";

static inline BOOL HostIsGoogle(NSString *host) {
    if (!host) return NO;
    return [host rangeOfString:@"google."].location != NSNotFound;
}

%ctor {
    @autoreleasepool {
        @try {
            //cleanup for old versions
            NSUserDefaults *d = [NSUserDefaults standardUserDefaults];
            [d removeObjectForKey:@"UserAgent"];
            [d synchronize];
        } @catch (__unused NSException *e) {}

        NSString *bundle = [[NSBundle mainBundle] bundleIdentifier];
        if ([bundle isEqualToString:@"com.apple.mobilesafari"]) {
            [[NSUserDefaults standardUserDefaults] registerDefaults:@{ @"UserAgent": kModernUA }];
        }
    }
}

%hook NSURLRequest

- (id)initWithURL:(NSURL *)URL {
    NSURLRequest *req = %orig(URL);
    if (!req || !URL) return req;

    NSString *host = [URL host];
    if (HostIsGoogle(host)) {
        NSMutableURLRequest *m = [req mutableCopy];
        [m setValue:kModernUA forHTTPHeaderField:@"User-Agent"];
        NSURLRequest *finalReq = [m copy];
#if !__has_feature(objc_arc)
        [m release];
#endif
#if __has_feature(objc_arc)
        return finalReq;
#else
        return [finalReq autorelease];
#endif
    }
    return req;
}

- (id)initWithURL:(NSURL *)URL cachePolicy:(NSURLRequestCachePolicy)policy timeoutInterval:(NSTimeInterval)timeout {
    NSURLRequest *req = %orig(URL, policy, timeout);
    if (!req || !URL) return req;

    NSString *host = [URL host];
    if (HostIsGoogle(host)) {
        NSMutableURLRequest *m = [req mutableCopy];
        [m setValue:kModernUA forHTTPHeaderField:@"User-Agent"];
        NSURLRequest *finalReq = [m copy];
#if !__has_feature(objc_arc)
        [m release];
#endif
#if __has_feature(objc_arc)
        return finalReq;
#else
        return [finalReq autorelease];
#endif
    }
    return req;
}

%end

%hook UIWebView

- (void)loadRequest:(NSURLRequest *)request {
    NSURL *u = request.URL;
    if (HostIsGoogle(u.host)) {
        NSMutableURLRequest *m = [request mutableCopy];
        [m setValue:kModernUA forHTTPHeaderField:@"User-Agent"];
        %orig(m);
#if !__has_feature(objc_arc)
        [m release];
#endif
        return;
    }
    %orig;
}

- (NSString *)stringByEvaluatingJavaScriptFromString:(NSString *)script {
    NSURL *u = self.request.URL;
    if (HostIsGoogle(u.host)) {
        if ([script rangeOfString:@"navigator.userAgent"].location != NSNotFound) {
            return kModernUA;
        }
        if ([script rangeOfString:@"navigator.platform"].location != NSNotFound) {
            return @"iPhone";
        }
    }
    return %orig;
}

%end