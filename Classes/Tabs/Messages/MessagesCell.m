//
// Created by Jaxon Stevens
//


#import <Parse/Parse.h>

#import "AppConstant.h"
#import "utilities.h"

#import "MessagesCell.h"

//-------------------------------------------------------------------------------------------------------------------------------------------------
@interface MessagesCell()
{
	PFObject *message;
    JSQMessagesAvatarImage *placeholderImageData;
    
    NSMutableDictionary *avatars;
    NSMutableArray *users;

}

@property (strong, nonatomic) IBOutlet PFImageView *imageUser;
@property (strong, nonatomic) IBOutlet UILabel *labelDescription;
@property (strong, nonatomic) IBOutlet UILabel *labelLastMessage;
@property (strong, nonatomic) IBOutlet UILabel *labelElapsed;
@property (strong, nonatomic) IBOutlet UILabel *labelCounter;

@end
//-------------------------------------------------------------------------------------------------------------------------------------------------

@implementation MessagesCell

@synthesize imageUser;
@synthesize labelDescription, labelLastMessage;
@synthesize labelElapsed, labelCounter;

//-------------------------------------------------------------------------------------------------------------------------------------------------
- (void)bindData:(PFObject *)message_
//-------------------------------------------------------------------------------------------------------------------------------------------------
{
	message = message_;
	//---------------------------------------------------------------------------------------------------------------------------------------------
	imageUser.layer.cornerRadius = imageUser.frame.size.width/2;
	imageUser.layer.masksToBounds = YES;
	//---------------------------------------------------------------------------------------------------------------------------------------------
	PFUser *lastUser = message[PF_MESSAGES_LASTUSER];
	[imageUser setFile:lastUser[PF_USER_PICTURE]];
	[imageUser loadInBackground];
	//---------------------------------------------------------------------------------------------------------------------------------------------
	labelDescription.text = message[PF_MESSAGES_DESCRIPTION];
	labelLastMessage.text = message[PF_MESSAGES_LASTMESSAGE];
	//---------------------------------------------------------------------------------------------------------------------------------------------
	NSTimeInterval seconds = [[NSDate date] timeIntervalSinceDate:message.updatedAt] + 1000;
	labelElapsed.text = TimeElapsed(seconds);
	//---------------------------------------------------------------------------------------------------------------------------------------------
	int counter = [message[PF_MESSAGES_COUNTER] intValue];
	labelCounter.text = (counter == 0) ? @"" : [NSString stringWithFormat:@"%d new", counter];
}
@end
