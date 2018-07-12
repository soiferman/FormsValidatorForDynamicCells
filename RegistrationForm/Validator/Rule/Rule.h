//
//  Rule.h
//  RegistrationForm
//
//  Created by Max Soiferman on 09.07.2018.
//  Copyright © 2018 Max Soiferman. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Rule : NSObject

@property (nonatomic, strong) id model;
@property (nonatomic, strong) NSString *propertyName;
@property (nonatomic, strong) NSString *message;
@property (nonatomic, assign) BOOL required;
@property (nonatomic, readonly) BOOL isEmpty;


- (BOOL)validate;
- (id)value;

@end
