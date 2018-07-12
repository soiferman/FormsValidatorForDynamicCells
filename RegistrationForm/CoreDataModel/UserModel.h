//
//  UsersListModel.h
//  RegistrationForm
//
//  Created by Max Soiferman on 11.07.2018.
//  Copyright © 2018 Max Soiferman. All rights reserved.
//

#import "BaseManagedObject.h"

@interface UserModel : BaseManagedObject

@property (nonatomic, strong) NSString *firstName;
@property (nonatomic, strong) NSString *lastName;
@property (nonatomic, strong) NSString *email;
@property (nonatomic, strong) NSString *phone;
@property (nonatomic, strong) NSString *position;
@property (nonatomic, strong) NSString *password;

@end
