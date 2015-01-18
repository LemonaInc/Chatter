//
// Created by Jaxon Stevens
//


#import <Parse/Parse.h>
#import "ProgressHUD.h"

#import "AppConstant.h"
#import "utilities.h"

#import "AboutView.h"

//-------------------------------------------------------------------------------------------------------------------------------------------------

@interface AboutView ()

@property (strong, nonatomic) IBOutlet UIImageView *imgView;
@property (strong, nonatomic) IBOutlet UILabel *aboutLabel;
@property (strong, nonatomic) IBOutlet UILabel *paraLabel;
@property (strong, nonatomic) IBOutlet UIButton *emailButton;
@property (strong, nonatomic) IBOutlet UIButton *webButton;



@end
//-------------------------------------------------------------------------------------------------------------------------------------------------

@implementation AboutView

@synthesize imgView;
@synthesize aboutLabel, paraLabel;
@synthesize emailButton, webButton;

//-------------------------------------------------------------------------------------------------------------------------------------------------
- (void)viewDidLoad
//-------------------------------------------------------------------------------------------------------------------------------------------------
{
    [super viewDidLoad];
    self.title = @"About Lemona Software Inc";
    // Do any additional setup after loading the view from its nib.
}

//-------------------------------------------------------------------------------------------------------------------------------------------------
- (void)viewDidAppear:(BOOL)animated
//-------------------------------------------------------------------------------------------------------------------------------------------------
{
    [super viewDidAppear:animated];
}

//-------------------------------------------------------------------------------------------------------------------------------------------------
- (IBAction)sendMail:(id)sender
//-------------------------------------------------------------------------------------------------------------------------------------------------
    {
        if ([MFMailComposeViewController canSendMail])
        {
            MFMailComposeViewController *mail = [[MFMailComposeViewController alloc] init];
            mail.mailComposeDelegate = self;
            [mail setSubject:@"Today Support"];
            [mail setMessageBody:@"Today Trouble" isHTML:NO];
            [mail setToRecipients:@[@"software@lemonainc.com"]];
            
            [self presentViewController:mail animated:YES completion:NULL];
        }
        else
        {
            NSLog(@"This device cannot send email");
        }
    }

//-------------------------------------------------------------------------------------------------------------------------------------------------
- (void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error
//-------------------------------------------------------------------------------------------------------------------------------------------------
{
    switch (result) {
        case MFMailComposeResultSent:
            NSLog(@"Email sent!");
            break;
        case MFMailComposeResultSaved:
            NSLog(@"You saved a draft of this email");
            break;
        case MFMailComposeResultCancelled:
            NSLog(@"Cancelled");
            break;
        case MFMailComposeResultFailed:
            NSLog(@"Mail failed:  An error occurred when trying to compose this email");
            break;
        default:
            NSLog(@"An error occurred when trying to compose this email");
            break;
    }
    
    [self dismissViewControllerAnimated:YES completion:NULL];
}

//-------------------------------------------------------------------------------------------------------------------------------------------------
- (IBAction)webClicked:(id)sender
//-------------------------------------------------------------------------------------------------------------------------------------------------
{
    NSURL *url = [NSURL URLWithString:@"http://www.lemonainc.com"];
    
    if (![[UIApplication sharedApplication] openURL:url]) {
        NSLog(@"%@%@",@"Failed to open url:",[url description]);
    }
}


@end
