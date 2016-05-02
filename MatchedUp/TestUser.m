//
//  TestUser.m
//  MatchedUp
//
//  Created by aTo on 02/05/2016.
//  Copyright © 2016 aTo. All rights reserved.
//

#import "TestUser.h"

@implementation TestUser

+(void)saveTestUserToParse

{
    PFUser *newUser = [PFUser user];
    newUser.username = @"user2";
    newUser.password = @"password2";
    [newUser signUpInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if(!error){
            
            
            NSLog(@"sign up %@", error);
            
            NSDictionary *profile = @{@"age" : @22, @"birthday" : @"1/15/1994", @"firstName" : @"Nathan", @"gender" : @"male", @"location" : @"Tokyo, Japan", @"name" : @"Nathan Kyo"};
            
            [newUser setObject:profile forKey:@"profile"];
            
            [newUser saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
                
                UIImage *profileImage = [UIImage imageNamed:@"astronaut.jpg"];
                NSData *imageData = UIImageJPEGRepresentation(profileImage, 0.8);
                PFFile *photoFile = [PFFile fileWithData:imageData];
                
                [photoFile saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
                    
                    if (succeeded){
                        PFObject *photo = [PFObject objectWithClassName:kPhotoClassKey];
                        [photo setObject:newUser forKey:kPhotoUserKey];
                        [photo setObject:photoFile forKey:kPhotoPictureKey];
                        [photo saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
                            NSLog(@"Photo saved successfully");
                            
                        }];
                    }
                }];
            }];
        }
    }];
}

@end