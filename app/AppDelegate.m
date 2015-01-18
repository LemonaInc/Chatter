//
// Created by Jaxon Stevens
//


#import <Parse/Parse.h>
#import <ParseFacebookUtils/PFFacebookUtils.h>

#import "AppConstant.h"
#import "utilities.h"


#import "AppDelegate.h"
#import "FriendsView.h"
#import "SearchView.h"
#import "MessagesView.h"
#import "SettingsView.h"
#import "NavigationController.h"



@implementation AppDelegate

//-------------------------------------------------------------------------------------------------------------------------------------------------
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
//-------------------------------------------------------------------------------------------------------------------------------------------------
{
    [Parse setApplicationId:@"iEcV19SHfKeCs92GMDRNiE488WEtZnEFay5yoIol"
                  clientKey:@"067x4abKTKN7uuvkqlrUJua14Z5XY7leWs7qyHna"];
    
    [PFAnalytics trackAppOpenedWithLaunchOptions:launchOptions];
    
    // Register for Push Notitications, if running iOS 8
    if ([application respondsToSelector:@selector(registerUserNotificationSettings:)]) {
        UIUserNotificationType userNotificationTypes = (UIUserNotificationTypeAlert |
                                                        UIUserNotificationTypeBadge |
                                                        UIUserNotificationTypeSound);
        UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:userNotificationTypes
                                                                                 categories:nil];
        [application registerUserNotificationSettings:settings];
        [application registerForRemoteNotifications];
    }
    
	//---------------------------------------------------------------------------------------------------------------------------------------------
	[PFFacebookUtils initializeFacebook];
	//---------------------------------------------------------------------------------------------------------------------------------------------
	[PFImageView class];
	//---------------------------------------------------------------------------------------------------------------------------------------------
	self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    self.friendsView = [[FriendsView alloc] init];
    self.searchView = [[SearchView alloc] init];
    self.messagesView = [[MessagesView alloc] init];
    self.settingsView = [[SettingsView alloc] init];
	
	NavigationController *navController1 = [[NavigationController alloc] initWithRootViewController:[[FriendsView alloc] init]];
	NavigationController *navController2 = [[NavigationController alloc] initWithRootViewController:[[SearchView alloc] init]];
	NavigationController *navController3 = [[NavigationController alloc] initWithRootViewController:[[MessagesView alloc] init]];
	NavigationController *navController4 = [[NavigationController alloc] initWithRootViewController:[[SettingsView alloc] init]];
    

	self.tabBarController = [[UITabBarController alloc] init];
	self.tabBarController.viewControllers = [NSArray arrayWithObjects:navController1, navController2, navController3, navController4, nil];
	self.tabBarController.tabBar.translucent = NO;
	self.tabBarController.selectedIndex = 0;

	self.window.rootViewController = self.tabBarController;
	[self.window makeKeyAndVisible];
	//---------------------------------------------------------------------------------------------------------------------------------------------
	return YES;
}
//-----------------------------------------------------------------------------------------------------------------------------------------------
- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    // Store the deviceToken in the current installation and save it to Parse.
    PFInstallation *currentInstallation = [PFInstallation currentInstallation];
    [currentInstallation setDeviceTokenFromData:deviceToken];
    [currentInstallation saveInBackground];
}
//-----------------------------------------------------------------------------------------------------------------------------------------------
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
    [PFPush handlePush:userInfo];
    [self performSelector:@selector(refreshMessagesView) withObject:nil afterDelay:4.0];
}

//-------------------------------------------------------------------------------------------------------------------------------------------------
- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error
//-------------------------------------------------------------------------------------------------------------------------------------------------
{
    NSLog(@"didFailToRegisterForRemoteNotificationsWithError %@", error);
}

//-------------------------------------------------------------------------------------------------------------------------------------------------
- (void)applicationWillResignActive:(UIApplication *)application
//-------------------------------------------------------------------------------------------------------------------------------------------------
{
	
}

//-------------------------------------------------------------------------------------------------------------------------------------------------
- (void)applicationDidEnterBackground:(UIApplication *)application
//-------------------------------------------------------------------------------------------------------------------------------------------------
{
	
}

//-------------------------------------------------------------------------------------------------------------------------------------------------
- (void)applicationWillEnterForeground:(UIApplication *)application
//-------------------------------------------------------------------------------------------------------------------------------------------------
{
	
}

//-------------------------------------------------------------------------------------------------------------------------------------------------
- (void)applicationDidBecomeActive:(UIApplication *)application
//-------------------------------------------------------------------------------------------------------------------------------------------------
{
	[FBAppCall handleDidBecomeActiveWithSession:[PFFacebookUtils session]];
}

//-------------------------------------------------------------------------------------------------------------------------------------------------
- (void)applicationWillTerminate:(UIApplication *)application
//-------------------------------------------------------------------------------------------------------------------------------------------------
{
	
}

#pragma mark - Facebook responses

//-------------------------------------------------------------------------------------------------------------------------------------------------
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
//-------------------------------------------------------------------------------------------------------------------------------------------------
{
	return [FBAppCall handleOpenURL:url sourceApplication:sourceApplication withSession:[PFFacebookUtils session]];
}

//-------------------------------------------------------------------------------------------------------------------------------------------------
- (void)refreshMessagesView
//-------------------------------------------------------------------------------------------------------------------------------------------------
{
    [self.messagesView loadMessages];
}

@end
