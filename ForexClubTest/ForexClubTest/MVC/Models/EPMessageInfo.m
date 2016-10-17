//
//  EPMessageInfo.m
//  ForexClubTest
//
//  Created by Эдуард Пятницын on 26.02.16.
//  Copyright © 2016 EP. All rights reserved.
//

#import "EPMessageInfo.h"

@implementation EPMessageInfo

-(NSDictionary *)mappingRules{
    return @{@"Name":@"name",
             @"UID" :@"uid",
             @"LastUpdate":@"lastUpdate",
             @"UpdateStrategy":@"updateStrategy",
             @"Locale":@"locale"};
}

@end
