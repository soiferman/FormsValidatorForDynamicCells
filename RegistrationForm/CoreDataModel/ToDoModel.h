//
//  ToDoModel.h
//  RegistrationForm
//
//  Created by Max Soiferman on 13.07.2018.
//  Copyright © 2018 Max Soiferman. All rights reserved.
//

#import "BaseManagedObject.h"
#import "UserModel.h"

@interface ToDoModel : BaseManagedObject

@property (nonatomic, strong) NSString *toDoEvent;
@property (nonatomic, strong) UserModel *owner;

@end
