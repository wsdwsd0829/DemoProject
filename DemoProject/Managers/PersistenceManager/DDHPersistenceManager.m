//
//  DDHPersistenceManager.m
//  DemoProject
//
//  Created by MAX on 12/17/16.
//  Copyright © 2016 MAX. All rights reserved.
//
#import "DDHPersistenceManager.h"

@implementation DDHPersistenceManager
    
+(instancetype) defaultManager {
    static DDHPersistenceManager* defaultManger;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        defaultManger = [DDHPersistenceManager new];
    });
    return defaultManger;
}
-(void) setupStack {
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"DemoModel" withExtension:@"momd"];
    NSManagedObjectModel* model = [[NSManagedObjectModel alloc] initWithContentsOfURL: modelURL];
    NSAssert(model != nil, @"Error initializing Managed Object Model");
    NSPersistentStoreCoordinator* coordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:model];
    
    self.mainContext = [[NSManagedObjectContext alloc] initWithConcurrencyType: NSMainQueueConcurrencyType];
    self.parentContext = [[NSManagedObjectContext alloc] initWithConcurrencyType: NSPrivateQueueConcurrencyType];
    [self.mainContext setParentContext:self.parentContext];
    [self.parentContext setPersistentStoreCoordinator: coordinator];

    //Hook up Magic Record
    [NSPersistentStoreCoordinator MR_coordinatorWithSqliteStoreNamed:@"DemoModel.sqlite"];
    [NSPersistentStoreCoordinator MR_setDefaultStoreCoordinator:coordinator];
    [NSManagedObjectContext MR_setRootSavingContext: self.parentContext];
    [NSManagedObjectContext MR_setDefaultContext: self.mainContext];
    
    NSURL *persistURL =  [[[[NSFileManager defaultManager] URLsForDirectory: NSDocumentDirectory inDomains:NSUserDomainMask]
          firstObject] URLByAppendingPathComponent:@"DemoModel.sqlite"];
    NSError *error = nil;
    [coordinator addPersistentStoreWithType: NSSQLiteStoreType configuration:nil URL:persistURL options:@{ NSMigratePersistentStoresAutomaticallyOption: @YES,
NSInferMappingModelAutomaticallyOption: @YES} error:&error];
    if(error) {
        NSLog(@"%@", error);
        NSAssert(NO, [NSString stringWithFormat:@"error for adding persistence store"]);
    }
}
- (void)saveMainContext {
    [self.mainContext performBlock:^{
        NSError *childError = nil;
        if ([self.mainContext save:&childError]) {
            [self.parentContext performBlock:^{
                NSError *parentError = nil;
                if (![self.parentContext save:&parentError]) {
                    NSLog(@"Error saving parent");
                }
            }];
        } else {
            NSLog(@"Error saving child");
        }
    }];
}
-(void)deleteObjects: (NSArray*) objects {
    for(id obj in objects) {
        if(((NSManagedObject*)obj).managedObjectContext == self.parentContext) {
            [self.parentContext deleteObject:obj];
        }
    }
}
-(NSManagedObjectContext*) backgroundContext {
   NSManagedObjectContext* childContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSPrivateQueueConcurrencyType];
    childContext.parentContext = self.mainContext;
    return childContext;
}
@end
