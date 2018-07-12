//
//  RFButton.m
//  RegistrationForm
//
//  Created by Max Soiferman on 28.06.2018.
//  Copyright © 2018 Max Soiferman. All rights reserved.
//

#import "RFButton.h"

@implementation RFButton


- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.titleLabel.
    self.layer.cornerRadius = 6.0f;
    self.titleLabel.textColor = [UIColor whiteColor];
    self.backgroundColor = [UIColor lightGrayColor];
    [self setTitle:@"SAVE" forState:UIControlStateNormal];
    
}

@end
