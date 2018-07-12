//
//  FieldsValidator.m
//  RegistrationForm
//
//  Created by Max Soiferman on 28.06.2018.
//  Copyright © 2018 Max Soiferman. All rights reserved.
//

#import "FieldsValidator.h"
#import "FieldFormModel.h"

@interface FieldsValidator ()

@property (nonatomic, strong) NSMutableArray <Rule *> *rules;
@property (nonatomic, strong) NSMutableArray <Rule *> *invalidRules;

@end

@implementation FieldsValidator

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.rules = [NSMutableArray new];
    }
    return self;
}


- (BOOL)validate {
    self.invalidRules = [NSMutableArray new];
    for (Rule *rule in self.rules) {
        if (![self validateRule:rule]) {
            [self.invalidRules addObject:rule];
        }
    }
    return self.invalidRules.count ? NO : YES;
}


- (BOOL)validateRule:(Rule *)rule {
    if (rule.required || !rule.isEmpty) {
        return [rule validate];
    }
    return YES;
}


- (void)addRule:(Rule *)rule {
    [self.rules addObject:rule];
}

- (NSString *)invalidMessage {
    return self.invalidRules.firstObject.message;
}



@end
