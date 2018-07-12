//
//  PhoneRule.m
//  RegistrationForm
//
//  Created by Max Soiferman on 09.07.2018.
//  Copyright © 2018 Max Soiferman. All rights reserved.
//

#import "PhoneRule.h"

@implementation PhoneRule

- (BOOL)validate {
    return [self validatePhone:self.value];
}

- (BOOL)validatePhone:(NSString *)phoneNumber
{
    NSString *phoneRegex = @"^.{6,50}$";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", phoneRegex];
    return [phoneTest evaluateWithObject:phoneNumber];
}

@end
