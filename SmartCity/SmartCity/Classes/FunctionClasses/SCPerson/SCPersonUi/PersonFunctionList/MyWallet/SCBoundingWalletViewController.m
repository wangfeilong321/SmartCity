//
//  SCBoundingWalletViewController.m
//  SmartCity
//
//  Created by fortsven on 15/4/10.
//  Copyright (c) 2015年 sea. All rights reserved.
//

#import "SCBoundingWalletViewController.h"
#import "NSString+CustomExtensions.h"
#import "SCWebViewController.h"
#import "SCPersonManager.h"


@interface SCBoundingWalletViewController ()<UITextViewDelegate>
{
    UITextView *noteTextView;
    UIWebView *_phoneWebView;
    MBProgressHUD       *hud;
}
@end

@implementation SCBoundingWalletViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self initUI];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -画面初始化
-(void)initUI
{
    CALayer * layer = [self.infoView layer];
    layer.borderWidth = 0.25;
    layer.borderColor =  [[UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1.0] CGColor];
    self.infoView.layer.masksToBounds = YES;
    for (int i = 1; i < 3; i++) {
        UIView *separateLine = [[UIView alloc]initWithFrame:CGRectMake(0, i * 44, [self.view bounds].size.width, 0.5)];
        separateLine.backgroundColor =  [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1.0];
        [self.infoView addSubview:separateLine];
    }
    
    CGRect noteRect = CGRectMake(15, self.boundingButton.frame.origin.y + self.boundingButton.frame.size.height + 20, self.view.bounds.size.width - 30, self.view.bounds.size.height -(self.boundingButton.frame.origin.y + self.boundingButton.frame.size.height + 20));
    noteTextView                    = [[UITextView alloc] initWithFrame:noteRect];
    noteTextView.editable           = NO;
    noteTextView.selectable         = YES;
    noteTextView.backgroundColor    = [UIColor clearColor];
    noteTextView.textColor          = [UIColor colorWithRed:0.36 green:0.36 blue:0.37 alpha:1];
    noteTextView.font               = [UIFont boldSystemFontOfSize:17.0];
    noteTextView.delegate           = self;
    noteTextView.userInteractionEnabled = YES;
    noteTextView.showsHorizontalScrollIndicator = NO;
    noteTextView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:noteTextView];
    NSString *noteStr = @"服务声明:\r\n翼支付相关服务由天翼电子商务有限公司（www.bestpay.com.cn）提供，若使用过程中有任何疑问，请联系4008-0-11888";
    
//    UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tappedTextView:)];
//    [noteTextView addGestureRecognizer:tapRecognizer];

    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:noteStr];
    [str addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:14.0] range:NSMakeRange(0, str.length)];
    [str addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:0.36 green:0.36 blue:0.37 alpha:1] range:NSMakeRange(0, str.length)];
    
    [str addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:0.184 green:0.369 blue:0.647 alpha:1.000] range:NSMakeRange(26, 18)];
    
    [str addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:0.184 green:0.369 blue:0.647 alpha:1.000] range:NSMakeRange(str.length - 12, 12)];
    
    [str addAttribute:NSLinkAttributeName value:@"http://www.bestpay.com.cn" range:NSMakeRange(26, 18)];
    [str addAttribute:NSLinkAttributeName value:@"4008-0-11888" range:NSMakeRange(str.length - 12, 12)];

    
    noteTextView.attributedText = str;
    
    self.accountLabel.text = _userEntity.mobile;
    self.nameLabel.text = _userEntity.username;
    
    NSString *idNum = _userEntity.idNumber;
    NSString *showNumber = [NSString hideSomeStr:idNum origin:2 length:11];
    self.IDnumberLabel.text = showNumber;

}

#pragma mark -UITextViewDelegate
-(BOOL)textView:(UITextView *)textView shouldInteractWithURL:(NSURL *)URL inRange:(NSRange)characterRange
{

    if (!URL || [[URL absoluteString]isEqualToString:@""]){
        DLog(@"#### URL Miss...");
        return NO;
    }
    
    if ([[URL absoluteString] isEqual:@"http://www.bestpay.com.cn"]) {
        SCWebViewController *webViewController = [[SCWebViewController alloc] init];
        
        webViewController.edgesForExtendedLayout = UIRectEdgeNone;
        webViewController.extendedLayoutIncludesOpaqueBars = YES;
        
        
        webViewController.title = @"翼支付相关服务";
        
        NSURLRequest *request = [NSURLRequest requestWithURL:URL];
        
        [webViewController loadRequest:request];
        [self.navigationController pushViewController:webViewController animated:YES];

    }else{
        NSString *phoneNumber = [@"tel://" stringByAppendingString:[URL absoluteString]];
        if (!_phoneWebView) {
            _phoneWebView = [[UIWebView alloc] init];
        }
        
        [_phoneWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:phoneNumber]]];
    }
       return NO;

}

#pragma mark -按钮点击事件
- (IBAction)boundingButtonClick:(id)sender {
    NSDictionary *paramsDic = [NSDictionary dictionaryWithObjectsAndKeys:_userEntity.mobile,@"bandingAccount",
                               _userEntity.username, @"accountName",
                               _userEntity.idNumber, @"idnumber",
                               _userEntity.uid,@"userId",
                               @"0",@"isOpen",
                               nil];
    [SCPersonManager execute:@selector(boundingYzf) target:self callback:@selector(boundingYzfCallBack:) args:paramsDic,nil];
}

-(void)boundingYzfCallBack:(NSData *)data
{
    NSDictionary *resultDic = (NSDictionary *)data;
    if ([[resultDic objectForKey:@"bandingAccount"] length] > 0) {
        [self showHud:@"绑定成功！" afterDelay:1.0];
        [self.navigationController popViewControllerAnimated:YES];
    }else{
        [self showHud:@"绑定失败，\n请稍候再试" afterDelay:1.0];
    }
}


-(void)showHud: (NSString *)alertStr afterDelay:(NSTimeInterval)delay
{
    hud = [[MBProgressHUD alloc] initWithView:self.view];
    hud.mode = MBProgressHUDModeText;
    hud.labelText = alertStr;
    [hud show:YES];
    [hud hide:YES afterDelay:delay];
    [[[UIApplication sharedApplication] keyWindow] addSubview:hud];
    hud = nil;
}
@end
