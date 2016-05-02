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

@end
