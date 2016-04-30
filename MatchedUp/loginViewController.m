//
//  loginViewController.m
//  MatchedUp
//
//  Created by aTo on 29/04/2016.
//  Copyright © 2016 aTo. All rights reserved.
//

#import "loginViewController.h"

@interface loginViewController ()
@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;

@end

@implementation loginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.activityIndicator.hidden = YES;

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (IBAction)loginButtonPressed:(UIButton *)sender
{
    self.activityIndicator.hidden = NO;
    [self.activityIndicator startAnimating];
    NSArray *permissionsArray = @[ @"public_profile", @"email", @"user_about_me", @"user_birthday",  @"user_location", @"user_relationships", @"user_relationship_details"];
    
    [PFFacebookUtils logInInBackgroundWithReadPermissions:permissionsArray block:^(PFUser * _Nullable user, NSError * _Nullable error) {

        self.activityIndicator.hidden = YES;
        [self.activityIndicator stopAnimating];
        
        if (!user) {
            NSLog(@"%@", user);
            if (!error) {
                NSLog(@"%@", error);
            }
            else {
                NSLog(@"WTF");
            }
        }
        else{
            
            NSLog(@"User : %@  - error : %@", user, error);
            [self updateUserInformation];
            [self performSegueWithIdentifier:@"loginToTabBarSegue" sender:self];

        }
    }];
    
    
}

#pragma mark - Helper Methode

-(void)updateUserInformation
{
    if ([FBSDKAccessToken currentAccessToken]) {
        
        FBSDKGraphRequest *request = [[FBSDKGraphRequest alloc]
                                      initWithGraphPath:@"/me"
                                      parameters:@{ @"fields": @"name,email,birthday,location,bio,first_name,last_name,gender",}
                                      HTTPMethod:@"GET"];
        [request startWithCompletionHandler:^(FBSDKGraphRequestConnection *connection, id result, NSError *error)
         {
             if (!error) {
                 NSDictionary *userDictionary = (NSDictionary *)result;
                 NSMutableDictionary *userProfile = [[NSMutableDictionary alloc] initWithCapacity:8];
                 NSLog(@"fetched user:%@", result);
                 if(userDictionary[@"name"]){
                     userProfile[@"name"] = userDictionary[@"name"];
                 }
                 if (userDictionary[@"first_name"]) {
                     userProfile[@"first_name"] = userDictionary[@"first_name"];
                 }
                 if (userDictionary[@"email"]) {
                     userProfile[@"email"] = userDictionary[@"email"];
                 }
                 if (userDictionary[@"last_name"]) {
                     userProfile[@"last_name"] = userDictionary[@"last_name"];
                 }
                 if (userDictionary[@"location"][@"name"]) {
                     userProfile[@"location"] = userDictionary[@"location"][@"name"];
                 }
                 if (userDictionary[@"gender"]) {
                     userProfile[@"gender"] = userDictionary[@"gender"];
                 }
                 if (userDictionary[@"birthday"]) {
                     userProfile[@"birthday"] = userDictionary[@"birthday"];
                 }
                 if (userDictionary[@"user_about_me"]) {
                     userProfile[@"user_about_me"] = userDictionary[@"user_about_me"];
                     
                 }
                 [[PFUser currentUser] setObject:userProfile forKey:@"profile"];
                 [[PFUser currentUser] saveInBackground];
             }
             else {
                 NSLog(@"Error in Facebook Request %@", error);
             }
         }];
    }
}

@end
