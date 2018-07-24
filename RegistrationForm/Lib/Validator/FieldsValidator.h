//
//  FieldsValidator.h
//  RegistrationForm
//
//  Created by Max Soiferman on 28.06.2018.
//  Copyright © 2018 Max Soiferman. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Rule.h"

@interface FieldsValidator : NSObject

- (BOOL)validate;
- (void)addRule:(Rule *)rule;
- (NSString *)invalidMessage;
- (BOOL)hasInvalidRulesWithModel:(id)model;
//- (NSArray *)searchRulesWithModel:(id)model;


@end


