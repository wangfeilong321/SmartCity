//
//  SCpayViewController.h
//  SmartCity
//
//  Created by fortsven on 15/4/14.
//  Copyright (c) 2015年 sea. All rights reserved.
//

#import "SCBaseViewController.h"
#import "PayMentEntity.h"

@interface SCpayViewController : SCBaseViewController
@property (strong, nonatomic) IBOutlet UIView *payView;
@property (strong, nonatomic) IBOutlet UIView *orderInfoView;
@property (strong, nonatomic) IBOutlet UITableView *table;
@property (strong, nonatomic) IBOutlet UIView *payButtonView;
@property (strong, nonatomic) IBOutlet UIButton *payButton;

@property (strong, nonatomic) PayMentEntity *payMentEntity;
@property (strong, nonatomic) IBOutlet UILabel *orderNumLabel;
@property (strong, nonatomic) IBOutlet UILabel *orderAccountlabel;
@property (strong, nonatomic) IBOutlet UILabel *epayNumLabel;
@property (strong, nonatomic) IBOutlet UILabel *balanceLabel;
@property (strong, nonatomic) IBOutlet UITextField *epayPassText;

@end
