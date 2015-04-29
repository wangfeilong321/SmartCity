//
//  SCEpayOrderViewController.m
//  SmartCity
//
//  Created by fortsven on 15/4/13.
//  Copyright (c) 2015年 sea. All rights reserved.
//

#import "SCEpayOrderViewController.h"
#import "EpayOrderCell.h"
#import "SCPersonManager.h"

@interface SCEpayOrderViewController ()<UITableViewDataSource, UITableViewDelegate>
{
    UITableView *orderTable;
}
@end

@implementation SCEpayOrderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    orderTable = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) style:UITableViewStyleGrouped];
    
    orderTable.delegate = self;
    orderTable.dataSource =self;
    
    [self.view addSubview:orderTable];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated
{
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:_account,@"bandingAccount", nil];
    [SCPersonManager execute:@selector(queryOrderRecord) target:self callback:@selector(queryOrderRecordCallback:) args:params,nil];
}

-(void)queryOrderRecordCallback:(NSData *)data
{

    
}
#pragma mark -UITableDelegate && UITableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.01;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"EpayOrderCell";
    EpayOrderCell *cell = (EpayOrderCell *)[tableView dequeueReusableCellWithIdentifier:identifier];
    if(cell == nil){
        cell = [[[NSBundle mainBundle]loadNibNamed:@"EpayOrderCell" owner:self options:nil]lastObject];
    }
    
    return cell;
}

@end
