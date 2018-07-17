//
//  ToDoFormModel.m
//  RegistrationForm
//
//  Created by Max Soiferman on 17.07.2018.
//  Copyright © 2018 Max Soiferman. All rights reserved.
//

#import "ToDoFormModel.h"
#import "NameRule.h"

@implementation ToDoFormModel

- (void)fillFields {

    [[self addNameFieldWithTitle:@"111" andKey:@"toDoEvent" withMessage:@"message"] addRule:[NameRule new]];
    
}

@end
