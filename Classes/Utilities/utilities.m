//
// Created by Jaxon Stevens
//


#import <MobileCoreServices/MobileCoreServices.h>

#import "utilities.h"
#import "WelcomeView.h"
#import "NavigationController.h"

//-------------------------------------------------------------------------------------------------------------------------------------------------
void LoginUser(id target)
//-------------------------------------------------------------------------------------------------------------------------------------------------
{
	NavigationController *navigationController = [[NavigationController alloc] initWithRootViewController:[[WelcomeView alloc] init]];
	[target presentViewController:navigationController animated:YES completion:nil];
}

//-------------------------------------------------------------------------------------------------------------------------------------------------
UIImage* ResizeImage(UIImage *image, CGFloat width, CGFloat height)
//-------------------------------------------------------------------------------------------------------------------------------------------------
{
	CGSize size = CGSizeMake(width, height);
	UIGraphicsBeginImageContextWithOptions(size, NO, 0);
	[image drawInRect:CGRectMake(0, 0, size.width, size.height)];
	image = UIGraphicsGetImageFromCurrentImageContext();
	UIGraphicsEndImageContext();
	return image;
}

//-------------------------------------------------------------------------------------------------------------------------------------------------
void PostNotification(NSString *notification)
//-------------------------------------------------------------------------------------------------------------------------------------------------
{
	[[NSNotificationCenter defaultCenter] postNotificationName:notification object:nil];
}

//-------------------------------------------------------------------------------------------------------------------------------------------------
NSString* TimeElapsed(NSTimeInterval seconds)
//-------------------------------------------------------------------------------------------------------------------------------------------------
{
	NSString *elapsed;
	if (seconds < 60 * 60)
	{
		int minutes = (int) (seconds / 60);
		elapsed = [NSString stringWithFormat:@"%d %@", minutes, (minutes > 1) ? @"mins" : @"min"];
	}
	else if (seconds < 24 * 60 * 60)
	{
		int hours = (int) (seconds / (60 * 60));
		elapsed = [NSString stringWithFormat:@"%d %@", hours, (hours > 1) ? @"hours" : @"hour"];
	}
	else
	{
		int days = (int) (seconds / (24 * 60 * 60));
		elapsed = [NSString stringWithFormat:@"%d %@", days, (days > 1) ? @"days" : @"day"];
	}
	return elapsed;
}
