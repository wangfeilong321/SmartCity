//
//  SCEpayCell.h
//  SmartCity
//
//  Created by fortsven on 15/4/13.
//  Copyright (c) 2015年 sea. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol SCEpayDelegate <NSObject>
-(void)payClick;
@end

@interface SCEpayCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *epayAccountlabel;
@property (nonatomic, assign) id<SCEpayDelegate>payButtonClickDelegate;
@end
