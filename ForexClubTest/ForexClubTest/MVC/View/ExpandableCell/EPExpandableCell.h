//
//  EPExpandableCell.h
//  ForexClubTest
//
//  Created by Эдуард Пятницын on 28.02.16.
//  Copyright © 2016 EP. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EPMessage.h"

@interface EPExpandableCell : UITableViewCell

@property (nonatomic, assign) BOOL withDetails;

-(void) openDetails;
-(void) closeDetails;

-(void) setModel:(EPMessage *)message;

@end
