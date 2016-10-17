//
//  UIView+Utils.m
//  
//
//  Created by Эдуард Пятницын on 23.11.15.
//
//

#import "UIView+Utils.h"
#import "objc/runtime.h"

@implementation UIView (Utils)

@dynamic usualHeight;

-(void) showView:(BOOL) show animated:(BOOL) animated direction:(UIViewHideDirection)direction{
    [self layoutIfNeeded];
    self.translatesAutoresizingMaskIntoConstraints = NO;
    NSLayoutConstraint *height = [self constraintForAttribute:NSLayoutAttributeHeight];
    NSLayoutConstraint *edgedConstraint = [self constraintForHideDirection:direction];
    
    if ((!self.usualHeight) && (height.constant != 0)){
        [self setUsualHeight: [NSNumber numberWithFloat: height.constant]];
    }
    
    CGFloat bottomPaneHeight = show ? self.usualHeight.floatValue : 0;
    CGFloat newEdgeConstraint = show ? 0 : - self.usualHeight.floatValue;
   
    height.constant = bottomPaneHeight;
    edgedConstraint.constant = newEdgeConstraint;
    
    CGFloat animationDuration = animated ? .75f : 0;
    [UIView animateWithDuration:animationDuration animations:^(){
        [self layoutIfNeeded];
    }];
}

#pragma mark - Observers

- (void)addKeyboardObservers {
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
}

- (void)removeKeyboardObservers {
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIKeyboardWillShowNotification
                                                  object:nil];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIKeyboardWillHideNotification
                                                  object:nil];
}

#pragma mark - Notifications

- (void)keyboardWillShow:(NSNotification *)notification {
    NSLog(@"%s",__PRETTY_FUNCTION__);
    NSDictionary *keyInfo = [notification userInfo];
    CGRect keyboardFrame = [keyInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    NSTimeInterval duration = [keyInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    NSLayoutConstraint *bottom = [self constraintForAttribute:NSLayoutAttributeBottom];
    
    [UIView animateWithDuration:duration animations:^{
        bottom.constant = -keyboardFrame.size.height;
        [self layoutIfNeeded];
    }];
}

- (void)keyboardWillHide:(NSNotification *)notification {
    NSLog(@"%s",__PRETTY_FUNCTION__);
    NSDictionary *keyInfo = [notification userInfo];
    NSTimeInterval duration = [keyInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    [UIView animateWithDuration:duration animations:^{
        NSLayoutConstraint *bottom = [self constraintForAttribute:NSLayoutAttributeBottom];
        bottom.constant = 0;
    }];
}

- (NSLayoutConstraint *) constraintForHideDirection:(UIViewHideDirection) direction{
    NSLayoutConstraint *constraint;
    switch (direction) {
        case UIViewHideDirectionDown:
        default:
            constraint = [self constraintForAttribute:NSLayoutAttributeBottom];
            break;
        case UIViewHideDirectionUp:
            constraint = [self constraintForAttribute:NSLayoutAttributeTop];
            break;
    }
    return constraint;
}

- (NSArray *)constaintsForAttribute:(NSLayoutAttribute)attribute {
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"firstAttribute = %d", attribute];
    NSArray *filteredArray = [[self constraints] filteredArrayUsingPredicate:predicate];
    
    return filteredArray;
}

- (NSLayoutConstraint *)constraintForAttribute:(NSLayoutAttribute)attribute {
    NSArray *constraints = [self constaintsForAttribute:attribute];
    if (constraints.count) {
        for (id constraint in constraints) {
            if ([constraint isKindOfClass:NSClassFromString(@"NSAutoresizingMaskLayoutConstraint")]) continue;
                return constraint;
        }
    }
    
    return nil;
}

#pragma mark - setters&getters for @property usualHeight;
static char UIB_USUALHEIGHT_KEY;

-(void)setUsualHeight:(NSNumber *)usualHeight{
    objc_setAssociatedObject(self, &UIB_USUALHEIGHT_KEY, usualHeight, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(NSObject*)usualHeight{
    return (NSObject*)objc_getAssociatedObject(self, &UIB_USUALHEIGHT_KEY);
}

@end
