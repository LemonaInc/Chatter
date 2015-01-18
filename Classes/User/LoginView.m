//
// Created by Jaxon Stevens
//


#import <Parse/Parse.h>
#import "ProgressHUD.h"

#import "AppConstant.h"

#import "LoginView.h"

//-------------------------------------------------------------------------------------------------------------------------------------------------
@interface LoginView()

@property (strong, nonatomic) IBOutlet UITableViewCell *cellUsername;
@property (strong, nonatomic) IBOutlet UITableViewCell *cellPassword;
@property (strong, nonatomic) IBOutlet UITableViewCell *cellButton;
@property (strong, nonatomic) IBOutlet UITableViewCell *cellForgot;


@property (strong, nonatomic) IBOutlet UITextField *fieldUsername;
@property (strong, nonatomic) IBOutlet UITextField *fieldPassword;

@end
//-------------------------------------------------------------------------------------------------------------------------------------------------

@implementation LoginView

@synthesize cellUsername, cellPassword, cellButton, cellForgot;
@synthesize fieldUsername, fieldPassword;

//-------------------------------------------------------------------------------------------------------------------------------------------------
- (void)viewDidLoad
//-------------------------------------------------------------------------------------------------------------------------------------------------
{
	[super viewDidLoad];
	self.title = @"Login";
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
- (IBAction)actionLogin:(id)sender
//-------------------------------------------------------------------------------------------------------------------------------------------------
{
	NSString *username = fieldUsername.text;
	NSString *password = fieldPassword.text;
    username = [username lowercaseString];

	if ((username.length != 0) && (password.length != 0))
	{
		[ProgressHUD show:@"Signing in..." Interaction:NO];
		[PFUser logInWithUsernameInBackground:username password:password block:^(PFUser *user, NSError *error)
		{
			if (user != nil)
			{
				[ProgressHUD showSuccess:[NSString stringWithFormat:@"Welcome back %@!", [user objectForKey:PF_USER_FULLNAME]]];
				[self dismissViewControllerAnimated:YES completion:nil];
			}
			else [ProgressHUD showError:error.userInfo[@"error"]];
		}];
	}
	else [ProgressHUD showError:@"Please enter both email and password."];
}



//-------------------------------------------------------------------------------------------------------------------------------------------------
- (IBAction)forgot:(id)sender
//-------------------------------------------------------------------------------------------------------------------------------------------------
{
    [self forgotPassword];
}

//-------------------------------------------------------------------------------------------------------------------------------------------------
- (void)forgotPassword
//-------------------------------------------------------------------------------------------------------------------------------------------------
{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Email Address" message:@"Enter the email for your account:" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Ok", nil];
    alertView.alertViewStyle = UIAlertViewStylePlainTextInput;
    [alertView show];
}

//-------------------------------------------------------------------------------------------------------------------------------------------------
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
//-------------------------------------------------------------------------------------------------------------------------------------------------
{
    if (buttonIndex != [alertView cancelButtonIndex])
    {
        UITextField *emailTextField = [alertView textFieldAtIndex:0];
        [self sendEmail:emailTextField.text];
    }
}

//-------------------------------------------------------------------------------------------------------------------------------------------------
- (void)sendEmail:(NSString *)email
//-------------------------------------------------------------------------------------------------------------------------------------------------
{
    [PFUser requestPasswordResetForEmailInBackground:email block:^(BOOL succeeded,NSError *error)
     {
         
         if (!error) {
             [ProgressHUD showSuccess:[NSString stringWithFormat:@"Password Reset Email Sent"]];
             
         }
         else
         {
             [ProgressHUD showError:@"Sorry Email address not found"];
             
         }
     }];
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
	return 4;
}

//-------------------------------------------------------------------------------------------------------------------------------------------------
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
//-------------------------------------------------------------------------------------------------------------------------------------------------
{
	if (indexPath.row == 0) return cellUsername;
	if (indexPath.row == 1) return cellPassword;
	if (indexPath.row == 2) return cellButton;
    if (indexPath.row == 3) return cellForgot;
	return nil;
}

#pragma mark - UITextField delegate

//-------------------------------------------------------------------------------------------------------------------------------------------------
- (BOOL)textFieldShouldReturn:(UITextField *)textField
//-------------------------------------------------------------------------------------------------------------------------------------------------
{
	if (textField == fieldUsername)
	{
		[fieldPassword becomeFirstResponder];
	}
	if (textField == fieldPassword)
	{
		[self actionLogin:nil];
	}
	return YES;
}



@end
