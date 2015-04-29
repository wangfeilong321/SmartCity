//
//  SCPaymentViewController.m
//  SmartCity
//
//  Created by fortsven on 15/4/13.
//  Copyright (c) 2015年 sea. All rights reserved.
//

#import "SCPaymentViewController.h"
#import "SCpayViewController.h"

@interface SCPaymentViewController ()<UITableViewDelegate, UITableViewDataSource>

@end

@implementation SCPaymentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.payMentTable.delegate = self;
    self.payMentTable.dataSource  = self;
    
    [self initUI];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)initUI
{
    self.companyNameLabel.text = _payMentEntity.pay_companyName;
    self.userName.text = _userEntity.username;
    self.userAddress.text = _payMentEntity.pay_address;
    
    NSString *str = [NSString stringWithFormat:@"%.2f元",[_payMentEntity.pay_Account floatValue]];
    NSMutableAttributedString *showStr = [[NSMutableAttributedString alloc]initWithString:str];
    [showStr addAttribute:NSForegroundColorAttributeName
                       value:[UIColor orangeColor]
                       range:NSMakeRange(0,showStr.length - 1)];
    self.payAccountLabel.attributedText = showStr;
}

#pragma mark -UITableDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 0;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return 132;
    }else if(section == 1){
        return 44;
    }else{
        return 44;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (section == 0) {
        return 20;
    }else if(section == 1){
        return 20;
    }else{
        return 0.01;
    }
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return self.infoView;
    }else if(section == 1){
        return self.payInfoView;
    }else{
        return self.payButtonView;
    }
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 0;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return nil;
}

#pragma mark -按钮点击事件
- (IBAction)confirmPayButton:(id)sender {
    SCpayViewController *scPayVC = [[SCpayViewController alloc]init];
    scPayVC.title = @"翼支付";
    scPayVC.payMentEntity = _payMentEntity;
    [self.navigationController pushViewController:scPayVC animated:YES];
}

@end
