//
//  PayMentEntity.h
//  SmartCity
//
//  Created by fortsven on 15/4/14.
//  Copyright (c) 2015年 sea. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PayMentEntity : NSObject
@property (nonatomic, retain)NSString *pay_companyName; //支付公司
@property (nonatomic, retain)NSString *pay_Num;         //支付账号
@property (nonatomic, retain)NSString *pay_Account;     //支付金额
@property (nonatomic, retain)NSString *pay_address;     //支付地址
@property (nonatomic, retain)NSString *pay_name;        //支付姓名
@property (nonatomic, retain)NSString *pay_agentCode;   //县级代码
@property (nonatomic, retain)NSString *pay_transCode;   //业务代码
@property (nonatomic, retain)NSString *pay_agentAccNbr; //翼支付账号
@end
