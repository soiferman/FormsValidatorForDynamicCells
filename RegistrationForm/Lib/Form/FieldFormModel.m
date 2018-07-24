//
//  FieldFormModel.m
//  RegistrationForm
//
//  Created by Max Soiferman on 05.07.2018.
//  Copyright © 2018 Max Soiferman. All rights reserved.
//

#import "FieldFormModel.h"

@implementation FieldFormModel


- (NSString *)description {
    NSString *str = [NSString stringWithFormat:@"<FieldFormModel: title - %@, key - %@, value - %@>", self.title, self.key, self.value];
    return str;
}

- (void)addRule:(Rule *)rule {
    rule.model = self;
    rule.propertyName = @"value";
    rule.required = self.isRequired;
    if (rule.message == nil) rule.message = self.message;

    [self.validator addRule:rule];
}

@end
