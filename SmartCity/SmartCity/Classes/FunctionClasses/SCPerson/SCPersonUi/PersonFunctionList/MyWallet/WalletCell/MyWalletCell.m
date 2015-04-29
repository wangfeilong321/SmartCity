//
//  MyWalletCell.m
//  SmartCity
//
//  Created by fortsven on 15/4/10.
//  Copyright (c) 2015年 sea. All rights reserved.
//

#import "MyWalletCell.h"

@implementation MyWalletCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)showDetail:(UIImage *)image walletDetail:(WalletEntity *)wallet
{
    self.iconImageView.image = image;
    
    NSString *account = wallet.balance;
    
    if (!wallet.accountName.length > 0) {
        self.accountLabel.text = @"添加帐号";
        self.accountLabel.textColor = [UIColor orangeColor];
    }else{
        NSString *showStr = [NSString stringWithFormat:@"余额%.2f元",[account floatValue]];
        NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:showStr];
        [str addAttribute:NSForegroundColorAttributeName
                            value:kLikeOrangeText
                            range:NSMakeRange(2,showStr.length - 3)];
        self.accountLabel.attributedText = str;
    }
}
- (IBAction)receiveCashAction:(id)sender {
}
@end
