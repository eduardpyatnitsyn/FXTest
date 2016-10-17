//
//  EPModel.m
//  ForexClubTestApp
//
//  Created by Эдуард Пятницын on 26.02.16.
//  Copyright © 2016 EP. All rights reserved.
//

#import "EPModel.h"

#import <objc/message.h>
#import <objc/runtime.h>

@implementation EPModel

// -----------------------------------------------------------------------------
#pragma mark - getters
// -----------------------------------------------------------------------------

- (NSString *)description
{
    NSMutableDictionary *propertyValues = [NSMutableDictionary dictionary];
    unsigned int propertyCount;
    objc_property_t *properties = class_copyPropertyList([self class], &propertyCount);
    
    for (unsigned int i = 0; i < propertyCount; i++)
    {
        char const *propertyName = property_getName(properties[i]);
        const char *attr = property_getAttributes(properties[i]);
        if (attr[1] == '@') {
            NSString *selector = [NSString stringWithCString:propertyName encoding:NSUTF8StringEncoding];
            SEL sel = sel_registerName([selector UTF8String]);
            NSObject * propertyValue = objc_msgSend(self, sel);
            propertyValues[selector] = propertyValue ? propertyValue.description : @"nil";
        }
    }
    
    free(properties);
    
    return [NSString stringWithFormat:@"%@ <%p>: %@", self.class, self, propertyValues];
}

// -----------------------------------------------------------------------------

- (NSString *)debugDescription
{
    return [self description];
}

// -----------------------------------------------------------------------------
#pragma mark - Public methods
// -----------------------------------------------------------------------------
-(NSDictionary *)mappingRules{
    return @{};
}
@end
