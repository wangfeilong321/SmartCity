//
//  SCBloodDonationViewController.m
//  SmartCity
//
//  Created by fortsven on 15/4/18.
//  Copyright (c) 2015年 sea. All rights reserved.
//

#import "SCBloodDonationViewController.h"
#import "BloodDonationCell.h"
#import "SCPublicManager.h"
#import "NodataView.h"

@interface SCBloodDonationViewController ()<UITableViewDataSource, UITableViewDelegate>
{
    UITableView *bloodDonationtable;
    NSMutableArray *bloodRecordArr;
    UIView *tableHeaderView;
    
    UILabel *namelabel;
    UILabel *idCardlabel;
    UILabel *bloodGrouplabel;
}
@end

@implementation SCBloodDonationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    bloodRecordArr = [[NSMutableArray alloc]initWithCapacity:0];
    
    [self initView];
    
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:_userEntity.idNumber, @"idnumber",_userEntity.username,@"name", nil];
    [SCPublicManager execute:@selector(queryBloodHistory) target:self callback:@selector(queryBloodHistoryCallBack:) args:dic,nil];
}

-(void)initView
{
    bloodDonationtable = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    bloodDonationtable.delegate = self;
    bloodDonationtable.dataSource = self;
    
    tableHeaderView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 132)];
    tableHeaderView.backgroundColor = [UIColor whiteColor];
    
    UILabel *name = [[UILabel alloc]initWithFrame:CGRectMake(15, 0, 60, 44)];
    name.text = @"姓名";
    name.textColor = [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1];
    [tableHeaderView addSubview:name];
    
    UILabel *idNum = [[UILabel alloc]initWithFrame:CGRectMake(15, 44, 60, 44)];
    idNum.text = @"身份证";
    idNum.textColor = [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1];
    [tableHeaderView addSubview:idNum];
    
    UILabel *bloodGroup = [[UILabel alloc]initWithFrame:CGRectMake(15, 88, 60, 44)];
    bloodGroup.text = @"姓名";
    bloodGroup.textColor = [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1];
    [tableHeaderView addSubview:bloodGroup];
    
    namelabel = [[UILabel alloc]initWithFrame:CGRectMake(75, 0, self.view.frame.size.width - 90, 44)];
    namelabel.textColor = [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1];
    [tableHeaderView addSubview:namelabel];
    
    idCardlabel = [[UILabel alloc]initWithFrame:CGRectMake(75, 44, self.view.frame.size.width - 90, 44)];
    idCardlabel.textColor = [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1];
    [tableHeaderView addSubview:idCardlabel];
    
    bloodGrouplabel = [[UILabel alloc]initWithFrame:CGRectMake(75, 88, self.view.frame.size.width - 90, 44)];
    bloodGrouplabel.textColor = [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1];
    [tableHeaderView addSubview:bloodGrouplabel];
    
    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, tableHeaderView.frame.size.height - 0.5, tableHeaderView.frame.size.width, 0.5)];
    lineView.backgroundColor = [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1];
    [tableHeaderView addSubview:lineView];
    
    bloodDonationtable.tableHeaderView = tableHeaderView;
    
    
}

-(void)queryBloodHistoryCallBack:(NSData *)data
{
    NSDictionary *resultDic = nil;
    resultDic = (NSDictionary *)data;
    
    NSDictionary *bodyInfoDic = [resultDic objectForKey:@"body"];
    NSDictionary *headerinfoDic = [resultDic objectForKey:@"header"];
    
    if ([[headerinfoDic objectForKey:@"retStatus"]isEqual:@"0"] && [[bodyInfoDic objectForKey:@"status"] isEqual:@"1"]){
        
        namelabel.text = [bodyInfoDic objectForKey:@"name"];
        idCardlabel.text = [bodyInfoDic objectForKey:@"identityId"];
        
        bloodGrouplabel.text = [bodyInfoDic objectForKey:@"bloodgroup"];
        
        [bloodRecordArr addObjectsFromArray:[bodyInfoDic objectForKey:@"collections"]];
        [self.view addSubview:bloodDonationtable];
        [bloodDonationtable reloadData];
        
    }else{

        NodataView *nodataView = [[NodataView alloc]initWithFrame:self.view.frame];
        [self.view addSubview:nodataView];
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDelegate && UITableDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return bloodRecordArr.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 40;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *sectionHeaderView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 40)];
    
    UILabel *bloodAccountLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, sectionHeaderView.frame.size.width/2, 40)];
    bloodAccountLabel.textColor = [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1];
    bloodAccountLabel.text = @"献血量";
    bloodAccountLabel.textAlignment = NSTextAlignmentCenter;
    bloodAccountLabel.font = [UIFont systemFontOfSize:14.f];
    [sectionHeaderView addSubview:bloodAccountLabel];
    
    UILabel *timeLabel = [[UILabel alloc]initWithFrame:CGRectMake(sectionHeaderView.frame.size.width/2, 0, sectionHeaderView.frame.size.width/2, 40)];
    timeLabel.textColor = [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1];
    timeLabel.text = @"时间";
    timeLabel.font = [UIFont systemFontOfSize:14.f];
    timeLabel.textAlignment = NSTextAlignmentCenter;
    [sectionHeaderView addSubview:timeLabel];
    
    return sectionHeaderView;

}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"BloodDonationCell";
    BloodDonationCell *cell = (BloodDonationCell *)[tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell== nil) {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"BloodDonationCell" owner:self options:nil] lastObject];
    }
    cell.accountLabel.text = [[bloodRecordArr objectAtIndex:indexPath.row] objectForKey:@"colBlood"];
    cell.timeLabel.text = [[bloodRecordArr objectAtIndex:indexPath.row] objectForKey:@"colTime"];
    return cell;
}
@end
