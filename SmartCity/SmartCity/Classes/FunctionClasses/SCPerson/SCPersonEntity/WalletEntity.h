//
//  WalletEntity.h
//  SmartCity
//
//  Created by fortsven on 15/4/10.
//  Copyright (c) 2015年 sea. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WalletEntity : NSObject
@property (nonatomic, retain)NSString *accountName;     //翼支付账号名称
@property (nonatomic, retain)NSString *availablecash;   //提现金额
@property (nonatomic, retain)NSString *balance;         //余额
@property (nonatomic, retain)NSString *bindingAccount;  //账号
@property (nonatomic, retain)NSString *bindingId;       //绑定ID
@property (nonatomic, retain)NSString *owner;           //身份证号
@property (nonatomic, retain)NSString *bindingType;     //绑定类型 8为翼支付
@property (nonatomic, retain)NSString *isOpen;          //是否开通翼支付 0为已开通 其余为未开通

-(void)initwithDic:(NSDictionary *)dic;
@end
