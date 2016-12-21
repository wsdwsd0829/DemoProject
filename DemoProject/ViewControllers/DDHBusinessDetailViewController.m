//
//  DDHBusinessDetailViewController.m
//  DoorDashProject
//
//  Created by MAX on 11/29/16.
//  Copyright © 2016 MAX. All rights reserved.
//

#import "DDHBusinessDetailViewController.h"
#import "BusinessDetailHeaderView.h"
#import "DDHConstants.h"
static NSString* kMenuItemCellIdentifier = @"MenuItemCellIdentifier";

@interface DDHBusinessDetailViewController () <UITableViewDelegate, UITableViewDataSource, BusinessDetailHeaderViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView* tableView;
@end

@implementation DDHBusinessDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //TODO: optimize create custom navigation controller and set inside
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSForegroundColorAttributeName:[DDHApplicationWideConstants doorDashThemeColor]}];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView reloadData];
    // Do any additional setup after loading the view.
}

-(void)viewWillAppear:(BOOL)animated {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(businessFavoriteChanged:) name:kNotificationFavoriteChanged object:nil];
}

-(void)businessFavoriteChanged: (NSNotification *) notification{
    if([notification.name isEqualToString:kNotificationFavoriteChanged]){
        id<BusinessProtocol> bus = notification.userInfo[@"business"];
        [self.viewModel businessFavoriteChangedFor:  bus];
        [self p_updateHeaderUI];
    }
}

-(void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver: self];
}


-(void)viewDidLayoutSubviews {
    [self p_updateHeader];
}

-(void) p_updateHeader {
    if([self.tableView.tableHeaderView isKindOfClass: [BusinessDetailHeaderView class]]) {
        BusinessDetailHeaderView* header = (BusinessDetailHeaderView*)(self.tableView.tableHeaderView);
        header.viewModel = self.viewModel;
        CGRect frame = header.frame;
        frame.size.height = [header systemLayoutSizeFittingSize: UILayoutFittingCompressedSize].height;
        header.frame = frame;
        [header updateUI];
        [self.tableView reloadData];
    }
}

-(void) p_updateHeaderUI {
    if([self.tableView.tableHeaderView isKindOfClass: [BusinessDetailHeaderView class]]) {
        BusinessDetailHeaderView* header = (BusinessDetailHeaderView*)(self.tableView.tableHeaderView);
         [header updateUI];
    }
}

//MARK: tableView
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.viewModel menuItemNames].count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kMenuItemCellIdentifier];
    if(!cell){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kMenuItemCellIdentifier];
    }
    cell.textLabel.text = self.viewModel.menuItemNames[indexPath.row];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return @"Menu";
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 30;
}

@end
