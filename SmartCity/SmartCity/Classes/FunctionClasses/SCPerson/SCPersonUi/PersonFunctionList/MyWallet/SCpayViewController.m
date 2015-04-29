//
//  SCpayViewController.m
//  SmartCity
//
//  Created by fortsven on 15/4/14.
//  Copyright (c) 2015年 sea. All rights reserved.
//

#import "SCpayViewController.h"
#import "SCPersonManager.h"
#import "EpayOrderEntity.h"

@interface SCpayViewController ()<UITableViewDataSource, UITableViewDelegate,UIAlertViewDelegate>

@end

@implementation SCpayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:_payMentEntity.pay_Num,@"account",
                         _payMentEntity.pay_agentCode,@"agentCode",
                         _payMentEntity.pay_transCode,@"transCode",
                         _userEntity.mobile,@"agentAccNbr",nil];
    [SCPersonManager execute:@selector(queryPayInfo) target:self callback:@selector(payInfoCallBack:) args:dic, nil];
    [self initUI];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)payInfoCallBack:(NSData *)data
{
    PayInfoEntity *infoEntity = (PayInfoEntity *)data;
    _orderNumLabel.text = [NSString stringWithFormat:@"订单号：%@", infoEntity.orderId ];
    _orderAccountlabel.text = infoEntity.feeMoney;
    _epayNumLabel.text = [NSString stringWithFormat:@"余额支付 [%@]", infoEntity.agentAccNbr];
    _balanceLabel.text = [NSString stringWithFormat:@"余额%.2f元 [可提现%.2f元]",[infoEntity.totalbalance floatValue],[infoEntity.moneybalance floatValue]];
    
}
#pragma mark -初始化UI
-(void)initUI
{
    //添加分割线
    UIView *seperateLine =[[UIView alloc]initWithFrame:CGRectMake(0, self.orderInfoView.frame.size.height - 0.25, self.orderInfoView.frame.size.width, 0.25)];
    seperateLine.backgroundColor = [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1.0];
    [self.orderInfoView addSubview:seperateLine];
    
    UIView *seperateLine1 =[[UIView alloc]initWithFrame:CGRectMake(0, 0, self.orderInfoView.frame.size.width, 0.5)];
    seperateLine1.backgroundColor = [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1.0];
    [self.payView addSubview:seperateLine1];
    
    UIView *seperateLine2 =[[UIView alloc]initWithFrame:CGRectMake(0, self.payView.frame.size.height - 0.5, self.orderInfoView.frame.size.width, 0.25)];
    seperateLine2.backgroundColor = [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1.0];
    [self.payView addSubview:seperateLine2];
    
    UIView *seperateLine3 =[[UIView alloc]initWithFrame:CGRectMake(15, 87.5, self.orderInfoView.frame.size.width - 15, 0.25)];
    seperateLine3.backgroundColor = [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1.0];
    [self.payView addSubview:seperateLine3];
    
    self.table.delegate= self;
    self.table.dataSource = self;
    
    self.table.tableFooterView = self.payButtonView;

}

#pragma mark -UITableDelegate && UITableDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 0;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return 95;
    }else{
        return 132;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 20;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 0;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return self.orderInfoView;
    }else{
        return self.payView;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return nil;
}

#pragma mark -UIButtonClicked
- (IBAction)forgetPassButtonClicked:(id)sender {
    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"系统提示" message:@"将为您重置支付密码，新的密码将发送到您的手机，是否重置？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"重置", nil];
    [alertView show];
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1) {
        
    }
}
@end
