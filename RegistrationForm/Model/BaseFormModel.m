//
//  BaseFormModel.m
//  RegistrationForm
//
//  Created by Max Soiferman on 05.07.2018.
//  Copyright © 2018 Max Soiferman. All rights reserved.
//

#import "BaseFormModel.h"
#import "NameRule.h"
#import "UserModel.h"


@implementation BaseFormModel

- (instancetype)init {
    self = [super init];
    if (self) {
        self.validator = [[FieldsValidator alloc]init];
        self.rowsArray = [[NSMutableArray alloc]init];
        [self fillFields];
    }
    return self;
}

- (void)fillFields {

}

- (void)fillModel:(id)model {
    for (FieldFormModel *field in self.rowsArray) {
        if ([self propertyExistWithModel:model property:field.key])
            [model setValue:field.value forKey:field.key];
    }
}

- (void)fillFieldsWithModel:(id)model {
    for (FieldFormModel *field in self.rowsArray) {
        if ([self propertyExistWithModel:model property:field.key])
            field.value = [model valueForKey:field.key];

    }
}

- (BOOL)propertyExistWithModel:(id)model property:(NSString *)property {
    
    if ([model respondsToSelector:NSSelectorFromString(property)]) {
        return YES;
    }
  //NSLog(@"%@ not found in model %@", property, model);
    return NO; 
}

- (NSArray <FieldFormModel *> *)fieldsWithKeys:(NSArray *)keysList {
  
    NSMutableArray *array = [NSMutableArray new];
    
    for (FieldFormModel *field in self.rowsArray) {
        if ([keysList containsObject:field.key]) {
            [array addObject:field];
        }
    }
    return array;
}

- (FieldFormModel *)addNameFieldWithTitle:(NSString *)title andKey:(NSString *)key withMessage:(NSString *)message {
    return [self addFieldWithTitle:title andKey:key required:YES keyboardType:UIKeyboardTypeDefault withMessage:message];
}

- (FieldFormModel *)addFieldWithTitle:(NSString *)title andKey:(NSString *)key withMessage:(NSString *)message {
    return [self addFieldWithTitle:title andKey:key required:NO keyboardType:UIKeyboardTypeDefault withMessage:message];
}

- (FieldFormModel *)addFieldWithTitle:(NSString *)title andKey:(NSString *)key required:(BOOL)required withMessage:(NSString *)message {
    return [self addFieldWithTitle:title andKey:key required:required withMessage:message keyboardType:UIKeyboardTypeDefault secureTextEntry:NO];
}

- (FieldFormModel *)addFieldWithTitle:(NSString *)title andKey:(NSString *)key required:(BOOL)required keyboardType:(UIKeyboardType)keyboardType withMessage:(NSString *)message {
   return [self addFieldWithTitle:title andKey:key required:required withMessage:message keyboardType:UIKeyboardTypeDefault secureTextEntry:NO];
}

- (FieldFormModel *)addPhoneFieldWithTitle:(NSString *)title andKey:(NSString *)key required:(BOOL)required withMessage:(NSString *)message {
    return [self addFieldWithTitle:title andKey:key required:required keyboardType:UIKeyboardTypeNumberPad withMessage:message];
}

- (FieldFormModel *)addEmailFieldWithTitle:(NSString *)title andKey:(NSString *)key required:(BOOL)reqired withMessage:(NSString *)message {
    return [self addFieldWithTitle:title andKey:key required:reqired keyboardType:UIKeyboardTypeEmailAddress withMessage:message];
}

- (FieldFormModel *) addPasswordFieldWithTitle:(NSString *)title andKey:(NSString *)key withMessage:(NSString *)message{
    return [self addFieldWithTitle:title andKey:key required:YES withMessage:message keyboardType:UIKeyboardTypeDefault secureTextEntry:YES];
}


- (FieldFormModel *)addFieldWithTitle:(NSString *)title andKey:(NSString *)key required:(BOOL)required withMessage:(NSString *)message keyboardType:(UIKeyboardType)keyboardType secureTextEntry:(BOOL)secureTextEntry {
    
    FieldFormModel *model = [[FieldFormModel alloc]init];
    model.title = title;
    model.key = key;
    model.isRequired = required;
    model.message = message;
    model.value = @"";
    model.keyboardType = keyboardType;
    model.secureTextEntry = secureTextEntry;
    model.validator = self.validator;
    
    [self.rowsArray addObject:model];
    
    return model;
}

- (FieldFormModel *) fieldWithKey:(NSString *)key {
    for (FieldFormModel *field in self.rowsArray) {
        if ([field.key isEqualToString:key]) {
            return field;
        }
    }
    return nil;
}

- (BOOL)validate {
   return [self.validator validate];
}

//- (void)addRule:(Rule *)rule {
//    [self.validator addRule:rule];
//}



@end
