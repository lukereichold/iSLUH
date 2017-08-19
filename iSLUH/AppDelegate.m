#import "AppDelegate.h"
#import "RotatableNavController.h"
#import "HolidayJSONDataSource.h"
#import "CalendarDetailPhone.h"
#import "CalendarDetailPad.h"
#import "Kal.h"
#import "MainScreen.h"
#import "MainScreeniPad.h"
#import "Appirater.h"
#import "UIColor+SLUHCustom.h"
#import "Convenience.h"

static const double kTitleFontSizePad = 32.0;
static const double kTitleFontSizePhone = 24.0;

@interface AppDelegate ()

@property (nonatomic, strong) RotatableNavController *navigationController;

@end

@implementation AppDelegate

- (void)applicationWillEnterForeground:(UIApplication *)application  {
    [Appirater appEnteredForeground:YES];
}

- (void)applicationDidFinishLaunching:(UIApplication *)application {
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];

    if ([Convenience isiPad]) {
        MainScreeniPad *firstPage = [[MainScreeniPad alloc]initWithNibName:@"MainScreeniPad" bundle:nil];
        
        firstPage.navigationItem.titleView = [self formatNavItemTitleView];
        firstPage.navigationItem.hidesBackButton = YES;
        self.navigationController = [[RotatableNavController alloc] initWithRootViewController:firstPage];

    } else {
        MainScreen *firstPage = [[MainScreen alloc]initWithNibName:@"MainScreen" bundle:nil];
        firstPage.navigationItem.titleView = [self formatNavItemTitleView];
        firstPage.navigationItem.hidesBackButton = YES;
        self.navigationController = [[RotatableNavController alloc] initWithRootViewController:firstPage];
    }

    self.window.rootViewController = self.navigationController;
    self.window.tintColor = [UIColor sluhBlue];
    [self.window makeKeyAndVisible];
    
    [Appirater appLaunched:YES];
}

- (UIView *) formatNavItemTitleView {
    
    double fontSize = ([Convenience isiPad]) ? kTitleFontSizePad : kTitleFontSizePhone;
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.text = @"St. Louis University High";
    titleLabel.font = [UIFont fontWithName:@"Bree Serif" size:fontSize];
    titleLabel.textColor = [UIColor sluhNavy];
    titleLabel.backgroundColor = [UIColor clearColor];
    [titleLabel sizeToFit];
    
    return titleLabel;
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {

    UIApplicationState appState = [application applicationState];
    if (appState == UIApplicationStateActive) {
        
        NSString *message = nil;
        NSDictionary *aps = [userInfo objectForKey:@"aps"];
        
        if (aps != nil)
            message = [aps objectForKey:@"alert"];

        if (message) {
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"iSLUH - Alert!"
                                                                message:message  delegate:self
                                                      cancelButtonTitle:@"OK"
                                                      otherButtonTitles: nil];
            [alertView show];
        }
    }
}

- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *) error { }

- (void) applicationDidBecomeActive:(UIApplication *)application { }

- (NSUInteger) application:(UIApplication *)application supportedInterfaceOrientationsForWindow:(UIWindow *)window {
    
    return ([Convenience isiPad]) ? UIInterfaceOrientationMaskAll : (UIInterfaceOrientationMaskPortrait | UIInterfaceOrientationMaskPortraitUpsideDown);
}

@end
