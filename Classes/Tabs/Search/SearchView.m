//
// Created by Jaxon Stevens
//

#import "ProgressHUD.h"

#import "AppConstant.h"
#import "messages.h"
#import "utilities.h"

#import "SearchView.h"
#import "ChatView.h"

#import "FriendsView.h"


//-------------------------------------------------------------------------------------------------------------------------------------------------
@interface SearchView()
{
	NSMutableArray *users;
}

@property (strong, nonatomic) IBOutlet UIView *viewHeader;
@property (strong, nonatomic) IBOutlet UISearchBar *searchBar1;
@property (strong, nonatomic) IBOutlet UITableView *myTableView;


@end
//-------------------------------------------------------------------------------------------------------------------------------------------------

@implementation SearchView

@synthesize viewHeader, searchBar1;

//-------------------------------------------------------------------------------------------------------------------------------------------------
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
//-------------------------------------------------------------------------------------------------------------------------------------------------
{
	self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
	if (self)
	{
		[self.tabBarItem setImage:[UIImage imageNamed:@"tab_search"]];
        self.tabBarItem.title = @"Search";
	}
	return self;
}

//-------------------------------------------------------------------------------------------------------------------------------------------------
- (void)viewDidLoad
//-------------------------------------------------------------------------------------------------------------------------------------------------
{
	[super viewDidLoad];
	self.title = @"Search";
	//---------------------------------------------------------------------------------------------------------------------------------------------
	self.tableView.tableHeaderView = viewHeader;
	self.tableView.separatorInset = UIEdgeInsetsZero;
	//---------------------------------------------------------------------------------------------------------------------------------------------
	users = [[NSMutableArray alloc] init];
	//---------------------------------------------------------------------------------------------------------------------------------------------
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(cleanupTable) name:NOTIFICATION_USER_LOGGED_OUT object:nil];
    //---------------------------------------------------------------------------------------------------------------------------------------------
    self.currentUser = [PFUser currentUser];

}

//-------------------------------------------------------------------------------------------------------------------------------------------------
- (void)viewDidAppear:(BOOL)animated
//-------------------------------------------------------------------------------------------------------------------------------------------------
{
	[super viewDidAppear:animated];
	//---------------------------------------------------------------------------------------------------------------------------------------------
	if ([PFUser currentUser] == nil) LoginUser(self);
}

//-------------------------------------------------------------------------------------------------------------------------------------------------
- (void)viewWillDisappear:(BOOL)animated
//-------------------------------------------------------------------------------------------------------------------------------------------------
{
	[super viewWillDisappear:animated];
	//---------------------------------------------------------------------------------------------------------------------------------------------
	[self searchBarCancelled];
}

//-------------------------------------------------------------------------------------------------------------------------------------------------
- (void)cleanupTable
//-------------------------------------------------------------------------------------------------------------------------------------------------
{
	[users removeAllObjects];
	[self.tableView reloadData];
}

#pragma mark - Table view data source

//-------------------------------------------------------------------------------------------------------------------------------------------------
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
//-------------------------------------------------------------------------------------------------------------------------------------------------
{
	return 1;
}

//-------------------------------------------------------------------------------------------------------------------------------------------------
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
//-------------------------------------------------------------------------------------------------------------------------------------------------
{
	return [users count];
}

//-------------------------------------------------------------------------------------------------------------------------------------------------
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
//-------------------------------------------------------------------------------------------------------------------------------------------------
{
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
	if (cell == nil) cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
    
	PFUser *user = users[indexPath.row];
	cell.textLabel.text = user[PF_USER_USERNAME];

    //Create the button and add it to the cell
    UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [button addTarget:self
               action:@selector(customActionPressed:)
     forControlEvents:UIControlEventTouchDown];
    [button setTitle:@"Add" forState:UIControlStateNormal];
    button.frame = CGRectMake(150.0f, 5.0f, 150.0f, 30.0f);
    [cell addSubview:button];
    
    return cell;
    
}

//-------------------------------------------------------------------------------------------------------------------------------------------------
- (IBAction)customActionPressed:(id)sender
//-------------------------------------------------------------------------------------------------------------------------------------------------

{
    NSIndexPath *indexPath = [self.myTableView
     indexPathForCell:(UITableViewCell *)[[sender superview] superview]];

    PFRelation *friendsRelation = [self.currentUser relationForKey:@"friendsRelation"];
    PFUser *user = users[indexPath.row];
    [friendsRelation addObject:user];
    
    
    [self.currentUser saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (error) {
            NSLog(@"Error %@ %@", error, [error userInfo]);
        } else {
            [ProgressHUD showSuccess:[NSString stringWithFormat:@"%@ is now a favourite!", [user objectForKey:PF_USER_USERNAME]]];
            [users removeAllObjects];
            [self.tableView reloadData];
        }
    }];

}

#pragma mark - Table view delegate

//-------------------------------------------------------------------------------------------------------------------------------------------------
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
//-------------------------------------------------------------------------------------------------------------------------------------------------
{
	[tableView deselectRowAtIndexPath:indexPath animated:YES];
	//---------------------------------------------------------------------------------------------------------------------------------------------
	PFUser *user1 = [PFUser currentUser];
	PFUser *user2 = users[indexPath.row];
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

#pragma mark - UISearchBarDelegate

//-------------------------------------------------------------------------------------------------------------------------------------------------
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
//-------------------------------------------------------------------------------------------------------------------------------------------------
{
	if ([searchText length] >= 2)
	{
		NSString *search_lower = [searchText lowercaseString];

        PFQuery *query = [PFQuery queryWithClassName:PF_USER_CLASS_NAME];
        [query whereKey:PF_USER_OBJECTID notEqualTo:[PFUser currentUser].objectId];
		[query whereKey:PF_USER_USERNAME containsString:search_lower];
		[query orderByAscending:PF_USER_USERNAME];
		//query.cachePolicy = kPFCachePolicyCacheThenNetwork;
		[query setLimit:1000];
		[query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error)
		{
			if (error == nil)
			{
                [users removeAllObjects];
				[users addObjectsFromArray:objects];
				[self.tableView reloadData];
			}
			else [ProgressHUD showError:@"Network error."];
		}];
	}
	else
	{
		[users removeAllObjects];
		[self.tableView reloadData];
	}
}

//-------------------------------------------------------------------------------------------------------------------------------------------------
- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar
//-------------------------------------------------------------------------------------------------------------------------------------------------
{
	[searchBar setShowsCancelButton:YES animated:YES];
}

//-------------------------------------------------------------------------------------------------------------------------------------------------
- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar
//-------------------------------------------------------------------------------------------------------------------------------------------------
{
	[searchBar setShowsCancelButton:NO animated:YES];
}

//-------------------------------------------------------------------------------------------------------------------------------------------------
- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
//-------------------------------------------------------------------------------------------------------------------------------------------------
{
	[self searchBarCancelled];
    [users removeAllObjects];
    [self.tableView reloadData];
}

//-------------------------------------------------------------------------------------------------------------------------------------------------
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
//-------------------------------------------------------------------------------------------------------------------------------------------------
{
	[searchBar resignFirstResponder];
}

//-------------------------------------------------------------------------------------------------------------------------------------------------
- (void)searchBarCancelled
//-------------------------------------------------------------------------------------------------------------------------------------------------
{
	searchBar1.text = @"";
	[searchBar1 resignFirstResponder];
}


@end
