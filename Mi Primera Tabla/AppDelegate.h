//
//  AppDelegate.h
//  Mi Primera Tabla
//
//  Created by Ivan on 9/20/17.
//  Copyright © 2017 wondererApps. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong) NSPersistentContainer *persistentContainer;

- (void)saveContext;


@end

