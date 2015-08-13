#import "Convenience.h"

@implementation Convenience

+ (BOOL)isiPad {
    BOOL isiPad = NO;
    if ([UIDevice instancesRespondToSelector:@selector(userInterfaceIdiom)]) {
        UIUserInterfaceIdiom idiom = [[UIDevice currentDevice] userInterfaceIdiom];
        
        if (idiom == UIUserInterfaceIdiomPad) {
            isiPad = YES;
        }
    }
    return isiPad;
}

+ (BOOL)is4InchScreen {
    return ([[UIScreen mainScreen] bounds].size.height == 568)? TRUE : FALSE;
}

@end
