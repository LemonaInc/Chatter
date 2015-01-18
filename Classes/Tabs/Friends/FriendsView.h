//
// Created by Jaxon Stevens
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>
#import "ProgressHUD.h"

#import "AppConstant.h"
#import "messages.h"

#import "utilities.h"


@interface FriendsView : UITableViewController <UITableViewDataSource>

@property (nonatomic, strong) PFRelation *friendsRelation;

@property (nonatomic, strong) NSArray *favourites;

@property (nonatomic, strong) NSArray *allUsers;

@property (nonatomic, strong) PFUser *currentUser;


@end
