//
//  UserListTableViewController.m
//  RegistrationForm
//
//  Created by Max Soiferman on 10.07.2018.
//  Copyright © 2018 Max Soiferman. All rights reserved.
//

#import "UserListTableViewController.h"
#import "CoreDataStack.h"
#import "UserModel.h"
#import "UserDetailViewController.h"

@interface UserListTableViewController ()

@property (nonatomic, strong) NSArray *userLists;
@property (nonatomic, readonly) NSManagedObjectContext *managedObjectContext;

@end

@implementation UserListTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.userLists = [NSArray new];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    //Loading data from CoreData
    [self fetchingUsersFromCoreData];
}

- (void)fetchingUsersFromCoreData {
    NSFetchRequest *fetchRequst = [NSFetchRequest fetchRequestWithEntityName:@"Users"];
    self.userLists = [self.managedObjectContext executeFetchRequest:fetchRequst error:nil];
    [self.tableView reloadData];
}

#pragma mark - CoreData

- (NSManagedObjectContext *)managedObjectContext {
    return [[CoreDataStack sharedManager] managedObjectContext];
}


#pragma mark - TableViewDataDource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.userLists.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"userListCell" forIndexPath:indexPath];
    
    UserModel * model = [self.userLists objectAtIndex:indexPath.row];
    cell.textLabel.text = [NSString stringWithFormat:@"%@ %@", model.firstName, model.lastName];
    cell.detailTextLabel.text = model.email;
    
    return cell;
}


- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [self.managedObjectContext deleteObject:[self.userLists objectAtIndex:indexPath.row]];
        [self.managedObjectContext save:nil];
        
        NSFetchRequest *fetchRequst = [NSFetchRequest fetchRequestWithEntityName:@"Users"];
        self.userLists = [self.managedObjectContext executeFetchRequest:fetchRequst error:nil];
        
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        
    }
}


#pragma mark - Segue

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"detail"]) {
        UserDetailViewController *detailVC = segue.destinationViewController;
        detailVC.userModel = [self.userLists objectAtIndex:self.tableView.indexPathForSelectedRow.row];
    }
}

@end
