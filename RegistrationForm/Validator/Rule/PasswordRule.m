//
//  PasswordRule.m
//  RegistrationForm
//
//  Created by Max Soiferman on 09.07.2018.
//  Copyright © 2018 Max Soiferman. All rights reserved.
//

#import "PasswordRule.h"

static const int minPasswordLength = 6;

@implementation PasswordRule

- (BOOL)validate {
    NSString *str = [NSString stringWithFormat:@"%@", self.value];
    if (str.length < minPasswordLength) {
        return NO;
    }
    return YES;
}

@end
