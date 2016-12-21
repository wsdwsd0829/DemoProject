//
//  BusinessProtocol.h
//  DemoProject
//
//  Created by MAX on 12/17/16.
//  Copyright © 2016 MAX. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol BusinessProtocol <NSObject>
@property (nullable, nonatomic, copy) NSString *businessId;
@property (nullable, nonatomic, copy) NSDate *createTime;
@property (nonatomic) float deliverPrice;
@property (nonatomic) int16_t deliverTime;
@property (nonatomic) BOOL favorited;
@property (nullable, nonatomic, copy) NSString *name;
@property (nullable, nonatomic, copy) NSString *type;
@property (nullable, nonatomic, copy) NSString* iconURL;
@property (nullable, nonatomic, copy) NSString* googlePhotoReference;


@end
