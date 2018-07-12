//
//  ViewController.m
//  RegistrationForm
//
//  Created by Max Soiferman on 28.06.2018.
//  Copyright © 2018 Max Soiferman. All rights reserved.
//

#import "UserDetailViewController.h"
#import "RegistrationFormModel.h"
#import "FieldFormModel.h"
#import "TableViewCell.h"
#import "CoreDataStack.h"

@interface UserDetailViewController ()

@property (nonatomic, strong) RegistrationFormModel *regModel;
@property (nonatomic, readonly) NSManagedObjectContext *managedObjectContext;


@end

static NSString *cellIdentifier = @"CellIdentifier";

@implementation UserDetailViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.regModel = [[RegistrationFormModel alloc]init];
}

#pragma mark - CoreData

- (NSManagedObjectContext *)managedObjectContext {
    return [[CoreDataStack sharedManager] managedObjectContext];
}


#pragma mark - UITableViewDataSource

- (NSArray <FieldFormModel *> *)rowsArray {
    return self.regModel.rowsArray;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.rowsArray.count + 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    NSInteger totalRow = [tableView numberOfRowsInSection:indexPath.section];
    if (indexPath.row == totalRow - 1) {

        UITableViewCell *cellButton = [tableView dequeueReusableCellWithIdentifier:@"CellIdentifierButton" forIndexPath:indexPath];
        return cellButton;
    }
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    
    UITextField *textField = [(TableViewCell *)cell cellTextField];
    
    textField.textColor = [UIColor blueColor];
    textField.placeholder = self.rowsArray[indexPath.row].title;
    textField.text = self.rowsArray[indexPath.row].value;
    textField.keyboardType = self.rowsArray[indexPath.row].keyboardType;
    textField.secureTextEntry = self.rowsArray[indexPath.row].secureTextEntry;
    textField.clearButtonMode = UITextFieldViewModeWhileEditing;
    [textField setTag:indexPath.row];
    return cell;

}

#pragma mark - Alerts

- (void)alertWithMessage:(NSString *)alertMessage {
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Ошибка" message:alertMessage preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil]];
    
    if (self.presentedViewController == nil) {
        [self presentViewController:alertController animated:YES completion:nil];
    }
}

#pragma mark - Actions

- (IBAction)saveButton:(id)sender {
    [self.view endEditing:YES];
    
    if (![self.regModel validate]) {
        [self alertWithMessage:[self.regModel.validator invalidMessage]];
    } else {
        //Saving data from CoreData
        UsersListModel *userListModel = [NSEntityDescription insertNewObjectForEntityForName:@"Users" inManagedObjectContext:self.managedObjectContext];
        userListModel.firstName = [self.regModel fieldWithKey:@"firstName"].value;
        userListModel.lastName = [self.regModel fieldWithKey:@"lastName"].value;
        userListModel.email = [self.regModel fieldWithKey:@"email"].value;
        userListModel.phone = [self.regModel fieldWithKey:@"phone"].value;
        userListModel.password = [self.regModel fieldWithKey:@"password"].value;
        userListModel.position = [self.regModel fieldWithKey:@"position"].value;
        [[CoreDataStack sharedManager] saveContext];
    }
}

- (IBAction)textFieldChanged:(id)sender {
    UITextField *textField = (UITextField *)sender;
    [[self rowsArray]objectAtIndex:textField.tag].value = textField.text;

   // NSLog(@"%@", self.regModel.rowsArray);
}



@end
