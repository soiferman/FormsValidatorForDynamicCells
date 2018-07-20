//
//  ToDoAlertController.m
//  RegistrationForm
//
//  Created by Max Soiferman on 17.07.2018.
//  Copyright © 2018 Max Soiferman. All rights reserved.
//

#import "CoreDataStack.h"
#import "ToDoAlertController.h"
#import "ToDoFormModel.h"


@interface ToDoAlertController ()

@property (nonatomic, readonly) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, strong) UIViewController *viewController;
@property (nonatomic, strong) UIAlertAction *okButton;

@property (nonatomic, strong) ToDoModel *toDoModel;
@property (nonatomic, strong) ToDoFormModel *formModel;

@end

@implementation ToDoAlertController

- (id)initWithController:(UIViewController *)controller {
    self = [super init];
    if (self) {
        self.viewController = controller;
        self.toDoModel = [ToDoModel alloc];
        self.formModel = [ToDoFormModel new];
        
    }
    return self;
}

- (NSManagedObjectContext *)managedObjectContext {
    return [[CoreDataStack sharedManager] managedObjectContext];
}


#pragma mark - Alert

- (void)addToDoNote {
    self.toDoModel = [NSEntityDescription insertNewObjectForEntityForName:@"Events" inManagedObjectContext:self.managedObjectContext];
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle: @"ToDo" message: @"Enter your note:" preferredStyle:UIAlertControllerStyleAlert];
    
    //ok alert button
    
        self.okButton = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        
        if (![self.formModel validate]) {
            [action setEnabled:NO];
            [self.managedObjectContext deleteObject:self.toDoModel];
        } else {
            [self.delegate toDoAlertControllerDidSaveSuccess:self withModel:self.toDoModel];
        }

    }];
    
    [alertController addTextFieldWithConfigurationHandler:^(UITextField *textField) {
        textField.placeholder = @"Place your text here";
        textField.textColor = [UIColor blueColor];
        textField.clearButtonMode = UITextFieldViewModeWhileEditing;
        [textField addTarget:self action:@selector(textDidChange:) forControlEvents:UIControlEventEditingChanged];
        [self textDidChange:textField];
    }];
    

    [alertController addAction: self.okButton];
    
    //Cancel button
    [alertController addAction:[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        
    }]];
    
    [self.viewController presentViewController:alertController animated:YES completion:nil];
}

- (void)textDidChange:(UITextField *)textField {
    
    self.toDoModel.toDoEvent = textField.text;
    [self.formModel fillFieldsWithModel:self.toDoModel];
    
    self.okButton.enabled = [self.formModel validate];
    
}


- (void)editToDoWithModel:(ToDoModel *)model {
    
    //Alert with edit message
    UIAlertController * alertController = [UIAlertController alertControllerWithTitle:@"Edit ToDo" message: @"here text" preferredStyle:UIAlertControllerStyleAlert];
    [alertController addTextFieldWithConfigurationHandler:^(UITextField *textField) {
        textField.placeholder = @"Place your text here";
        textField.textColor = [UIColor blueColor];
        textField.clearButtonMode = UITextFieldViewModeWhileEditing;
        textField.text = model.toDoEvent; //fill alert with data information
    }];
    
    //Confirm button
    [alertController addAction:[UIAlertAction actionWithTitle:@"Confirm" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        model.toDoEvent = [[alertController textFields]firstObject].text;
        [self.delegate toDoAlertControllerDidSaveSuccess:self withModel:model];
        NSLog(@"confirm");
 
    }]];
    
    //Cancel button
    [alertController addAction:[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        NSLog(@"cancel");
    }]];
    
    [self.viewController presentViewController:alertController animated:YES completion:nil];
}

@end
