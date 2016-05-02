//
//  MatchViewController.h
//  MatchedUp
//
//  Created by aTo on 02/05/2016.
//  Copyright © 2016 aTo. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MatchViewControllerDelegate <NSObject>

@required
-(void)presentMatchesViewController;

@end

@interface MatchViewController : UIViewController

@property (strong, nonatomic) UIImage *matchedUserImage;
@property (weak, nonatomic) id <MatchViewControllerDelegate> delegate;

@end
