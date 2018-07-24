//
//  FieldFormModel.h
//  RegistrationForm
//
//  Created by Max Soiferman on 05.07.2018.
//  Copyright © 2018 Max Soiferman. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "FieldsValidator.h"
#import "Rule.h"
#import "FieldsValidator.h"

@interface FieldFormModel : NSObject

@property (nonatomic, strong) FieldsValidator *validator;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *key;
@property (nonatomic, assign) BOOL isRequired;
@property (nonatomic, strong) NSString *value;
@property (nonatomic) UIKeyboardType keyboardType;
@property (nonatomic) BOOL secureTextEntry;
@property (nonatomic, strong) NSString *message;

@property (nonatomic, assign) BOOL isValid;
@property (nonatomic, assign) BOOL userHasChanged;

- (void)addRule:(Rule *)rule;

@end
