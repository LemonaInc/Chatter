//
// Created by Jaxon Stevens
//

#import <Parse/Parse.h>
#import "ProgressHUD.h"

#import <Social/Social.h>

#import "AppConstant.h"
#import "utilities.h"

#import "SettingsView.h"

#import "ProfileView.h"

#import "Helper.h"

#import "AboutView.h"


//-------------------------------------------------------------------------------------------------------------------------------------------------

@interface SettingsView ()


@end
//-------------------------------------------------------------------------------------------------------------------------------------------------

@implementation SettingsView

@synthesize tblView;

//-------------------------------------------------------------------------------------------------------------------------------------------------
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
//-------------------------------------------------------------------------------------------------------------------------------------------------
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        self.tabBarItem.title = nil;
        [self.tabBarItem setImage:[UIImage imageNamed:@"tab_settings"]];
        [self.tabBarItem setSelectedImage:[UIImage imageNamed:@"tab_settings"]];
        self.tabBarItem.title = @"Settings";
    }
    return self;
}

//-------------------------------------------------------------------------------------------------------------------------------------------------
- (void)viewDidLoad
//-------------------------------------------------------------------------------------------------------------------------------------------------
{
    [super viewDidLoad];
    self.title = @"Settings";
    
}
//-------------------------------------------------------------------------------------------------------------------------------------------------
- (void)viewDidAppear:(BOOL)animated
//------------------------------------------------------------------------------------------------------------------------------------------------
{
    [super viewDidAppear:animated];
}

//------------------------------------------------------------------------------------------------------------------------------------------------
- (IBAction)actionProfile:(id)sender
//------------------------------------------------------------------------------------------------------------------------------------------------
    {
        ProfileView *profileView = [[ProfileView alloc] init];
        [self.navigationController pushViewController:profileView animated:YES];
        
    }

//------------------------------------------------------------------------------------------------------------------------------------------------
- (void)share
//------------------------------------------------------------------------------------------------------------------------------------------------
    {
    UIActionSheet *actionSheet = [[UIActionSheet alloc]
                                  initWithTitle:@"Tell A Friend"
                                  delegate:self
                                  cancelButtonTitle:@"Cancel"
                                  destructiveButtonTitle:nil
                                  otherButtonTitles:@"Mail",
                                  @"Facebook", @"Twitter", nil];
    
    actionSheet.actionSheetStyle = UIActionSheetStyleDefault;
    
    [actionSheet showFromTabBar:[[self tabBarController] tabBar]];
    }

//------------------------------------------------------------------------------------------------------------------------------------------------
- (void)actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex
//------------------------------------------------------------------------------------------------------------------------------------------------
{
    if (buttonIndex == [actionSheet cancelButtonIndex])
    {
        return;
    }
    
    NSString *option = [actionSheet buttonTitleAtIndex:buttonIndex];
    if ([option isEqualToString:@"Mail"])
    {
        if ([MFMailComposeViewController canSendMail] == NO) {
            NSLog(@"cannot send email!");
        } else
        {
            MFMailComposeViewController* mail = [[MFMailComposeViewController alloc] init];
            mail.mailComposeDelegate = self;
            [mail setSubject:@"Check out Aspen!"];
            [mail setMessageBody:@"Hey! Check out Aspen! its a really cool messaging app and it is available now on the Appstore." isHTML:NO];
            if (mail)
            {
                [self presentViewController:mail animated:YES completion:nil];
            }
        }
        
    } else if ([option isEqualToString:@"Facebook"])
    {
        ([SLComposeViewController isAvailableForServiceType:SLServiceTypeFacebook]);
        {
            SLComposeViewController * fbSheetOBJ = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeFacebook];
            
            [fbSheetOBJ setInitialText:@"Hey! Check out Aspen! its a really cool messaging app and it is available now on the Appstore."];
            [fbSheetOBJ addURL:[NSURL URLWithString:@"www.lemonainc.com"]];
            
            [self presentViewController:fbSheetOBJ animated:YES completion:Nil];
        }
        
    } else if ([option isEqualToString:@"Twitter"])
    {
        ([SLComposeViewController isAvailableForServiceType:SLServiceTypeTwitter]);
        {
            SLComposeViewController *tweetSheetOBJ = [SLComposeViewController
                                                      composeViewControllerForServiceType:SLServiceTypeTwitter];
            [tweetSheetOBJ setInitialText:@"Download Aspen from the app store today!"];
            [self presentViewController:tweetSheetOBJ animated:YES completion:nil];
        }
    }
}

#pragma mark - mail delegate
//-------------------------------------------------------------------------------------------------------------------------------------------------
- (void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error
//-------------------------------------------------------------------------------------------------------------------------------------------------
{
    if (result == MFMailComposeResultSent) {
        NSLog(@"Mail sent!");
    }
    [self dismissViewControllerAnimated:YES completion:NULL];
}

//------------------------------------------------------------------------------------------------------------------------------------------------
- (IBAction)actionAbout:(id)sender
//------------------------------------------------------------------------------------------------------------------------------------------------
{
    AboutView *aboutView = [[AboutView alloc] init];
    [self.navigationController pushViewController:aboutView animated:YES];
    
}

//-------------------------------------------------------------------------------------------------------------------------------------------------
- (IBAction)logOut:(id)sender
//-------------------------------------------------------------------------------------------------------------------------------------------------
{
    [PFUser logOut];
    PostNotification(NOTIFICATION_USER_LOGGED_OUT);
    
    LoginUser(self);
}

//-------------------------------------------------------------------------------------------------------------------------------------------------
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
//-------------------------------------------------------------------------------------------------------------------------------------------------
{
    return 3;
}

//-------------------------------------------------------------------------------------------------------------------------------------------------
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
//-------------------------------------------------------------------------------------------------------------------------------------------------
{
    if (section == 0) {
        return 1;
    }else if(section ==1)
        return 2;
    else if(section ==2)
        return 1;
    else
        return 2;
}

//------------------------------------------------------------------------------------------------------------------------------------------------
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
//------------------------------------------------------------------------------------------------------------------------------------------------
{
    return 30;
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    //Titles for each sections header
    NSString *title = @"";
    switch (section) {
        case 0:
            title = @"My Account";
            break;
        case 1:
            title = @"More Information";
            break;
        case 2:
            title = @"Account Actions";
            break;
            
        default:
            break;
    }
    return title;
    
}


//-------------------------------------------------------------------------------------------------------------------------------------------------

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
//-------------------------------------------------------------------------------------------------------------------------------------------------

{
    static NSString *cellIdentifier = @"CellIdentifier";
    
    UITableViewCell *cell = nil;
    if (!cell) {
        cell = [[UITableViewCell  alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        //[cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        //[cell setBackgroundColor:[UIColor clearColor]];
        
    }
    
    //My Account
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            
            //Profile Row
            cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;

            UILabel *labelProfile=[[UILabel alloc]initWithFrame:CGRectMake(10, 5, 100, 30)];
            [Helper setToLabel:labelProfile Text:@"Your Profile" WithFont:@"" FSize:17 Color:[UIColor blackColor] backGroundColor:[UIColor clearColor]];
            [cell.contentView addSubview:labelProfile];
        }
        
    }
    
    //More Information
    else if (indexPath.section==1)
    {
        if (indexPath.row == 0) {
            
            //Share row
            cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
            
            UILabel *labelShare=[[UILabel alloc]initWithFrame:CGRectMake(10, 5, 100, 30)];
            [Helper setToLabel:labelShare Text:@"Tell a Friend" WithFont:@"" FSize:17 Color:[UIColor blackColor] backGroundColor:[UIColor clearColor]];
            [cell.contentView addSubview:labelShare];
        }
        
        else if (indexPath.row == 1) {
            
            //About row
            cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
            
            UILabel *labelAbout=[[UILabel alloc]initWithFrame:CGRectMake(10, 5, 100, 30)];
            [Helper setToLabel:labelAbout Text:@"About" WithFont:@"" FSize:17 Color:[UIColor blackColor] backGroundColor:[UIColor clearColor]];
            [cell.contentView addSubview:labelAbout];
            
            UILabel *labelVersion=[[UILabel alloc]initWithFrame:CGRectMake(80, 5, 210, 30)];
            [Helper setToLabel:labelVersion Text:@"v1.1" WithFont:@"HelveticaNeue" FSize:12 Color:[UIColor blackColor] backGroundColor:[UIColor clearColor]];
            labelVersion.textAlignment=NSTextAlignmentRight;
            [cell.contentView addSubview:labelVersion];
        }
        
    }
    
    //Account Actions
    else if (indexPath.section == 2) {
        
        if (indexPath.row == 0) {
            
            //Logout Row
            cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
            UILabel *labelLogOut=[[UILabel alloc]initWithFrame:CGRectMake(10, 5, 100, 30)];
            [Helper setToLabel:labelLogOut Text:@"Log Out" WithFont:@"" FSize:17 Color:[UIColor blackColor] backGroundColor:[UIColor clearColor]];
            [cell.contentView addSubview:labelLogOut];
        }
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section == 2) {
        if (indexPath.row == 0) {
            
            //Show logout alert
            UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"" message:@"Are you sure you want to log out?" delegate:self cancelButtonTitle:@"No Cancel" otherButtonTitles:@" Yes I want to leave", nil];
            
            [alert show];
            
        }
    }
    else if (indexPath.section==0)
    {
        if(indexPath.row==0)
        {
            //Push to mobile number edit view
            ProfileView *location=[[ProfileView alloc]initWithNibName:@"ProfileView" bundle:nil];
            [self.navigationController pushViewController:location animated:YES];
        }
    }
    else if (indexPath.section==1)
    {
        if(indexPath.row==0){
            //push to support view
            [self share];
        
        }
        if(indexPath.row==1)
        {
            //push to privacy view
            AboutView *location=[[AboutView alloc]initWithNibName:@"AboutView" bundle:nil];
            [self.navigationController pushViewController:location animated:YES];
        }
    }
    
    
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1) {
        [PFUser logOut];
        PostNotification(NOTIFICATION_USER_LOGGED_OUT);
        
        LoginUser(self);
    }
}


@end


