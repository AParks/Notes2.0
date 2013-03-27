//
//  ACPAppDelegate.h
//  ACPNoteApp
//
//  Created by Anna Parks on 3/26/13.
//  Copyright (c) 2013 Anna Parks. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ACPAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;

@end
