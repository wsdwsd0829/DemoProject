//
//  DDHPersistenceManager.h
//  DemoProject
//
//  Created by MAX on 12/17/16.
//  Copyright © 2016 MAX. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@interface DDHPersistenceManager : NSObject {
    
}
@property (nonatomic) NSManagedObjectContext* mainContext;
@property (nonatomic) NSManagedObjectContext* parentContext; //private writer
    
+(instancetype) defaultManager;
-(void) setupStack;
-(NSManagedObjectContext*) backgroundContext;

- (void)saveMainContext;
-(void)deleteObjects: (NSArray*) objects;
@end
