//
//  EpayOrderEntity.h
//  SmartCity
//
//  Created by fortsven on 15/4/17.
//  Copyright (c) 2015年 sea. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EpayOrderEntity : NSObject
@property (nonatomic, retain)NSString *acceptSeqNo;     //订单号
@property (nonatomic, retain)NSString *acceptTime;      //受理时间
@property (nonatomic, retain)NSString *merchantName;    //商户名称
@property (nonatomic, retain)NSString *txnAmount;       //交易金额
@property (nonatomic, retain)NSString *txnChannel;      //交易渠道
@property (nonatomic, retain)NSString *txnDscpt;        //交易描述
@property (nonatomic, retain)NSString *txnType;         //交易类型
@end

@interface PayInfoEntity : NSObject
@property (nonatomic, retain)NSString *retStatus;           //绑定状态：0 成功 1 失败
@property (nonatomic, retain)NSString *retMessage;          //返回信息
@property (nonatomic, retain)NSString *feeMoney;            //欠费余额
@property (nonatomic, retain)NSString *orderId;             //订单号
@property (nonatomic, retain)NSString *agentAccNbr;         //翼支付账号
@property (nonatomic, retain)NSString *totalbalance;        //余额
@property (nonatomic, retain)NSString *moneybalance;        //可提现现金

@end
