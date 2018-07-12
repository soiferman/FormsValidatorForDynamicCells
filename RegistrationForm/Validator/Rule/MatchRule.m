//
//  MatchRule.m
//  RegistrationForm
//
//  Created by Max Soiferman on 09.07.2018.
//  Copyright © 2018 Max Soiferman. All rights reserved.
//

#import "MatchRule.h"

@implementation MatchRule

- (BOOL)validate {
    
    NSString *str = [NSString stringWithFormat:@"%@", self.value];
    NSString *str2 = [NSString stringWithFormat:@"%@", self.secondValue];
    if ([str isEqualToString:str2]) {
        return YES;
    }
    
    return NO;
}

- (id)secondValue {
    return [self.secondModel valueForKeyPath:self.secondPropertyName];
}

@end
