//
// Created by Jaxon Stevens
//


#import "AppConstant.h"

#import "NavigationController.h"

@implementation NavigationController

//-------------------------------------------------------------------------------------------------------------------------------------------------
- (void)viewDidLoad
//-------------------------------------------------------------------------------------------------------------------------------------------------
{
	[super viewDidLoad];

    self.navigationBar.barTintColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:1];
	self.navigationBar.tintColor = [UIColor whiteColor];
	self.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName:[UIColor whiteColor]};
	self.navigationBar.translucent = YES;
}

@end
