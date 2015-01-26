
#import "MVMLoggedInViewController.h"


@interface MVMLoggedInViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *infoLabel;

@end

@implementation MVMLoggedInViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.imageView.layer.borderColor = self.infoLabel.textColor.CGColor;
    self.imageView.layer.borderWidth = 1.0f;
    self.imageView.layer.cornerRadius = self.imageView.frame.size.width / 2.0f;
    self.imageView.layer.masksToBounds = YES;

}

- (IBAction)unwindFromPaymentVC:(UIStoryboardSegue *)segue {

}


@end
