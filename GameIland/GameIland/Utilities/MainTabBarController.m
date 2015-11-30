//
//  MainTabBarController.m
//  GameIland
//
//  Created by Air on 15/8/10.
//  Copyright (c) 2015年 Air. All rights reserved.
//

#import "MainTabBarController.h"
#import "SalesViewController.h"
#import "FightViewController.h"
#import "ConfigViewController.h"
#import "SaveViewController.h"
#import "NewsViewController.h"
@interface MainTabBarController ()


@end

@implementation MainTabBarController

-(void)createSubViewControllers
{
    //栏目
    _fight = [[FightViewController alloc] init];
    UINavigationController * fightNav = [[UINavigationController alloc] initWithRootViewController:_fight];
    fightNav.navigationBar.hidden = YES;
//    //买卖
//    SalesViewController * sale = [[SalesViewController alloc] init];
//    UINavigationController * saleNav = [[UINavigationController alloc] initWithRootViewController:sale];
//    saleNav.navigationBar.hidden = YES;
//    //设
//    ConfigViewController * config = [[ConfigViewController alloc] init];
//    UINavigationController * configNav = [[UINavigationController alloc] initWithRootViewController:config];
//    configNav.navigationBar.hidden = YES;
    //视频
    SaveViewController * save = [[SaveViewController alloc] init];
    UINavigationController * saveNav = [[UINavigationController alloc] initWithRootViewController:save];
    saveNav.navigationBar.hidden = YES;
    //新闻
    NewsViewController * news = [[NewsViewController alloc]init];
    UINavigationController * newsNav = [[UINavigationController alloc] initWithRootViewController:news];
    newsNav.navigationBar.hidden = YES;
 

    //装入controllers
    self.viewControllers =  @[newsNav,fightNav,saveNav];
}

-(void)setTabBarItems{
    //文字
    NSArray * titleArr = @[@"游戏资讯", @"栏目", @"我的收藏", @"买卖", @"设置"];
    //图片数组
    NSArray * normalArr = @[@"新闻1", @"攻略1", @"我的收藏1", @"买卖1", @"设置1"];
    NSArray * selectArr = @[@"新闻", @"攻略", @"我的收藏", @"买卖", @"设置"];
    // 循环设置tabbarItem的文字，图片
    for (int i = 0 ; i < 3; i ++) {
        UIViewController *vc = self.viewControllers[i];
        vc.tabBarItem = [[UITabBarItem alloc] init];
        vc.tabBarItem.title = titleArr[i];
        vc.tabBarItem.image = [[UIImage imageNamed:normalArr[i]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        vc.tabBarItem.selectedImage = [[UIImage imageNamed:selectArr[i]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    }
    // 设置tabbar背景图片
    self.tabBar.backgroundImage = [UIImage imageNamed:@"tabbar@2x"];
    // 设置tabbarItem被选中时文字颜色
    [[UITabBarItem appearance] setTitleTextAttributes:@{
                                                        NSForegroundColorAttributeName : [UIColor whiteColor]
                                                        } forState:UIControlStateSelected];
    
    // 获取应用导航条最高权限
    [[UINavigationBar appearance] setTitleTextAttributes:@{NSFontAttributeName : [UIFont systemFontOfSize:20.0f]}
     ];
    


}

- (void)viewDidLoad {
    [super viewDidLoad];
    // 创建子控制器
    [self createSubViewControllers];
    
    // 设置所有分栏元素项
    [self setTabBarItems];
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
