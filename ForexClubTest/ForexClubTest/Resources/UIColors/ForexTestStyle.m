//
//  ForexTestStyle.m
//  ForexClubTest
//
//  Created by Эдуард Пятницын on 26.02.16.
//  Copyright © 2016 EP. All rights reserved.
//

#import "ForexTestStyle.h"

@implementation ForexTestStyle

// -----------------------------------------------------------------------------
#pragma mark - Colors
// -----------------------------------------------------------------------------

+(UIColor *)backgroundColor{
    return [UIColor colorWithRed:0.5f green:0.5f blue:0.5f alpha:1.0f];
}

// -----------------------------------------------------------------------------
#pragma mark - Fonts
// -----------------------------------------------------------------------------

+ (UIFont *)regularFontOfSize:(CGFloat)size {
    return [UIFont fontWithName:@"HelveticaNeue" size:size];
}

+ (UIFont *)regularFont {
    return [self regularFontOfSize:12.];
}

@end
