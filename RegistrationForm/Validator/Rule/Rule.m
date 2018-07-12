//
//  Rule.m
//  RegistrationForm
//
//  Created by Max Soiferman on 09.07.2018.
//  Copyright © 2018 Max Soiferman. All rights reserved.
//

#import "Rule.h"

@implementation Rule

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
