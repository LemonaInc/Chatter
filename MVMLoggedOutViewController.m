#import "MVMLoggedOutViewController.h"


@interface MVMLoggedOutViewController ()

@property (weak, nonatomic) IBOutlet UIButton *logInButton;

@end

@implementation MVMLoggedOutViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.logInButton.layer.borderColor = self.logInButton.tintColor.CGColor;
    self.logInButton.layer.borderWidth = 1.0f;
    self.logInButton.layer.cornerRadius = 4.0f;
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];


        [self presentLoggedInVC];
    }   

- (void)presentLoggedInVC {
    [self performSegueWithIdentifier:@"presentLoggedInVC" sender:self];
}

- (IBAction)logInButtonAction:(id)sender {


                         withCompletionHandler:^(BOOL success, NSError *error) {
                             if (success) {
                                 [self presentLoggedInVC];
                             }
                             else {
                                 UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Authorization failed"
                                                                                     message:error.localizedDescription
                                                                                    delegate:self
                                                                           cancelButtonTitle:nil
                                                                           otherButtonTitles:@"OK", nil];
                                 alertView.tapBlock = ^(UIAlertView *alertView, NSInteger buttonIndex) {
                                     [alertView dismissWithClickedButtonIndex:buttonIndex animated:YES];
                                 };
                             }
    };
}

// Log out
- (IBAction)unwindFromLoggedInVC:(UIStoryboardSegue *)segue {

}

@end
