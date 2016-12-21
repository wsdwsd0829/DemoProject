//
//  NSManagedObjectContext+DDHMagicalRecordSetting.h
//  DemoProject
//
//  Created by MAX on 12/17/16.
//  Copyright © 2016 MAX. All rights reserved.
//

#import <CoreData/CoreData.h>

@interface NSManagedObjectContext (DDHMagicalRecordSetting)

+ (void) MR_setDefaultContext:(NSManagedObjectContext *)moc;
+ (void) MR_setRootSavingContext:(NSManagedObjectContext *)context;

@end
