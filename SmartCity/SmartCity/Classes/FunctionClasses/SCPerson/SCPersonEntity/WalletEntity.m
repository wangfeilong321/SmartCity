//
//  WalletEntity.m
//  SmartCity
//
//  Created by fortsven on 15/4/10.
//  Copyright (c) 2015年 sea. All rights reserved.
//

#import "WalletEntity.h"

@implementation WalletEntity

-(void)initwithDic:(NSDictionary *)dic
{
    _accountName = [dic objectForKey:@"accountName"];
    _availablecash = [dic objectForKey:@"availablecash"];
    _balance = [dic objectForKey:@"balance"];
    _bindingAccount = [dic objectForKey:@"bindingAccount"];
    _bindingId = [dic objectForKey:@"bindingId"];
    _owner = [dic objectForKey:@"owner"];
    _bindingType = [dic objectForKey:@"bindingType"];
    _isOpen = [dic objectForKey:@"isOpen"];
}


@end
