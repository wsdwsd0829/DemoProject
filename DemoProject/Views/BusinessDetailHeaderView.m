//
//  BusinessDetailHeaderView.m
//  DoorDashProject
//
//  Created by MAX on 11/29/16.
//  Copyright © 2016 MAX. All rights reserved.
//

#import "BusinessDetailHeaderView.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface BusinessDetailHeaderView ()

@property (nonatomic, weak) IBOutlet UIView *view;

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *deliveryLabel;
@property (weak, nonatomic) IBOutlet UIButton *favoriteButton;

@end

@implementation BusinessDetailHeaderView

-(instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        NSString *className = NSStringFromClass([self class]);
        self.view = [[[NSBundle mainBundle] loadNibNamed:className owner:self options:nil] firstObject];
        [self addSubview:self.view];
        return self;
    }
    return nil;
}

-(void)updateUI {
    [self.imageView sd_setImageWithURL:[NSURL URLWithString: [self.viewModel iconURL]] placeholderImage:[UIImage imageNamed:@"placeholder"]];
    self.deliveryLabel.text = [self.viewModel deliverPriceAndTime];
    //custom for fav button
    [self.favoriteButton setTitle:[self.viewModel favoriteButtonTitle] forState:UIControlStateNormal];
    self.favoriteButton.layer.cornerRadius = 5.0f;
    self.favoriteButton.clipsToBounds = YES;
    self.favoriteButton.layer.borderColor = [DDHApplicationWideConstants doorDashThemeColor].CGColor;
    self.favoriteButton.layer.borderWidth = 1.0f;
    
    if(self.viewModel.favorite) {
        self.favoriteButton.backgroundColor = [DDHApplicationWideConstants doorDashThemeColor];
        self.favoriteButton.tintColor = [UIColor whiteColor];
        [self.favoriteButton setImage: [UIImage imageNamed:@"star-white"] forState:UIControlStateNormal];
    }else {
        self.favoriteButton.tintColor = [DDHApplicationWideConstants doorDashThemeColor];
        self.favoriteButton.backgroundColor = [UIColor whiteColor];
        [self.favoriteButton setImage:nil forState:UIControlStateNormal];
    }
}

- (IBAction)favoriteClicked:(id)sender {
    self.viewModel.favorite = !self.viewModel.favorite;
    //this is optional since favorite handled data already
    if(self.viewModel.favorite) {
        [self.delegate favoriteClicked: self];
    }
    [self updateUI];
}

@end
