//
//  NewsDetailController.m
//  GameIland
//
//  Created by Air on 15/8/11.
//  Copyright (c) 2015年 Air. All rights reserved.
//

#import "NewsDetailController.h"
#import "NewsViewController.h"
#import "DBManager.h"
#import "UMSocial.h"
@interface NewsDetailController ()<UIWebViewDelegate>

{
    UIButton * _btn;
    UIButton * _saveBtn;
    UIImageView * _tabbarView;
    UIButton * _share;
    BOOL isInData;
}
@end

@implementation NewsDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    //创建uiwebView
    [self createDetailWebViewWithUrl];
}

-(void)createDetailWebViewWithUrl
{
    _webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, -36, kScreenWidth, kScreenHeight+64)];
    _webView.delegate = self;
    _tabbarView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 64)];
    _tabbarView.image =  [UIImage imageNamed:@"tabbar@2x"];
    _saveUrlBlock(_url);
    _webView.scalesPageToFit = YES;
    [self.view addSubview:_webView];
    [self.view addSubview:_tabbarView];
    //添加返回顶部按键
    [self addTopBtn];
    UIButton * btn = [Helper addNavBtnWithFrame:CGRectMake(10, 24, 30, 30) withTitle:nil withIconName:@"返回@2x"];
    [btn addTarget:self action:@selector(back:) forControlEvents:UIControlEventTouchUpInside];
    //添加收藏
    _saveBtn = [Helper addNavBtnWithFrame:CGRectMake(kScreenWidth-40,24, 30, 30) withTitle:nil withIconName:@"未收藏@2x"];
    [_saveBtn addTarget:self action:@selector(saveModel) forControlEvents:UIControlEventTouchUpInside];
    isInData = [[DBManager shareManager] searchDataWithAppID:_model];
    //判断 是否已经已经收藏
    if (isInData == YES) {
        [_saveBtn setBackgroundImage:[UIImage imageNamed:@"收藏@2x"] forState:UIControlStateNormal];
    }else if (isInData == NO)
    {
        [_saveBtn setBackgroundImage:[UIImage imageNamed:@"未收藏@2x"] forState:UIControlStateNormal];
    }
    [_saveBtn addTarget:self action:@selector(saveModel) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_saveBtn];
    [self.view addSubview:btn];
    [self.view addSubview:_saveBtn];
    //添加分享按钮
    _share = [Helper addNavBtnWithFrame:CGRectMake(kScreenWidth-40-100,24, 80, 30) withTitle:@"分享" withIconName:nil];
    [_share addTarget:self action:@selector(share) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_share];
}

#pragma mark 我的收藏点击事件
-(void)saveModel
{    if (isInData == NO) {
    isInData  = YES;
    [_saveBtn setBackgroundImage:[UIImage imageNamed:@"收藏@2x"] forState:UIControlStateNormal];
    [[DBManager shareManager] insertDataWithModel:_model];
}else if (isInData == YES)
{
    isInData  = NO;
    [_saveBtn setBackgroundImage:[UIImage imageNamed:@"未收藏@2x"] forState:UIControlStateNormal];
    [[DBManager shareManager] deleteDataWithModel:_model];
}
    
}

-(void)back:(UIButton *)btn
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

-(void)addTopBtn
{
    _btn = [UIButton buttonWithType:UIButtonTypeCustom];
    _btn.frame = CGRectMake(kScreenWidth-50, kScreenHeight-64-44, 50, 50);
    [_btn setBackgroundImage:[UIImage imageNamed:@"向上箭头@2x"] forState:UIControlStateNormal];
    [_btn addTarget:self action:@selector(backTop:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_btn];
}

-(void)backTop:(UIButton *)btn
{
    [_webView.scrollView setContentOffset:CGPointMake(0, 0)];
}

#pragma mark 点击分享
-(void)share
{
    UIImageView * iv = [[UIImageView alloc]init];
    [iv setImageWithURL:_model.iconUrl];
    
    [UMSocialSnsService presentSnsIconSheetView:self
                                         appKey:@"55eb107567e58e951a00949a"
                                      shareText:[NSString stringWithFormat:@"新鲜资讯一手把握_%@%@",_model.titleLabel.text,_model.urlStr]
                                     shareImage:iv.image
                                shareToSnsNames:[NSArray arrayWithObjects:UMShareToSina,UMShareToTencent,UMShareToRenren,UMShareToDouban,nil]
                                       delegate:self];
}


#pragma mark UIWebView--delegate
-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    return YES;
}

-(void)webViewDidStartLoad:(UIWebView *)webView
{
    [Helper showHudToView:_webView text:@"正在加载中"];
}

-(void)webViewDidFinishLoad:(UIWebView *)webView
{
    [Helper hideHudFromView:_webView];
}





@end
