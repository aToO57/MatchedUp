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
@property (strong, nonatomic) NSMutableData *imageData;

@end

@implementation loginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.activityIndicator.hidden = YES;

}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:YES];
 
    // Check if user is cached and linked to Facebook, if so, bypass login
    if ([PFUser currentUser] && [PFFacebookUtils isLinkedWithUser:[PFUser currentUser]]) {
        [self updateUserInformation];
        
        NSLog(@"the user is already signed in ");
        [self performSegueWithIdentifier:@"loginToHomeSegue" sender:self];
    }
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
            
            [self updateUserInformation];
            [self performSegueWithIdentifier:@"loginToHomeSegue" sender:self];

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
                 
                 //create URL
                 NSString *facebookID = userDictionary[@"id"];
                 NSURL *pictureURL = [NSURL URLWithString:[NSString stringWithFormat:@"https://graph.facebook.com/%@/picture?type=large&return_ssl_resources=1", facebookID]];
                 
                 NSMutableDictionary *userProfile = [[NSMutableDictionary alloc] initWithCapacity:8];
                 if(userDictionary[@"name"]){
                     userProfile[kUserProfileNameKey] = userDictionary[@"name"];
                 }
                 if (userDictionary[@"first_name"]) {
                     userProfile[kUserProfileFirstNameKey] = userDictionary[@"first_name"];
                 }
                 if (userDictionary[@"last_name"]) {
                     userProfile[kUserProfileLastNameKey] = userDictionary[@"last_name"];
                 }
                 if (userDictionary[@"email"]) {
                     userProfile[kUserProfileEmailKey] = userDictionary[@"email"];
                 }
                 if (userDictionary[@"location"][@"name"]) {
                     userProfile[kUserProfileLocationKey] = userDictionary[@"location"][@"name"];
                 }
                 if (userDictionary[@"gender"]) {
                     userProfile[kUserProfileGenderKey] = userDictionary[@"gender"];
                 }
                 if (userDictionary[@"birthday"]) {
                     userProfile[kUserProfileBirthdayKey] = userDictionary[@"birthday"];
                     NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
                     [formatter setDateStyle:NSDateFormatterShortStyle];
                     NSDate *date = [formatter dateFromString:userDictionary[@"birthday"]];
                     NSDate *now = [NSDate date];
                     NSTimeInterval seconds = [now timeIntervalSinceDate:date];
                     int age = seconds / 31536000;
                     userProfile[kUserProfileAgeKey] = @(age);
                 }
                 if (userDictionary[@"user_about_me"]) {
                     userProfile[kUserProfileAboutMe] = userDictionary[@"user_about_me"];
                 }
                 if (userDictionary[@"relationship_status"]) {
                     userProfile[kUserProfileRelationshipStatusKey] = userDictionary[@"relationship_status"];
                 }
                 if ([pictureURL absoluteString]){
                     userProfile[kUserProfilePictureURL] = [pictureURL absoluteString];
                 }
                 [[PFUser currentUser] setObject:userProfile forKey:kUserProfileKey];
                 [[PFUser currentUser] saveInBackground];
                 
                 [self requestImage];
             }
             else {
                 NSLog(@"Error in Facebook Request %@", error);
             }
         }];
    }
}

-(void)uploadPFFileToParse:(UIImage *)image
{
    NSData *imageData = UIImageJPEGRepresentation(image, 0.8);
    if(!imageData){
        NSLog(@"ImageData was not found.");
        return;
    }
    PFFile *photoFile = [PFFile fileWithData:imageData];
    [photoFile saveInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
        if (succeeded) {
            PFObject *photo = [PFObject objectWithClassName:kPhotoClassKey];
            [photo setObject:[PFUser currentUser] forKey:kPhotoUserKey];
            [photo setObject:photoFile forKey:kPhotoPictureKey];
            [photo saveInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
                NSLog(@"Photo saved successfully");
            }];
        }
    }];
    
}

- (void)requestImage
{
    PFQuery *query = [PFQuery queryWithClassName:kPhotoClassKey];
    [query whereKey:kPhotoUserKey equalTo:[PFUser currentUser]];
    
    [query countObjectsInBackgroundWithBlock:^(int number, NSError * _Nullable error) {
        if(number == 0){
            PFUser *user = [PFUser currentUser];
            self.imageData = [[NSMutableData alloc] init];
            
            NSURL *profilPictureURL = [NSURL URLWithString:user[kUserProfileKey][kUserProfilePictureURL]];
            NSURLRequest *urlRequest = [NSURLRequest requestWithURL:profilPictureURL cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:4.0f];
            NSURLConnection *urlConnection = [[NSURLConnection alloc] initWithRequest:urlRequest delegate:self];
            if(!urlConnection) {
                NSLog(@"Failed to Download Picture");
            }
        }
    }];
    
}

#pragma mark - NSURLConnectionDataDelegate

-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [self.imageData appendData:data];
}

-(void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    UIImage *profileImage = [UIImage imageWithData:self.imageData];
    [self uploadPFFileToParse:profileImage];
}
@end
