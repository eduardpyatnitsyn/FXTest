//
//  EPView.m
//  ForexClubTest
//
//  Created by Эдуард Пятницын on 27.02.16.
//  Copyright © 2016 EP. All rights reserved.
//

#import "EPView.h"

@implementation EPView

#pragma mark - Initialisation

- (id)awakeAfterUsingCoder:(NSCoder *)aDecoder{
    if (![self.subviews count]){
        NSBundle *mainBundle = [NSBundle mainBundle];
        NSArray *loadedViews = [mainBundle loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil];
        UIView *loadedView = [loadedViews firstObject];

        loadedView.frame = self.frame;
        loadedView.autoresizingMask = self.autoresizingMask;
        loadedView.translatesAutoresizingMaskIntoConstraints =
                self.translatesAutoresizingMaskIntoConstraints;

        //update constraints
        for (NSLayoutConstraint *constraint in self.constraints) {
            id firstItem = constraint.firstItem;
            if (firstItem == self)
                firstItem = loadedView;

            id secondItem = constraint.secondItem;

            if (secondItem == self)
                secondItem = loadedView;

            [loadedView addConstraint:
                    [NSLayoutConstraint constraintWithItem:firstItem
                                                 attribute:constraint.firstAttribute
                                                 relatedBy:constraint.relation
                                                    toItem:secondItem
                                                 attribute:constraint.secondAttribute
                                                multiplier:constraint.multiplier
                                                  constant:constraint.constant]];
        }
        return loadedView;
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self configure];
    }

    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self configure];
    }

    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];

    [self configure];
}

//abstract
-(void)configure {

}

@end
