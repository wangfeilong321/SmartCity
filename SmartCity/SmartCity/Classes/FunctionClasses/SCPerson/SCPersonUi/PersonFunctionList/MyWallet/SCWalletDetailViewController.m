//
//  SCWalletDetailViewController.m
//  SmartCity
//
//  Created by fortsven on 15/4/10.
//  Copyright (c) 2015年 sea. All rights reserved.
//

#import "SCWalletDetailViewController.h"
#import "SCEpayCell.h"
#import "SCEpayOrderViewController.h"
#import "SCPayWebViewController.h"
#import "SCPersonManager.h"

#define funcArr @[@"交易查询",@"重置支付密码",@"优惠活动"]

@interface SCWalletDetailViewController ()<UITableViewDataSource, UITableViewDelegate,SCEpayDelegate>

@end

@implementation SCWalletDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(110, 15, 0.5, 50)];
    lineView.backgroundColor = [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1.0];
    [self.tableHeaderView addSubview:lineView];
    
    self.epaytable.tableHeaderView = self.tableHeaderView;
    
    self.epaytable.delegate = self;
    self.epaytable.dataSource = self;
    
    self.userNameLabel.text = _userEntity.username;
    self.accountLabel.text = [NSString stringWithFormat:@"手机号：%@", _walletEntity.bindingAccount ];
    self.IDNumberlabel.text = [NSString stringWithFormat:@"身份证：%@", _walletEntity.owner ];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 4;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.section) {
        case 0:
        {
           if(indexPath.row == 0) {
                static NSString *identifier = @"SCEpayCell";
                SCEpayCell *cell = (SCEpayCell *)[tableView dequeueReusableCellWithIdentifier:identifier];
                if (cell == nil) {
                    cell = [[[NSBundle mainBundle]loadNibNamed:@"SCEpayCell" owner:self options:nil]lastObject];
                }
                cell.epayAccountlabel.text = self.walletEntity.balance;
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                cell.payButtonClickDelegate =self;
                return cell;
           }else{
                static NSString *identifier = @"UITableViewCell";
                UITableViewCell *cell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:identifier];
                if (cell == nil) {
                    cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
                }
                
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                cell.textLabel.text = [funcArr objectAtIndex:indexPath.row - 1];
                cell.textLabel.font = [UIFont boldSystemFontOfSize:16];
               if (indexPath.row == 4) {
                   cell.imageView.image = [UIImage imageNamed:@"SCR_share_icon"];
               }
                return cell;
           }
        }
    }
    
    return nil;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        if (indexPath.row == 1) {
            SCEpayOrderViewController *scepayVC = [[SCEpayOrderViewController alloc]init];
            scepayVC.title =@"交易查询";
            scepayVC.account =_walletEntity.bindingAccount;
            [self.navigationController pushViewController:scepayVC animated:YES];
        }
    }
}

#pragma mark -支付按钮点击事件
-(void)payClick
{
//    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:_walletEntity.bindingAccount,@"mobile",@"1",@"amount",@"www.baidu.com",@"jumpUrl", nil];
//    [SCPersonManager execute:@selector(rechargeYzf) target:self callback:@selector(rechargeYzfCallBack:) args:params,nil];
//    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [self rechargeYzf];
}

-(void)rechargeYzfCallBack:(NSData *)data
{
//    SCPayWebViewController *scPayWebVC = [[SCPayWebViewController alloc]init];
//    [self.navigationController pushViewController:scPayWebVC animated:YES];
}

-(void)rechargeYzf
{
    NSString *urlStr = [NSString stringWithFormat:@"http://10.101.2.14:8080/znmh_FEP/jsp/epay/rechargeJump.jsp?mobile=%@&amount=1&jumpUrl=http://www.baidu.com",_walletEntity.bindingAccount];
    
    NSURL *url = [NSURL URLWithString:urlStr];
    NSURLRequest *request = [[NSURLRequest alloc]initWithURL:url
                                                 cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10];
    
    NSData *receiveData = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    
    if (receiveData != nil) {
        NSString *string = [[NSString alloc]initWithData:receiveData encoding:NSUTF8StringEncoding];
        
        SCPayWebViewController *scPayWebVC = [[SCPayWebViewController alloc]init];
        
        scPayWebVC.edgesForExtendedLayout = UIRectEdgeNone;
        scPayWebVC.extendedLayoutIncludesOpaqueBars = YES;
        
        [scPayWebVC loadHTMLString:string];
        scPayWebVC.title = @"充值界面";
        
        [self.navigationController pushViewController:scPayWebVC animated:YES];
    }
}
@end
