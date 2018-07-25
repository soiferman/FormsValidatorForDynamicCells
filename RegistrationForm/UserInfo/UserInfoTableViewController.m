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
#import "ToDoAlertController.h"


@interface UserInfoTableViewController () <ToDoAlertControllerDelegate>

@property (nonatomic, strong) RegistrationFormModel *regModel;
@property (nonatomic, readonly) NSManagedObjectContext *managedObjectContext;

@property (strong, nonatomic) IBOutlet UIView *toDoHeaderView;
@property (strong, nonatomic) IBOutlet UIView *userInfoHeaderView;

@property (weak, nonatomic) IBOutlet UILabel *fullNameLabel;

@property (nonatomic, strong) NSArray <FieldFormModel *> *userFieldsArray;
@property (nonatomic, strong) NSArray <ToDoModel *> *toDoArray;

@property (weak, nonatomic) IBOutlet UIImageView *avatarImage;

@property (nonatomic, strong) ToDoAlertController *toDoAlertController;


@end

static NSString *userCellIdentifier = @"userCellIdentifier";
static NSString *toDoCellIdentifier = @"toDoCellIdentifier";

@implementation UserInfoTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.regModel = [[RegistrationFormModel alloc]init];
    self.toDoArray = [NSArray new];
    self.toDoAlertController = [[ToDoAlertController alloc]initWithController:self];
    self.toDoAlertController.delegate = self;
    [self fillFormFromModel];
    [self configureAvatarImage];

    [self fetchingData];

    NSArray *keysArray = @[@"phone", @"email", @"position"];
    self.userFieldsArray = [self.regModel fieldsWithKeys:keysArray];
    
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

- (void)fetchingData {
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"Events"];
    fetchRequest.predicate = [NSPredicate predicateWithFormat:@"owner == %@", self.userModel];
    self.toDoArray = [self.managedObjectContext executeFetchRequest:fetchRequest error:nil];
    
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

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    self.fullNameLabel.text = [NSString stringWithFormat:@"%@ %@", self.userModel.firstName, self.userModel.lastName];
    if (section == 0) {
        return self.userInfoHeaderView;
    }
    
    return self.toDoHeaderView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return self.userInfoHeaderView.frame.size.height;
    }
    return self.toDoHeaderView.frame.size.height;
}


- (NSArray *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath {
    //Edit action
    UITableViewRowAction *editAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleNormal title:@"Edit" handler:^(UITableViewRowAction *action, NSIndexPath *indexPath){
        [self.toDoAlertController editToDoWithModel:self.toDoArray[indexPath.row]];
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



#pragma mark - ToDoAlertControllerDelegate

- (void)toDoAlertControllerDidSaveSuccess:(ToDoAlertController *)alertController withModel:(ToDoModel *)model {
    model.owner = self.userModel;
    [[CoreDataStack sharedManager] saveContext];
    [self fetchingData];
    [self.tableView reloadData];
}

#pragma mark - Segue

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"detail"]) {
        UserDetailViewController *detailVC = segue.destinationViewController;
        detailVC.userModel = self.userModel;

    }
}


#pragma mark - Actions

- (IBAction)addToDoAction:(id)sender {
    [self.toDoAlertController addToDoNote];
}

@end
