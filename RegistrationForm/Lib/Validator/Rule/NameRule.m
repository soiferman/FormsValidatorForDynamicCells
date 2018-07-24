//
//  NameRule.m
//  RegistrationForm
//
//  Created by Max Soiferman on 09.07.2018.
//  Copyright © 2018 Max Soiferman. All rights reserved.
//

#import "NameRule.h"

@implementation NameRule

@synthesize minLength = _minLength;

- (NSInteger)minLength {
    if (_minLength == 0) {
        return 3;
    }
    return _minLength;
}

@end
