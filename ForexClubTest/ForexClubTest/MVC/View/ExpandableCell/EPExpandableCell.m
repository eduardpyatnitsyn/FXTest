//
//  EPExpandableCell.m
//  ForexClubTest
//
//  Created by Эдуард Пятницын on 28.02.16.
//  Copyright © 2016 EP. All rights reserved.
//

#import "EPExpandableCell.h"
#import "UIView+Fold.h"
#import "ForexTestStyle.h"

@interface EPExpandableCell ()

@property (weak, nonatomic) IBOutlet UILabel *detailsLabel;
@property (weak, nonatomic) IBOutlet UILabel *regularLabel;
@property (weak,nonatomic) IBOutlet NSLayoutConstraint *detailsHeight;
@property (weak, nonatomic) IBOutlet UIView *detailView;

@end

@implementation EPExpandableCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.withDetails = NO;
    self.detailsHeight.constant = 0;

    [self configureUI];
}


-(void) configureUI{
    
    self.backgroundColor = [ForexTestStyle cellBackgroundColor];
    
    [self setSelectedColor];
    self.detailsLabel.font = [ForexTestStyle regularFont];
    self.regularLabel.font = [ForexTestStyle regularFont];
}

-(void) setSelectedColor{
    UIView *customColorView = [[UIView alloc] init];
    customColorView.backgroundColor = [ForexTestStyle cellSelectedColor];
    self.selectedBackgroundView =  customColorView;
}

- (void)setWithDetails:(BOOL)withDetails {
    _withDetails = withDetails;
    

    if (withDetails) {
        self.detailsHeight.priority = 250;
    } else {
        self.detailsHeight.priority = 999;
    }
}

-(void)setModel:(EPMessage *)message{
    self.regularLabel.text = message.messageText;
    self.detailsLabel.text = [message.messageId stringValue];
}

-(void)openDetails{
    [self.detailView foldOpen];
}

-(void)closeDetails{
    [self.detailView foldClosed];
}

@end
