//
//  UIView+Fold
//  ForexClubTest
//
//  Created by Эдуард Пятницын on 27.02.16.
//  Copyright © 2016 EP. All rights reserved.
//

#import "UIView+Fold.h"

typedef NS_ENUM(NSInteger, FoldDirection) {
    FoldDirectionOpen,
    FoldDirectionClosed
};

@implementation UIView (Fold)


- (void)foldClosed{
    [self foldWithTransparencyInDirection:FoldDirectionClosed];
}
- (void)foldOpen{

    [self foldWithTransparencyInDirection:FoldDirectionOpen];
}

#pragma mark - Private

- (void)foldWithTransparencyInDirection:(FoldDirection)foldDirection{
    NSArray *topAndBottomView = [self prepareSplitImage];
    UIView *topHalfView = topAndBottomView[0];
    UIView *bottomHalfView = topAndBottomView[1];
    
    
    CGRect startingFrame = CGRectMake(0,
                                      -topHalfView.frame.size.height / 2,
                                      topHalfView.frame.size.width,
                                      topHalfView.frame.size.height);
    topHalfView.frame = startingFrame;
    bottomHalfView.frame = startingFrame;
    
    
    topHalfView.layer.anchorPoint = CGPointMake(0.5, 0.0);
    bottomHalfView.layer.anchorPoint = CGPointMake(0.5, 1.0);
    
    [CATransaction begin];
}

- (NSArray *)prepareSplitImage {
    CGRect topImageFrame = CGRectMake(0,
                                      0,
                                      self.frame.size.width,
                                      floorf(self.frame.size.height / 2.f));

    CGRect bottomImageFrame = CGRectMake(0,
                                         CGRectGetMaxY(topImageFrame),
                                         self.frame.size.width,
                                         ceilf(self.frame.size.height / 2));

    UIGraphicsBeginImageContext(self.frame.size);

    CGContextRef context = UIGraphicsGetCurrentContext();
    [self.layer renderInContext:context];
    UIImage *fullViewImage = UIGraphicsGetImageFromCurrentImageContext();
    
    CGImageRef imageRef = CGImageCreateWithImageInRect(fullViewImage.CGImage, topImageFrame);
    UIImage *topHalf = [UIImage imageWithCGImage:imageRef];
    CGImageRelease(imageRef);

    imageRef = CGImageCreateWithImageInRect(fullViewImage.CGImage, bottomImageFrame);
    UIImage *bottomHalf = [UIImage imageWithCGImage:imageRef];
    CGImageRelease(imageRef);

    UIGraphicsEndImageContext();

    UIImageView *topHalfView = [[UIImageView alloc] initWithImage:topHalf];
    topHalfView.frame = topImageFrame;
    
    UIImageView *bottomHalfView = [[UIImageView alloc] initWithImage:bottomHalf];
    bottomHalfView.frame = bottomImageFrame;
    
    return @[topHalfView, bottomHalfView];
}
@end
