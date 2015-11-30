//
//  RootViewController.m
//  GameIland
//
//  Created by Air on 15/8/10.
//  Copyright (c) 2015年 Air. All rights reserved.
//

#import "RootViewController.h"
#import "DetailViewController.h"
#import "ConfigViewController.h"

@interface RootViewController ()


@end

@implementation RootViewController
-(void)createTabBar
{
    _tabbarView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 64)];
    _tabbarView.image =  [UIImage imageNamed:@"tabbar@2x"];
    [self.view addSubview:_tabbarView];
    _tabbarView.userInteractionEnabled = YES;
    [_tabbarView bringSubviewToFront:self.view];

}



- (void)viewDidLoad {
    [super viewDidLoad];
    //创建tabbar
    [self createTabBar];
    //网络监测开启
    [self chectNetWorking];
}

-(void)chectNetWorking
{
    //创建网络监测
    AFNetworkReachabilityManager * manager = [AFNetworkReachabilityManager sharedManager];
    //开始监测
    [manager startMonitoring];
    //设置返回block
    [manager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
            switch (status) {
                case AFNetworkReachabilityStatusNotReachable: // 没有网络
                    // 存储是否有网
                    [Helper setBool:NO forKey:LFIsNetWorking];
                    [self createUI];
                    break;
                case AFNetworkReachabilityStatusUnknown: // 未知网络
                    [Helper setBool:YES forKey:LFIsNetWorking];
                    [self createUI];
                    break;
                case AFNetworkReachabilityStatusReachableViaWiFi: // Wifi网络
                    [Helper setBool:YES forKey:LFIsNetWorking];
                    [self createUI];
                    break;
                case AFNetworkReachabilityStatusReachableViaWWAN: // 3/4G网络
                    [Helper setBool:YES forKey:LFIsNetWorking];
                    [self createUI];
                    break;
                    
                default:
                    break;
            }

    }];
}

-(void)createUI
{
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
