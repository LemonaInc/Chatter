//
// Created by Jaxon Stevens
//

#import "messages.h"


#import "ChatView.h"

#import "FriendsView.h"
#import "FriendsCell.h"




@interface FriendsView ()


{
    NSMutableArray *users;
}

@property (strong, nonatomic) IBOutlet UITableView *tableFriends;



@end

@implementation FriendsView

//-------------------------------------------------------------------------------------------------------------------------------------------------
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
//-------------------------------------------------------------------------------------------------------------------------------------------------
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        self.tabBarItem.title = nil;
        [self.tabBarItem setImage:[UIImage imageNamed:@"tab_fav"]];
        [self.tabBarItem setSelectedImage:[UIImage imageNamed:@"tab_fav"]];
        self.tabBarItem.title = @"Favourites";
    }
    return self;
}

//-------------------------------------------------------------------------------------------------------------------------------------------------
- (void)viewDidLoad
//-------------------------------------------------------------------------------------------------------------------------------------------------
{
    [super viewDidLoad];
    self.title = @"Favourites";
    
    users = [[NSMutableArray alloc] init];
    //-----------------------------------------------------------------------------------------------------------------------------------------------
    [self.tableView registerClass: [FriendsCell class] forCellReuseIdentifier:@"FriendsCell"];
    //-----------------------------------------------------------------------------------------------------------------------------------------------
    self.friendsRelation = [[PFUser currentUser] objectForKey:@"friendsRelation"];
    PFQuery *query1 = [self.friendsRelation query];
    [query1 orderByAscending:@"username"];
    [query1 findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (error) {
            NSLog(@"Error %@ %@", error, [error userInfo]);
        }
        else {
            self.favourites = objects;
            [self.tableView reloadData];
        }
    }];
    //-----------------------------------------------------------------------------------------------------------------------------------------------
}


//-------------------------------------------------------------------------------------------------------------------------------------------------
- (void)viewWillAppear:(BOOL)animated
//-------------------------------------------------------------------------------------------------------------------------------------------------
{
    [super viewWillAppear:animated];
    
    
    [self friendsList];
    
}

//-------------------------------------------------------------------------------------------------------------------------------------------------
- (void)viewDidAppear:(BOOL)animated
//-------------------------------------------------------------------------------------------------------------------------------------------------
{
    [super viewDidAppear:animated];
    //---------------------------------------------------------------------------------------------------------------------------------------------
    if ([PFUser currentUser] != nil)
    {
        [self refreshTable];
    }
    else LoginUser(self);
}

//-------------------------------------------------------------------------------------------------------------------------------------------------
- (void)refreshTable
//-------------------------------------------------------------------------------------------------------------------------------------------------
{
    [ProgressHUD show:nil];
    PFQuery *query1 = [self.friendsRelation query];
    [query1 orderByAscending:@"username"];
    [query1 findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (error == nil)
        {
            self.favourites = objects;
            [ProgressHUD dismiss];
            [self.tableView reloadData];
            [self friendsList];
            
        }
        else [ProgressHUD showError:@"Network error."];
    }];

}



#pragma mark - Table view data source
//-------------------------------------------------------------------------------------------------------------------------------------------------
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
//-------------------------------------------------------------------------------------------------------------------------------------------------
{
    // Return the number of sections.
    return 1;
}

//-------------------------------------------------------------------------------------------------------------------------------------------------
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
//-------------------------------------------------------------------------------------------------------------------------------------------------
{
    // Return the number of rows in the section.
    return [self.favourites count];
}


//-------------------------------------------------------------------------------------------------------------------------------------------------
- (void)friendsList
//-------------------------------------------------------------------------------------------------------------------------------------------------
{
    [self.tableView registerClass: [FriendsCell class] forCellReuseIdentifier:@"FriendsCell"];
    
    self.friendsRelation = [[PFUser currentUser] objectForKey:@"friendsRelation"];
    PFQuery *query = [self.friendsRelation query];
    [query orderByAscending:@"username"];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (error) {
            NSLog(@"Error %@ %@", error, [error userInfo]);
        }
        else {
            self.favourites = objects;
            [self.tableView reloadData];
        }
    }];
}

//-------------------------------------------------------------------------------------------------------------------------------------------------
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath*)indexPath
//-------------------------------------------------------------------------------------------------------------------------------------------------
{
    
    if (editingStyle == UITableViewCellEditingStyleDelete)
    {

        
        // Delete the row from the data source
        PFUser *user = [self.favourites objectAtIndex:indexPath.row];
        [self.friendsRelation removeObject:[PFObject objectWithoutDataWithClassName:@"_User"objectId:user.objectId]];
        
        [[PFUser currentUser] saveInBackground];
        [self refreshTable];
 
    }
}

//-------------------------------------------------------------------------------------------------------------------------------------------------
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
//-------------------------------------------------------------------------------------------------------------------------------------------------
{
    
    FriendsCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FriendsCell" forIndexPath:indexPath];

    PFUser *user = [self.favourites objectAtIndex:indexPath.row];
    cell.textLabel.text = user.username;
    
    return cell;
}

//-------------------------------------------------------------------------------------------------------------------------------------------------
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
//-------------------------------------------------------------------------------------------------------------------------------------------------
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    //---------------------------------------------------------------------------------------------------------------------------------------------
    PFUser *user1 = [PFUser currentUser];
    PFUser *user2 = self.favourites[indexPath.row];
    NSString *id1 = user1.objectId;
    NSString *id2 = user2.objectId;
    NSString *roomId = ([id1 compare:id2] < 0) ? [NSString stringWithFormat:@"%@%@", id1, id2] : [NSString stringWithFormat:@"%@%@", id2, id1];
    //---------------------------------------------------------------------------------------------------------------------------------------------
    CreateMessageItem(user1, roomId, user2[PF_USER_FULLNAME]);
    CreateMessageItem(user2, roomId, user1[PF_USER_FULLNAME]);
    //---------------------------------------------------------------------------------------------------------------------------------------------
    ChatView *chatView = [[ChatView alloc] initWith:roomId];
    chatView.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:chatView animated:YES];
}


@end
