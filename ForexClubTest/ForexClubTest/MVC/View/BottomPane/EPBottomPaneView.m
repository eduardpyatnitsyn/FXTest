//
//  EPBottomPaneView.m
//  ForexClubTest
//
//  Created by Эдуард Пятницын on 27.02.16.
//  Copyright © 2016 EP. All rights reserved.
//

#import "EPBottomPaneView.h"
#import "EPMessage.h"

@interface EPBottomPaneView()

@property (weak, nonatomic) IBOutlet UILabel *titleLbl;

@end

@implementation EPBottomPaneView

// -----------------------------------------------------------------------------
#pragma mark - configure ui
// -----------------------------------------------------------------------------

-(void) configure{
    self.backgroundColor = [ForexTestStyle backgroundColor];
    self.titleLbl.font = [ForexTestStyle regularFont];
}

// -----------------------------------------------------------------------------
#pragma mark - Public methods
// -----------------------------------------------------------------------------
- (void)setMessage:(EPMessage *)message {
    self.titleLbl.text = message.messageText;
}

@end
