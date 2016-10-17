//
//  EPMessageInfo.h
//  ForexClubTest
//
//  Created by Эдуард Пятницын on 26.02.16.
//  Copyright © 2016 EP. All rights reserved.
//

#import "EPModel.h"

@interface EPMessageInfo : EPModel

@property NSString *name;
@property NSString *uid;
@property NSDate *lastUpdate;
@property NSString *updateStrategy;
@property NSString *locale;

@end
