//
//  UserInfoTableViewController.m
//  RegistrationForm
//
//  Created by Max Soiferman on 12.07.2018.
//  Copyright © 2018 Max Soiferman. All rights reserved.
//

#import "UserInfoTableViewController.h"
#import "RegistrationFormModel.h"
#import "CoreDataStack.h"
#import "UserDetailViewController.h"
#import "ToDoModel.h"

#import "ToDoFormModel.h"

@interface UserInfoTableViewController () <UITextFieldDelegate, UIAlertViewDelegate>

@property (nonatomic, strong) RegistrationFormModel *regModel;
@property (nonatomic, readonly) NSManagedObjectContext *managedObjectContext;

@property (strong, nonatomic) IBOutlet UIView *toDoHeaderView;
@property (strong, nonatomic) IBOutlet UIView *userInfoHeaderView;

@property (weak, nonatomic) IBOutlet UILabel *fullNameLabel;

@property (nonatomic, strong) NSArray <FieldFormModel *> *userFieldsArray;
@property (nonatomic, strong) NSArray <ToDoModel *> *toDoArray;

@property (weak, nonatomic) IBOutlet UIImageView *avatarImage;


@end

static NSString *userCellIdentifier = @"userCellIdentifier";
static NSString *toDoCellIdentifier = @"toDoCellIdentifier";

@implementation UserInfoTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.regModel = [[RegistrationFormModel alloc]init];
    self.toDoArray = [NSArray new];
    [self fillFormFromModel];
    [self configureAvatarImage];


    [self fetchingData];

    NSArray *keysArray = @[@"phone", @"email", @"position"];
    self.userFieldsArray = [self.regModel fieldsWithKeys:keysArray];
    
}

- (void)fetchingData {
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"Events"];
    fetchRequest.predicate = [NSPredicate predicateWithFormat:@"owner == %@", self.userModel];
    self.toDoArray = [self.managedObjectContext executeFetchRequest:fetchRequest error:nil];
    
}


- (void)configureAvatarImage {
    self.avatarImage.layer.cornerRadius = YES;
    self.avatarImage.layer.borderWidth = 0.5f;
    self.avatarImage.layer.cornerRadius = self.avatarImage.frame.size.height/2;
    self.avatarImage.clipsToBounds = YES;
}

#pragma mark - CoreData

- (NSManagedObjectContext *)managedObjectContext {
    return [[CoreDataStack sharedManager] managedObjectContext];
}

#pragma mark - FillModel

- (void)fillFormFromModel {
    [self.regModel fillFieldsWithModel:self.userModel];
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
         return self.userFieldsArray.count;
    }
    return self.toDoArray.count;
   
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  
    UITableViewCell *cell;
    if (indexPath.section == 0) {
        cell = [tableView dequeueReusableCellWithIdentifier:userCellIdentifier forIndexPath:indexPath];
        cell.textLabel.text = self.userFieldsArray[indexPath.row].title;
        cell.detailTextLabel.text = self.userFieldsArray[indexPath.row].value;
    
    }
    else if (indexPath.section == 1) {
        cell = [tableView dequeueReusableCellWithIdentifier:toDoCellIdentifier forIndexPath:indexPath];
        cell.textLabel.text = self.toDoArray[indexPath.row].toDoEvent;
    }
    
    return cell;
}


#pragma mark - UITableViewDelegate

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    
    if (section == 0) {
        return @"User Info";
    }
    return @"TO DO";
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    self.fullNameLabel.text = [NSString stringWithFormat:@"%@ %@", self.userModel.firstName, self.userModel.lastName];
    if (section == 0) {
        return self.userInfoHeaderView;
    }
    
    return self.toDoHeaderView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section ==0) {
        return self.userInfoHeaderView.frame.size.height;
    }
    return self.toDoHeaderView.frame.size.height;
}


-(NSArray *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath {

    //Edit action
    UITableViewRowAction *editAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleNormal title:@"Edit" handler:^(UITableViewRowAction *action, NSIndexPath *indexPath){
        [self editToDoAlertWithIndexPath:indexPath];
    }];
    editAction.backgroundColor = [UIColor blueColor];

    //Delete Action
    UITableViewRowAction *deleteAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleNormal title:@"Delete"  handler:^(UITableViewRowAction *action, NSIndexPath *indexPath){
        // Deleting row from the data source
        [self.managedObjectContext deleteObject:[self.toDoArray objectAtIndex:indexPath.row]];
        [self.managedObjectContext save:nil];

        [self fetchingData];
        
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        //---
    }];
    deleteAction.backgroundColor = [UIColor redColor];
    
    return @[deleteAction,editAction];
}

#pragma mark - Segue

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"detail"]) {
        UserDetailViewController *detailVC = segue.destinationViewController;
        detailVC.userModel = self.userModel;

    }
}

#pragma mark - Alert

- (void)addToDoNote {
    UIAlertController * alertController = [UIAlertController alertControllerWithTitle: @"ToDo" message: @"Enter your note:" preferredStyle:UIAlertControllerStyleAlert];
    //Add ToDo Event
    [alertController addTextFieldWithConfigurationHandler:^(UITextField *textField) {
        textField.placeholder = @"Place your text here";
        textField.textColor = [UIColor blueColor];
        textField.clearButtonMode = UITextFieldViewModeWhileEditing;
    }];
    
    //ok alert button
    
    [alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {

        //Save data to CoreData
        ToDoModel *model;
        model = [NSEntityDescription insertNewObjectForEntityForName:@"Events" inManagedObjectContext:self.managedObjectContext];
        model.toDoEvent = [[alertController textFields]firstObject].text;
        model.owner = self.userModel;

        ToDoFormModel *formModel = [ToDoFormModel new];
        [formModel fillFieldsWithModel:model];

        if (![formModel validate]) {
           // [action setEnabled:NO];
            [self.managedObjectContext deleteObject:model];
        } else {
            [[CoreDataStack sharedManager] saveContext];
        }

        //Updating tableview after adding ToDo event
        [self fetchingData];
        [self.tableView reloadData];
    }]];
    
    //Cancel button
    [alertController addAction:[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        
    }]];
    
    [self presentViewController:alertController animated:YES completion:nil];
}

- (void)editToDoAlertWithIndexPath:(NSIndexPath *)indexPath {
   
    //Alert with edit message
    UIAlertController * alertController = [UIAlertController alertControllerWithTitle:@"Edit ToDo" message: @"here text" preferredStyle:UIAlertControllerStyleAlert];
    [alertController addTextFieldWithConfigurationHandler:^(UITextField *textField) {
        textField.placeholder = @"Place your text here";
        textField.textColor = [UIColor blueColor];
        textField.clearButtonMode = UITextFieldViewModeWhileEditing;
        textField.text = self.toDoArray[indexPath.row].toDoEvent; //fill alert with data information
    }];
    
    //Confirm button
    [alertController addAction:[UIAlertAction actionWithTitle:@"Confirm" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {

        ToDoModel *model;
        model = self.toDoArray[indexPath.row];
        model.toDoEvent = [[alertController textFields]firstObject].text;
        [[CoreDataStack sharedManager] saveContext];
        
        [self.tableView reloadData];
    }]];
    
    //Cancel button
    [alertController addAction:[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        
    }]];
     
     [self presentViewController:alertController animated:YES completion:nil];
}

#pragma mark - Actions

- (IBAction)addToDoAction:(id)sender {
    [self addToDoNote];
}

@end
