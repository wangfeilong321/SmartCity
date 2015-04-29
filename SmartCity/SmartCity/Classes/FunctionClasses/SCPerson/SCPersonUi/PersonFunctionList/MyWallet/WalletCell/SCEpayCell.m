//
//  SCEpayCell.m
//  SmartCity
//
//  Created by fortsven on 15/4/13.
//  Copyright (c) 2015年 sea. All rights reserved.
//

#import "SCEpayCell.h"

@implementation SCEpayCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (IBAction)payButtonClicked:(id)sender {
    [self.payButtonClickDelegate payClick];
}

@end
