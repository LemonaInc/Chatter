//
// Created by Jaxon Stevens
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>

//-------------------------------------------------------------------------------------------------------------------------------------------------
@interface SearchView : UITableViewController <UISearchBarDelegate, UIAlertViewDelegate>
//-------------------------------------------------------------------------------------------------------------------------------------------------

@property (nonatomic, strong) NSArray *allUsers;
@property (nonatomic, strong) PFUser *currentUser;
@property (nonatomic, strong) PFRelation *friendsRelation;


@end
