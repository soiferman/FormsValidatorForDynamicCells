//
//  RegistrationModel.m
//  RegistrationForm
//
//  Created by Max Soiferman on 04.07.2018.
//  Copyright © 2018 Max Soiferman. All rights reserved.
//

#import "RegistrationFormModel.h"
#import "NameRule.h"
#import "EmailRule.h"
#import "PhoneRule.h"
#import "PasswordRule.h"
#import "MatchRule.h"
#import "LengthRule.h"

@interface RegistrationFormModel ()

@end

@implementation RegistrationFormModel


- (void)fillFields {
    
    [self addNameFieldWithTitle:@"First Name" andKey:@"firstName" withMessage:@"Введите имя"];
    [self addNameFieldWithTitle:@"Last Name" andKey:@"lastName" withMessage:@"Введите фамилию"];

    [self addEmailFieldWithTitle:@"Email" andKey:@"email" required:YES withMessage:@"Введите правильный email адрес"];
    [self addPhoneFieldWithTitle:@"Phone number" andKey:@"phone" required:NO withMessage:@"Введите корректный номер телефона"];

    [self addPasswordFieldWithTitle:@"Password" andKey:@"password" withMessage:@"Пароль должен содержать минимум 6 символов"];
    [[self addPasswordFieldWithTitle:@"Confirm Password" andKey:@"confirmPassword" withMessage:@"Введенные пароли не совпадают"]addRule:[self matchRule]];
    
}

- (id)matchRule {
    MatchRule *rule = [MatchRule new];
    rule.secondPropertyName = @"value";
    rule.secondModel = [self fieldWithKey:@"password"];
    return rule;
}

- (void)fillFieldsWithModel:(id)model
{
    [self fieldWithKey:@"confirmPassword"].value = [model valueForKey:@"password"];
    [super fillFieldsWithModel:model];
}

@end
