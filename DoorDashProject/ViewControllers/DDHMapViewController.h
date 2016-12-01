//
//  DDHMapViewController.h
//  DoorDashProject
//
//  Created by MAX on 11/29/16.
//  Copyright © 2016 MAX. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DDHAddress.h"

@protocol DDHMapViewControllerDelegate
@optional
-(void) didSelectAddress:(DDHAddress*) address fromViewController: (UIViewController*) viewController;
@end

@interface DDHMapViewController : UIViewController

@property (nonatomic, weak) id<DDHMapViewControllerDelegate> delegate;

@end
