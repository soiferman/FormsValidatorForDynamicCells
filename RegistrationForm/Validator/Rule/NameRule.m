//
//  NameRule.m
//  RegistrationForm
//
//  Created by Max Soiferman on 09.07.2018.
//  Copyright © 2018 Max Soiferman. All rights reserved.
//

#import "NameRule.h"

@implementation NameRule

- (BOOL)validate {
    
    NSString *str = [NSString stringWithFormat:@"%@", self.value];
    if (str.length < 3) {
        return NO;
    }
    return YES;
}



@end
