//
//  ShakeViewController.m
//  DoorDashProject
//
//  Created by MAX on 12/19/16.
//  Copyright © 2016 MAX. All rights reserved.
//

#import "ShakeViewController.h"

@interface ShakeViewController ()
@property (weak, nonatomic) IBOutlet UIView *shakeView;
@property (weak, nonatomic) IBOutlet UIView *feedBackView;
@property (weak, nonatomic) IBOutlet UITextView *feedBackTextView;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *leftConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *rightConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightConstraint;


@end

@implementation ShakeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupViewStyle];
    self.shakeView.hidden = NO;
    self.feedBackView.hidden = YES;
}
-(void)setupViewStyle {
    //make myself transparent, iOS7 later otherwise must implement transition delegate
    //To make parent view not alpha child view: (add paraller view for decoration color&alpha, parent view to clear)
    //http://stackoverflow.com/questions/1582006/iphone-programming-applying-alpha-to-parent-but-not-to-child-views
    self.modalPresentationStyle = UIModalPresentationOverCurrentContext;
    
    self.shakeView.layer.cornerRadius = 5;
    self.shakeView.clipsToBounds = YES;
    self.feedBackView.layer.cornerRadius = 5;
    self.feedBackView.clipsToBounds = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
    // Dispose of any resources that can be recreated.
}
- (IBAction)feedbackClicked:(id)sender {
    self.feedBackView.hidden = NO;
    [self.feedBackTextView becomeFirstResponder];
    [self.view layoutIfNeeded];
    [UIView animateWithDuration:0.4 animations:^{
        self.shakeView.alpha = 0;
        self.feedBackView.alpha = 1;
        self.topConstraint.constant = 8;
        self.leftConstraint.constant = 8;
        self.rightConstraint.constant = 8;
        self.heightConstraint.constant = [UIScreen mainScreen].bounds.size.height/2;
        [self.view layoutIfNeeded];
    }];
}

- (IBAction)cancelClicked:(id)sender {
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
