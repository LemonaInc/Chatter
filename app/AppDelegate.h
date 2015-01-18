//
// Created by Jaxon Stevens
//


#import <UIKit/UIKit.h>

#import "FriendsView.h"
#import "SearchView.h"
#import "MessagesView.h"
#import "SettingsView.h"

//-------------------------------------------------------------------------------------------------------------------------------------------------
@interface AppDelegate : UIResponder <UIApplicationDelegate>
//-------------------------------------------------------------------------------------------------------------------------------------------------

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) UITabBarController *tabBarController;

@property (strong, nonatomic) FriendsView *friendsView;
@property (strong, nonatomic) SearchView *searchView;
@property (strong, nonatomic) MessagesView *messagesView;
@property (strong, nonatomic) SettingsView *settingsView;

@end
