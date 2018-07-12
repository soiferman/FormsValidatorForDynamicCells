//
//  EmailRule.m
//  RegistrationForm
//
//  Created by Max Soiferman on 09.07.2018.
//  Copyright © 2018 Max Soiferman. All rights reserved.
//

#import "EmailRule.h"

@implementation EmailRule

- (BOOL)validate {
    return [self validEmail:self.value];
}

- (BOOL)validEmail:(NSString *)email
{
    BOOL stricterFilter = NO;
    NSString *stricterFilterString = @"^[A-Z0-9a-z\\._%+-]+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2,4}$";
    NSString *laxString = @"^.+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2}[A-Za-z]*$";
    NSString *emailRegex = stricterFilter ? stricterFilterString : laxString;
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email];
}

@end
