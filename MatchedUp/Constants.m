//
//  Constants.m
//  MatchedUp
//
//  Created by aTo on 30/04/2016.
//  Copyright © 2016 aTo. All rights reserved.
//

#import "Constants.h"

@implementation Constants


#pragma mark - User Class

NSString *const kUserTagLineKey         = @"tagLine";

NSString *const kUserProfileKey         = @"profile";
NSString *const kUserProfileNameKey     = @"name";
NSString *const kUserProfileFirstNameKey= @"firstName";
NSString *const kUserProfileLastNameKey = @"lastName";
NSString *const kUserProfileEmailKey    = @"email";
NSString *const kUserProfileLocationKey = @"location";
NSString *const kUserProfileGenderKey   = @"gender";
NSString *const kUserProfileBirthdayKey = @"birthday";
NSString *const kUserProfileAboutMe     = @"userAboutMe";
NSString *const kUserProfilePictureURL  = @"pictureURL";
NSString *const kUserProfileRelationshipStatusKey =@"relationshipStatus";
NSString *const kUserProfileAgeKey      =@"age";



#pragma mark - Photo Class

NSString *const kPhotoClassKey          = @"Photo";
NSString *const kPhotoUserKey           = @"user";
NSString *const kPhotoPictureKey        = @"image";

#pragma mark - Activity Class

NSString *const kActivityClassKey       = @"Activity";
NSString *const kActivityTypeKey        = @"type";
NSString *const kActivityFromUserKey    = @"fromUser";
NSString *const kActivityToUserKey      = @"toUser";
NSString *const kActivityPhotoKey       = @"photo";
NSString *const kActivityTypeLikeKey    = @"like";
NSString *const kActivityTypeDislikeKey = @"dislike";

#pragma mark - Settings

NSString *const kMenEnabledKey          = @"men";
NSString *const kWomenEnabledKey        = @"women";
NSString *const kSingleEnabledKey       = @"single";
NSString *const kAgeMaxKey              = @"ageMax";

#pragma mark - ChatRoom

NSString *const kChatRoomClassKey       = @"ChatRoom";
NSString *const kChatRoomUser1Key       = @"user1";
NSString *const kChatRoomUser2Key       = @"user2";

#pragma mark - Chat

NSString *const kChatClassKey           = @"Chat";
NSString *const kChatChatroomKey        = @"chatroom";
NSString *const kChatFromUserKey        = @"fromUser";
NSString *const kChatToUserKey          = @"toUser";
NSString *const kChatTextKey            = @"text";

@end
