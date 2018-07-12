//
//  Rules.m
//  RegistrationForm
//
//  Created by Max Soiferman on 05.07.2018.
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



@end
