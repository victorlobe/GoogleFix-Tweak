#import <Foundation/Foundation.h>
#import "Polyfills.h" //generated from Polyfills.js (see Makefile)

@interface WebDataSource : NSObject
- (NSURLRequest *)request;
@end

@interface WebFrame : NSObject
- (WebDataSource *)dataSource;
@end

@interface WebView : NSObject
- (WebFrame *)mainFrame;
- (NSString *)customUserAgent;
- (void)setCustomUserAgent:(NSString *)userAgent;
@end

@interface WebScriptObject : NSObject
- (id)evaluateWebScript:(NSString *)script;
@end

static NSString * const kMobileUA =
@"Mozilla/5.0 (iPhone; CPU iPhone OS 7_0 like Mac OS X) AppleWebKit/537.51.1 (KHTML, like Gecko) Version/7.0 Mobile/11A465 Safari/9537.53";

//Classic Layout
static NSString * const kClassicUA =
@"Mozilla/5.0 (Macintosh; Intel Mac OS X 10_9_5) AppleWebKit/537.78.2 (KHTML, like Gecko) Version/7.0.6 Safari/537.78.2";

static NSString *gGoogleUA = kMobileUA;

#define kPrefsDomain CFSTR("com.victorlobe.googlefix")

static void LoadPrefs(void) {
    CFPreferencesAppSynchronize(kPrefsDomain);
    Boolean valid = false;
    Boolean classic = CFPreferencesGetAppBooleanValue(CFSTR("ClassicLayout"), kPrefsDomain, &valid);
    gGoogleUA = (valid && classic) ? kClassicUA : kMobileUA;
}

static void PrefsChanged(CFNotificationCenterRef center, void *observer, CFStringRef name, const void *object, CFDictionaryRef userInfo) {
    LoadPrefs();
}

static BOOL IsOurUA(NSString *ua) {
    return [ua isEqualToString:kMobileUA] || [ua isEqualToString:kClassicUA];
}

static BOOL IsGoogleHost(NSString *host) {
    if (host.length == 0) return NO;
    NSString *h = [host lowercaseString];
    NSRange r = [h rangeOfString:@"google."];
    if (r.location == NSNotFound) return NO;
    if (r.location > 0 && [h characterAtIndex:r.location - 1] != '.') return NO;
    // the rest must be a public suffix like "com", "de", "co.uk", "com.br"
    NSArray *tld = [[h substringFromIndex:NSMaxRange(r)] componentsSeparatedByString:@"."];
    return tld.count >= 1 && tld.count <= 2 && [tld.lastObject length] >= 2;
}

%hook TabDocument

- (void)webView:(WebView *)webView decidePolicyForNavigationAction:(NSDictionary *)action request:(NSURLRequest *)request frame:(WebFrame *)frame decisionListener:(id)listener {
    if (frame == [webView mainFrame]) {
        NSString *current = [webView customUserAgent];
        if (IsGoogleHost(request.URL.host)) {
            if (![current isEqualToString:gGoogleUA]) [webView setCustomUserAgent:gGoogleUA];
        } else if (IsOurUA(current)) {
            [webView setCustomUserAgent:nil];
        }
    }
    %orig;
}

%new
- (NSURLRequest *)webView:(WebView *)webView resource:(id)identifier willSendRequest:(NSURLRequest *)request redirectResponse:(NSURLResponse *)redirectResponse fromDataSource:(WebDataSource *)dataSource {
    if (!IsGoogleHost(request.URL.host) || [[request valueForHTTPHeaderField:@"User-Agent"] isEqualToString:gGoogleUA])
        return request;
    NSMutableURLRequest *m = [request mutableCopy];
    [m setValue:gGoogleUA forHTTPHeaderField:@"User-Agent"];
    return m;
}

- (void)webView:(WebView *)webView didClearWindowObject:(WebScriptObject *)windowObject forFrame:(WebFrame *)frame {
    %orig;
    if (!IsGoogleHost([[[frame dataSource] request] URL].host)) return;
    @try {
        [windowObject evaluateWebScript:kPolyfillJS];
    } @catch (__unused NSException *e) {}
}

%end

%ctor {
    NSUserDefaults *d = [NSUserDefaults standardUserDefaults];
    if ([d objectForKey:@"UserAgent"]) {
        [d removeObjectForKey:@"UserAgent"];
        [d synchronize];
    }
    LoadPrefs();
    CFNotificationCenterAddObserver(CFNotificationCenterGetDarwinNotifyCenter(), NULL, PrefsChanged,
        CFSTR("com.victorlobe.googlefix/prefschanged"), NULL, CFNotificationSuspensionBehaviorCoalesce);
    %init;
}
