//
//  ViewController.h
//  RegistrationForm
//
//  Created by Max Soiferman on 28.06.2018.
//  Copyright © 2018 Max Soiferman. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserModel.h"

@interface UserDetailViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UserModel *userModel; 

@end

