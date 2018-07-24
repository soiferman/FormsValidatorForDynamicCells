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
static NSString *cellIdentifierButton = @"CellIdentifierButton";

@implementation UserDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.regModel = [[RegistrationFormModel alloc]init];
    [self fillFormFromModel];

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

        UITableViewCell *cellButton = [tableView dequeueReusableCellWithIdentifier:cellIdentifierButton forIndexPath:indexPath];
        return cellButton;
    }
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    
    TableViewCell *fieldCell = (TableViewCell *)cell;
    fieldCell.fieldModel = self.rowsArray[indexPath.row];
    fieldCell.formModel = self.regModel;
    
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

#pragma mark - FillModel

- (void)fillFormFromModel {
    [self.regModel fillFieldsWithModel:self.userModel];
}

- (void)saveUserModel {
    
    UserModel *userModel;
    if (self.userModel) {
        userModel = self.userModel;
    } else {
        userModel = [NSEntityDescription insertNewObjectForEntityForName:@"Users" inManagedObjectContext:self.managedObjectContext];
    }
        [self.regModel fillModel:userModel];

    [[CoreDataStack sharedManager] saveContext];
}


#pragma mark - Actions

- (IBAction)saveButton:(id)sender {
    [self.view endEditing:YES];
    
    if (![self.regModel validate]) {
        [self alertWithMessage:@"Заполните все подсвеченные поля"];
       // [self alertWithMessage:[self.regModel.validator invalidMessage]];
        
    } else {
        [self saveUserModel];
    }
        [self.navigationController popToRootViewControllerAnimated:YES];
}


@end
