//
//  SCWalletDetailViewController.h
//  SmartCity
//
//  Created by fortsven on 15/4/10.
//  Copyright (c) 2015年 sea. All rights reserved.
//

#import "SCBaseViewController.h"
#import "WalletEntity.h"

@interface SCWalletDetailViewController : SCBaseViewController
@property (strong, nonatomic) IBOutlet UIView *tableHeaderView;
@property (weak, nonatomic) IBOutlet UIImageView *headerIconImageView;
@property (weak, nonatomic) IBOutlet UILabel *userNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *accountLabel;
@property (weak, nonatomic) IBOutlet UILabel *IDNumberlabel;
@property (weak, nonatomic) IBOutlet UITableView *epaytable;

@property (strong, nonatomic)WalletEntity *walletEntity;

@end
