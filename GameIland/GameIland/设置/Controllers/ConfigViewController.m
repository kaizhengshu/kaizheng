//
//  ConfigViewController.m
//  GameIland
//
//  Created by Air on 15/8/10.
//  Copyright (c) 2015年 Air. All rights reserved.
//

#import "ConfigViewController.h"
#import "SaveViewController.h"
@interface ConfigViewController ()
{
    NSArray         *_dataArr;
    UIImageView * _tabbarView;
}
@end

@implementation ConfigViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    _tabbarView = [[UIImageView alloc]initWithFrame:CGRectMake(0, -20, kScreenWidth, 64)];
    _tabbarView.image =  [UIImage imageNamed:@"tabbar@2x"];
    [self.view addSubview:_tabbarView];
    _tabbarView.userInteractionEnabled = YES;
    [_tabbarView bringSubviewToFront:self.view];
    
    //添加返回顶部按键
    UIButton * btn = [Helper addNavBtnWithFrame:CGRectMake(15, 0, 30, 30) withTitle:nil withIconName:@"返回@2x"];
    [btn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    // 设置分割线样式
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    // 初始化数据
    _dataArr = @[@"我的收藏", @"清除缓存", @"当前版本", @"我的信息"];
}

-(void)back
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return _dataArr.count;
}

#pragma mark 填充cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID = @"ID";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:ID];
        // cell的默认高度是44
//        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 44, kScreenWidth, 1)];
//        lineView.backgroundColor = [UIColor orangeColor];
//        [cell.contentView addSubview:lineView];
    }
    
    cell.textLabel.text = _dataArr[indexPath.row];
    
    if (1 == indexPath.row) {
        
        cell.detailTextLabel.text = [Helper calculateCacheSize];
    }
    
    return cell;
}

#pragma mark 点击cell
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (2 == indexPath.row) { // 当前版本
        //  UIAlertView & UIActionSheet
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"当前版本号" message:@"1.0" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
        [alert show];
    } else if (1 == indexPath.row) { // 清除缓存
        [[SDImageCache sharedImageCache] clearDisk];
        LFLog(@"%@", [Helper calculateCacheSize]);
        
        [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (0 ==  indexPath.row) { // 我的收藏
        // 跳转到我的收藏.
        SaveViewController *fvc = [[SaveViewController alloc] init];
        [self.navigationController pushViewController:fvc animated:YES];
    }
}


@end
