//
//  TableViewCell.h
//  RegistrationForm
//
//  Created by Max Soiferman on 28.06.2018.
//  Copyright © 2018 Max Soiferman. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UITextField *cellTextField;
@property (weak, nonatomic) IBOutlet UILabel *errorLabel;


@end
