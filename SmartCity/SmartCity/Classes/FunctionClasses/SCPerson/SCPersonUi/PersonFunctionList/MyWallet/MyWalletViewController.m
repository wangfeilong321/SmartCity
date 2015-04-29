//
//  MyWalletViewController.m
//  SmartCity
//
//  Created by fortsven on 15/4/10.
//  Copyright (c) 2015年 sea. All rights reserved.
//

#import "MyWalletViewController.h"
#import "MyWalletCell.h"
#import "SCPersonManager.h"
#import "WalletEntity.h"
#import "SCBoundingWalletViewController.h"
#import "SCWalletDetailViewController.h"
#import "SCBoundingWalletViewController.h"

#define VaritiesArr @[@"yzf"]

@interface MyWalletViewController ()<UITableViewDataSource, UITableViewDelegate>
{
    UITableView *walletTable;
    NSMutableArray *WalletArray;
}
@end

@implementation MyWalletViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    if(_userEntity.permission == SCUserGuest){
        self.edgesForExtendedLayout = UIRectEdgeNone;
        self.extendedLayoutIncludesOpaqueBars = YES;
    }else{
        self.title = @"我的钱包";
        
        WalletArray = [[NSMutableArray alloc]initWithCapacity:0];
        
        [self initUI];
    }
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//初始化界面
-(void)initUI
{
    walletTable = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height) style:UITableViewStyleGrouped];
    
    walletTable.delegate = self;
    walletTable.dataSource =self;
    
//    walletTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    walletTable.tableFooterView = [[UIView alloc]init];
    [self.view addSubview:walletTable];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if(_userEntity.permission == SCUserGuest){
        TouristViewController *tourist = [[TouristViewController alloc] initWithTitle:@"我的钱包" picType:@"2"];
        [self.view addSubview:tourist.view];
        [self addChildViewController:tourist];
    }else{
        NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:_userEntity.mobile,@"bandingAccount",_userEntity.username,@"accountName",_userEntity.idNumber,@"idnumber", nil];
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        [SCPersonManager execute:@selector(queryYzf) target:self callback:@selector(queryYzfCallBack:) args:dic,nil];
    }
}

-(void)queryYzfCallBack:(NSData *)data
{
    NSArray *array = nil;
    array =(NSArray *)data;
    [WalletArray addObjectsFromArray:array];
    [walletTable reloadData];
    [MBProgressHUD hideHUDForView:self.view animated:YES];
}

#pragma mark -UITableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return VaritiesArr.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.01;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"MyWalletCell";
    MyWalletCell *cell = (MyWalletCell *)[tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"MyWalletCell" owner:self options:nil] lastObject];
    }
    
    [cell setSeparatorInset:UIEdgeInsetsZero];
    
    cell.iconImageView.image = [UIImage imageNamed:[VaritiesArr objectAtIndex:indexPath.row]];
    
    if (WalletArray.count != 0) {
        [cell showDetail:[UIImage imageNamed:[VaritiesArr objectAtIndex:indexPath.row]] walletDetail:[WalletArray objectAtIndex:indexPath.row]];
    }
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    WalletEntity *entity = [[WalletEntity alloc]init];
    entity = [WalletArray objectAtIndex:indexPath.row];
    if (entity.accountName.length > 0) {
        SCWalletDetailViewController *scDetailVC =[[SCWalletDetailViewController alloc]init];
        scDetailVC.title =@"翼支付账号";
        scDetailVC.walletEntity = [WalletArray objectAtIndex:indexPath.row];
        [self.navigationController pushViewController:scDetailVC animated:YES];
    }else{
        SCBoundingWalletViewController *scboundVC = [[SCBoundingWalletViewController alloc]init];
        scboundVC.title =@"翼支付账号";
        [self.navigationController pushViewController:scboundVC animated:YES];
    }
    
}
@end
