//
//  TableViewController.h
//  ForexClubTest
//
//  Created by Эдуард Пятницын on 26.02.16.
//  Copyright © 2016 EP. All rights reserved.
//

#import <UIKit/UIKit.h>

@class EPMessage;

@protocol MessageServiceDelegate <NSObject>

-(void) didSelectMessage:(EPMessage *) message;

@end

@interface MessageService : NSObject <UITableViewDataSource,UITableViewDelegate>

@property (weak, nonatomic) id <MessageServiceDelegate> delegate;

-(void) getData:(void (^)())success failure:(void (^)(NSError *error))failure;

@end
