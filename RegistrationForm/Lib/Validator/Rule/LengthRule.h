//
//  Length.h
//  RegistrationForm
//
//  Created by Max Soiferman on 10.07.2018.
//  Copyright © 2018 Max Soiferman. All rights reserved.
//

#import "Rule.h"

@interface LengthRule : Rule

@property (nonatomic, assign) NSInteger minLength;

- (instancetype)initWithMinLength:(NSInteger)minLength;

@end
