//
//  MyWalletCell.h
//  SmartCity
//
//  Created by fortsven on 15/4/10.
//  Copyright (c) 2015年 sea. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WalletEntity.h"

@interface MyWalletCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *accountLabel;
@property (strong, nonatomic) IBOutlet UIButton *receiveCashButton;

-(void)showDetail:(UIImage *)image walletDetail:(WalletEntity *)wallet;
@end
