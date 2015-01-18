//
// Created by Jaxon Stevens
//


#import <Parse/Parse.h>
#import "ProgressHUD.h"

#import "AppConstant.h"

#import "RegisterView.h"

//-------------------------------------------------------------------------------------------------------------------------------------------------
@interface RegisterView()

@property (strong, nonatomic) IBOutlet UITableViewCell *cellName;
@property (strong, nonatomic) IBOutlet UITableViewCell *cellPassword;
@property (strong, nonatomic) IBOutlet UITableViewCell *cellEmail;
@property (strong, nonatomic) IBOutlet UITableViewCell *cellButton;
@property (strong, nonatomic) IBOutlet UITableViewCell *cellUsername;

@property (strong, nonatomic) IBOutlet UITextField *fieldName;
@property (strong, nonatomic) IBOutlet UITextField *fieldPassword;
@property (strong, nonatomic) IBOutlet UITextField *fieldEmail;
@property (strong, nonatomic) IBOutlet UITextField *fieldUsername;


@end
//-------------------------------------------------------------------------------------------------------------------------------------------------

@implementation RegisterView

@synthesize cellName, cellPassword, cellEmail, cellButton, cellUsername;
@synthesize fieldName, fieldPassword, fieldEmail, fieldUsername;

//-------------------------------------------------------------------------------------------------------------------------------------------------
- (void)viewDidLoad
//-------------------------------------------------------------------------------------------------------------------------------------------------
{
	[super viewDidLoad];
	self.title = @"Register";
	//---------------------------------------------------------------------------------------------------------------------------------------------
	[self.view addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissKeyboard)]];
	//---------------------------------------------------------------------------------------------------------------------------------------------
	self.tableView.separatorInset = UIEdgeInsetsZero;
    //---------------------------------------------------------------------------------------------------------------------------------------------
    UIImage *background = [UIImage imageNamed:@"background2.png"];
    UIImageView *imageView = [[UIImageView alloc] initWithImage:background];
    [self.tableView setBackgroundView:imageView];
    //---------------------------------------------------------------------------------------------------------------------------------------------
    self.tableView.separatorColor = [UIColor clearColor];
    
}

//-------------------------------------------------------------------------------------------------------------------------------------------------
- (void)viewDidAppear:(BOOL)animated
//-------------------------------------------------------------------------------------------------------------------------------------------------
{
	[super viewDidAppear:animated];
	[fieldUsername becomeFirstResponder];
}

//-------------------------------------------------------------------------------------------------------------------------------------------------
- (void)dismissKeyboard
//-------------------------------------------------------------------------------------------------------------------------------------------------
{
	[self.view endEditing:YES];
}

#pragma mark - User actions

//-------------------------------------------------------------------------------------------------------------------------------------------------
- (IBAction)actionRegister:(id)sender
//-------------------------------------------------------------------------------------------------------------------------------------------------
{
	NSString *name		= fieldName.text;
	NSString *password	= fieldPassword.text;
	NSString *email		= fieldEmail.text;
    NSString *username  = fieldUsername.text;
    username = [username lowercaseString];
    
	if ((name.length != 0) && (password.length != 6) && (email.length != 0))
	{
		[ProgressHUD show:@"Please wait..." Interaction:NO];

		PFUser *user = [PFUser user];
		user.username = username;
		user.password = password;
		user.email = email;
		user[PF_USER_EMAILCOPY] = email;
		user[PF_USER_FULLNAME] = name;

		[user signUpInBackgroundWithBlock:^(BOOL succeeded, NSError *error)
		{
			if (error == nil)
			{
				[ProgressHUD showSuccess:@"Succeed."];
				[self dismissViewControllerAnimated:YES completion:nil];
			}
			else [ProgressHUD showError:error.userInfo[@"error"]];
		}];
	}
	else [ProgressHUD showError:@"Please fill all fields!"];
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
	return 5;
}

//-------------------------------------------------------------------------------------------------------------------------------------------------
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
//-------------------------------------------------------------------------------------------------------------------------------------------------
{
    if (indexPath.row == 0) return cellUsername;
	if (indexPath.row == 1) return cellName;
	if (indexPath.row == 2) return cellEmail;
	if (indexPath.row == 3) return cellPassword;
	if (indexPath.row == 4) return cellButton;
	return nil;
}

#pragma mark - UITextField delegate

//-------------------------------------------------------------------------------------------------------------------------------------------------
- (BOOL)textFieldShouldReturn:(UITextField *)textField
//-------------------------------------------------------------------------------------------------------------------------------------------------
{
    if (textField == fieldUsername)
    {
        [fieldName becomeFirstResponder];
    }

	if (textField == fieldName)
	{
		[fieldPassword becomeFirstResponder];
	}
	if (textField == fieldEmail)
	{
		[fieldEmail becomeFirstResponder];
	}
	if (textField == fieldPassword)
	{
		[self actionRegister:nil];
	}
	return YES;
}

@end
