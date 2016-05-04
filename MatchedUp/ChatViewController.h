//
//  ChatViewController.h
//  MatchedUp
//
//  Created by aTo on 02/05/2016.
//  Copyright © 2016 aTo. All rights reserved.
//

#import "JSMessagesViewController.h"

@interface ChatViewController : JSMessagesViewController <JSMessagesViewDelegate, JSMessagesViewDataSource>

@property (strong, nonatomic) PFObject *chatRoom;

@end
