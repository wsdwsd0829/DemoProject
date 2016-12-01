//
//  BusinessDetailHeaderView.h
//  DoorDashProject
//
//  Created by MAX on 11/29/16.
//  Copyright © 2016 MAX. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DDHBusinessDetailViewModel.h"

@protocol BusinessDetailHeaderViewDelegate <NSObject>
@optional
-(void)favoriteClicked:(id)sender;
@end

@interface BusinessDetailHeaderView : UIView 

@property (nonatomic, weak) id<BusinessDetailHeaderViewDelegate> delegate;
@property (nonatomic)DDHBusinessDetailViewModel* viewModel;

-(void)updateUI;

@end
