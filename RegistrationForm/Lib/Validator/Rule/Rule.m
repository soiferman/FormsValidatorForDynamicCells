//
//  Rule.m
//  RegistrationForm
//
//  Created by Max Soiferman on 09.07.2018.
//  Copyright © 2018 Max Soiferman. All rights reserved.
//

#import "Rule.h"

@implementation Rule

- (instancetype)initWithModel:(id)model withProperty:(NSString *)propertyName message:(NSString *)message required:(BOOL)isRequired {
    self = [super init];
    if (self) {
        self.model = model;
        self.propertyName = propertyName;
        self.message = message;
        self.required = isRequired;
    }
    return self;
}

- (BOOL)validate {
    return NO;
}

- (id)value {
    return [self.model valueForKeyPath:self.propertyName];
}

- (BOOL)isEmpty {
    
    if ([self value] != nil) {
        NSString *str = [NSString stringWithFormat:@"%@", [self value]];
        return str.length == 0;
    }
    
    return YES;
}



@end
