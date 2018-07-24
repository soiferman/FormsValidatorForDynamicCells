//
//  TableViewCell.m
//  RegistrationForm
//
//  Created by Max Soiferman on 28.06.2018.
//  Copyright © 2018 Max Soiferman. All rights reserved.
//

#import "TableViewCell.h"

@interface TableViewCell ()


@end

@implementation TableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
        
}

- (void)setFieldModel:(FieldFormModel *)fieldModel {
    _fieldModel = fieldModel;
    [self fillCellWithModel];
}

- (void)fillCellWithModel {
   
    self.cellTextField.textColor = [UIColor blueColor];
    self.cellTextField.placeholder = self.fieldModel.title;
    self.cellTextField.text = self.fieldModel.value;
    self.cellTextField.keyboardType = self.fieldModel.keyboardType;
    self.cellTextField.secureTextEntry = self.fieldModel.secureTextEntry;
    self.cellTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    
    [self updateTableViewCellState:self.cellTextField];
}

- (void)updateTableViewCellState:(UITextField *)textField {
   // FieldFormModel *fieldModel = [[self rowsArray]objectAtIndex:textField.tag];
    textField.text = self.fieldModel.value;
    
    if (self.fieldModel.userHasChanged == NO) {
        textField.layer.borderWidth = 0.f;
        self.errorLabel.text = nil;
    } else if (self.fieldModel.isValid) {
        textField.layer.borderWidth = 1.0f;
        textField.layer.borderColor = [UIColor greenColor].CGColor;
        self.errorLabel.text = nil;
    } else {
        textField.layer.borderWidth = 1.0f;
        textField.layer.borderColor = [UIColor redColor].CGColor;
        self.errorLabel.text = self.fieldModel.message;
    }
}

- (IBAction)textFieldChanged:(id)sender {
    
    UITextField *textField = (UITextField *)sender;
    
    self.fieldModel.value = textField.text;
    self.fieldModel.userHasChanged = YES;
    [self.formModel validate];
    
    [self updateTableViewCellState:textField];
    
    // NSLog(@"%@", self.regModel.rowsArray);
}


@end
