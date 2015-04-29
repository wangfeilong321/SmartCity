//
//  SCPaymentViewController.h
//  SmartCity
//
//  Created by fortsven on 15/4/13.
//  Copyright (c) 2015年 sea. All rights reserved.
//

#import "SCBaseViewController.h"
#import "PayMentEntity.h"

@interface SCPaymentViewController : SCBaseViewController
@property (strong, nonatomic) IBOutlet UIView *infoView;
@property (strong, nonatomic) IBOutlet UIView *payInfoView;
@property (weak, nonatomic) IBOutlet UIButton *payButton;
@property (strong, nonatomic) IBOutlet UIView *payButtonView;
@property (strong, nonatomic) IBOutlet UITableView *payMentTable;
@property (strong, nonatomic) IBOutlet UILabel *companyNameLabel;
@property (strong, nonatomic) IBOutlet UILabel *userName;
@property (strong, nonatomic) IBOutlet UILabel *userAddress;
@property (strong, nonatomic) IBOutlet UILabel *payAccountLabel;

@property (strong, nonatomic) PayMentEntity *payMentEntity;


@end
