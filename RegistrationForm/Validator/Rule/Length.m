//
//  Length.m
//  RegistrationForm
//
//  Created by Max Soiferman on 10.07.2018.
//  Copyright © 2018 Max Soiferman. All rights reserved.
//

#import "Length.h"

@implementation Length

- (instancetype)initWithMinLength:(NSInteger)minLength {
    self = [super init];
    if (self) {
        _minLength = minLength;
    }
    return self;
}

- (BOOL)validate {
    
    NSString *str = [NSString stringWithFormat:@"%@", self.value];
    if (str.length < self.minLength) {
        return NO;
    }
    return YES;
    
}

@end
