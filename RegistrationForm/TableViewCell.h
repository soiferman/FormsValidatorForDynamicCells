//
//  TableViewCell.h
//  RegistrationForm
//
//  Created by Max Soiferman on 28.06.2018.
//  Copyright © 2018 Max Soiferman. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FieldFormModel.h"
#import "BaseFormModel.h"

@interface TableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UITextField *cellTextField;
@property (weak, nonatomic) IBOutlet UILabel *errorLabel;
@property (strong, nonatomic) FieldFormModel *fieldModel;
@property (strong, nonatomic) BaseFormModel *formModel;

@end
