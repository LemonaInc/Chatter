//
// Created by Jaxon Stevens
//


//-------------------------------------------------------------------------------------------------------------------------------------------------
#define HEXCOLOR(c) [UIColor colorWithRed:((c>>24)&0xFF)/255.0 green:((c>>16)&0xFF)/255.0 blue:((c>>8)&0xFF)/255.0 alpha:((c)&0xFF)/255.0]

//-------------------------------------------------------------------------------------------------------------------------------------------------
#define		PF_INSTALLATION_CLASS_NAME			@"_Installation"		//	Class name
#define		PF_INSTALLATION_OBJECTID			@"objectId"				//	String
#define		PF_INSTALLATION_USER				@"user"					//	Pointer to User Class

#define		PF_USER_CLASS_NAME					@"_User"
#define		PF_USER_OBJECTID					@"objectId"
#define		PF_USER_USERNAME					@"username"
#define		PF_USER_PASSWORD					@"password"
#define		PF_USER_EMAIL						@"email"
#define		PF_USER_EMAILCOPY					@"emailCopy"
#define		PF_USER_FULLNAME					@"fullname"
#define		PF_USER_FULLNAME_LOWER				@"fullname_lower"
#define		PF_USER_FACEBOOKID					@"facebookId"
#define		PF_USER_PICTURE						@"picture"
#define		PF_USER_THUMBNAIL					@"thumbnail"
#define		PF_USER_FRIENDSRELATION             @"friendsRelation"


#define		PF_CHAT_CLASS_NAME					@"Chat"
#define		PF_CHAT_USER						@"user"
#define		PF_CHAT_ROOMID						@"roomId"
#define		PF_CHAT_TEXT						@"text"
#define		PF_CHAT_PICTURE						@"picture"
#define		PF_CHAT_CREATEDAT					@"createdAt"

#define		PF_CHATROOMS_CLASS_NAME				@"ChatRooms"
#define		PF_CHATROOMS_NAME					@"name"

#define		PF_MESSAGES_CLASS_NAME				@"Messages"
#define		PF_MESSAGES_USER					@"user"
#define		PF_MESSAGES_ROOMID					@"roomId"
#define		PF_MESSAGES_DESCRIPTION				@"description"
#define		PF_MESSAGES_LASTUSER				@"lastUser"
#define		PF_MESSAGES_LASTMESSAGE				@"lastMessage"
#define		PF_MESSAGES_COUNTER					@"counter"
#define		PF_MESSAGES_UPDATEDACTION			@"updatedAction"
//-------------------------------------------------------------------------------------------------------------------------------------------------
#define		NOTIFICATION_APP_STARTED			@"NCAppStarted"
#define		NOTIFICATION_USER_LOGGED_IN			@"NCUserLoggedIn"
#define		NOTIFICATION_USER_LOGGED_OUT		@"NCUserLoggedOut"
