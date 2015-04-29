//
//  NodataView.m
//  SmartCity
//
//  Created by fortsven on 15/4/18.
//  Copyright (c) 2015年 sea. All rights reserved.
//

#import "NodataView.h"

@implementation NodataView

-(id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self loadView];
    }
    return self;
}


-(void)loadView
{
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake([self frame].size.width/2 - 50, 100, 100, 67)];
    imageView.image = [UIImage imageNamed:@"wu"];
    [self addSubview:imageView];
    
    UILabel *resultlabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 167, self.frame.size.width, 30)];
    resultlabel.text = @"暂无数据";
    resultlabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:resultlabel];
    
    UILabel *remindlabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 207, self.frame.size.width, 30)];
    remindlabel.textAlignment = NSTextAlignmentCenter;
    if(self.remindText.length > 0){
        remindlabel.text = self.remindText;
    }else{
        remindlabel.text = @"没有查询到您的献血纪录";
    }
    remindlabel.textColor = [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1];
    [self addSubview:remindlabel];
    
}
@end
