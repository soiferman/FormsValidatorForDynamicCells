//
//  BaseFormModel.h
//  RegistrationForm
//
//  Created by Max Soiferman on 05.07.2018.
//  Copyright © 2018 Max Soiferman. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FieldFormModel.h"
#import "FieldsValidator.h"

@interface BaseFormModel : NSObject

@property (nonatomic, strong) NSMutableArray <FieldFormModel *> *rowsArray;
@property (nonatomic, strong) FieldsValidator *validator;

- (void)fillFields;

- (FieldFormModel *)addNameFieldWithTitle:(NSString *)title andKey:(NSString *)key withMessage:(NSString *)message;

- (FieldFormModel *)addFieldWithTitle:(NSString *)title andKey:(NSString *)key withMessage:(NSString *)message;
- (FieldFormModel *)addFieldWithTitle:(NSString *)title andKey:(NSString *)key required:(BOOL)required withMessage:(NSString *)message;

- (FieldFormModel *)addFieldWithTitle:(NSString *)title andKey:(NSString *)key required:(BOOL)required keyboardType:(UIKeyboardType)keyboardType withMessage:(NSString *)message;

- (FieldFormModel *)addPhoneFieldWithTitle:(NSString *)title andKey:(NSString *)key required:(BOOL)required withMessage:(NSString *)message;
- (FieldFormModel *)addEmailFieldWithTitle:(NSString *)title andKey:(NSString *)key required:(BOOL)reqired withMessage:(NSString *)message;

- (FieldFormModel *)addPasswordFieldWithTitle:(NSString *)title andKey:(NSString *)key withMessage:(NSString *)message;
- (FieldFormModel *)addFieldWithTitle:(NSString *)title andKey:(NSString *)key required:(BOOL)required withMessage:(NSString *)message keyboardType:(UIKeyboardType)keyboardType secureTextEntry:(BOOL)secureTextEntry;

- (FieldFormModel *)fieldWithKey:(NSString *)key;

- (void)fillModel:(id)model;
- (void)fillFieldsWithModel:(id)model;

- (BOOL)validate;

@end
