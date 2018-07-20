//
//  ToDoAlertController.h
//  RegistrationForm
//
//  Created by Max Soiferman on 17.07.2018.
//  Copyright © 2018 Max Soiferman. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "ToDoModel.h"

@class ToDoAlertController;

@protocol ToDoAlertControllerDelegate <NSObject>

@required

- (void)toDoAlertControllerDidSaveSuccess:(ToDoAlertController *)alertController withModel:(ToDoModel *)model;

@end

@interface ToDoAlertController : NSObject

@property (nonatomic, weak) id <ToDoAlertControllerDelegate> delegate;


- (void)addToDoNote;
- (void)editToDoWithModel:(ToDoModel *)model;
- (id)initWithController:(UIViewController *)controller;

@end
