//
//  FightViewController.m
//  GameIland
//
//  Created by Air on 15/8/10.
//  Copyright (c) 2015年 Air. All rights reserved.
//

#import "FightViewController.h"
#import "XboxOneViewController.h"
#import "PS4ViewController.h"
#import "iOSViewController.h"
#import "AndriodViewController.h"
#import "TowerViewController.h"
#import "StickViewController.h"
#import "DetailViewController.h"

@interface FightViewController ()<UIPageViewControllerDataSource,UIScrollViewDelegate,UIPageViewControllerDelegate>

{
    UIPageViewController * _pageViewController;
    //scrollview标题数组
    NSMutableArray * _titleArr;
    //数据源
    NSMutableArray * _vcArray;
    //标识当前页
    NSInteger _curPage;
    //标题scrollView
    UIScrollView * _titleScrollView;
    //指示当前页
    UIView * _indicatorView;
}

@end

@implementation FightViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //设置导航栏元素相
    [self createNavgationItem];
    
    [self initData];
    
    [self configTitleScrollView];
    
    [self configPageViewController];

}

#pragma mark 创建导航栏元素
-(void)createNavgationItem
{
    UIButton * navBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.view.backgroundColor = [UIColor whiteColor];
    [navBtn setTitle:@"栏目" forState:UIControlStateNormal];
    navBtn.titleLabel.textAlignment = NSTextAlignmentLeft;
    CGFloat navBtnWidth = [Helper widthOfString:navBtn.titleLabel.text font:[UIFont systemFontOfSize:20] height:35];
    navBtn.frame = CGRectMake(kScreenWidth/3.5-navBtnWidth, 20, 200, 35);
    [self.view addSubview:navBtn];
}

#pragma mark 数据源创建
-(void)initData
{
    //将控制器放入数组
    _vcArray = [NSMutableArray array];
    //xbo1
        XboxOneViewController * x1 = [[XboxOneViewController alloc] init];
        x1.pageNum = 1;
        x1.pushBlock = ^(NSURL * url , ColumnModel * model)
        {
            DetailViewController * de = [[DetailViewController alloc] init];
            de.url = url;
            de.model = model;
            [self.navigationController pushViewController:de animated:YES];
        };

    //ps4
        PS4ViewController * ps4 = [[PS4ViewController alloc] init];
        ps4.pageNum = 2;
    ps4.pushBlock = ^(NSURL * url , ColumnModel * model)    {
        DetailViewController * de = [[DetailViewController alloc] init];
        de.url = url;
        de.model = model;
        [self.navigationController pushViewController:de animated:YES];
    };
    //iOS
        iOSViewController * iOS = [[iOSViewController alloc] init];
        iOS.pageNum = 3;
    iOS.pushBlock = ^(NSURL * url , ColumnModel * model)
    {
        DetailViewController * de = [[DetailViewController alloc] init];
        de.url = url;
         de.model = model;
        [self.navigationController pushViewController:de animated:YES];
    };
    //andriod
        AndriodViewController * andriod = [[AndriodViewController alloc] init];
        andriod.pageNum = 4;
    andriod.pushBlock = ^(NSURL * url , ColumnModel * model)
    {
        DetailViewController * de = [[DetailViewController alloc] init];
        de.url = url;
         de.model = model;
        [self.navigationController pushViewController:de animated:YES];
    };
    //塔防
        TowerViewController * tower = [[TowerViewController alloc] init];
        tower.pageNum = 5;
    tower.pushBlock = ^(NSURL * url , ColumnModel * model)    {
        DetailViewController * de = [[DetailViewController alloc] init];
        de.url = url;
         de.model = model;
        [self.navigationController pushViewController:de animated:YES];
    };
    //格斗
        StickViewController* stick = [[StickViewController alloc] init];
    stick.pushBlock = ^(NSURL * url , ColumnModel * model)    {
        DetailViewController * de = [[DetailViewController alloc] init];
        de.url = url;
         de.model = model;
        [self.navigationController pushViewController:de animated:YES];
    };
    
        stick.pageNumber = 6;
        [_vcArray addObject:x1];
        [_vcArray addObject:ps4];
        [_vcArray addObject:iOS];
        [_vcArray addObject:andriod];
        [_vcArray addObject:tower];
        [_vcArray addObject:stick];
    
}

#pragma mark 创建scrollerView
-(void)configTitleScrollView
{
    NSMutableArray * titleArr = @[@"Xbox",@"PS4",@"iOS",@"Android",@"塔防",@"格斗"];
    _titleArr = titleArr;
    _titleScrollView = [[UIScrollView alloc] init];
    _titleScrollView.frame = CGRectMake(0, 64, kScreenWidth, 40);
    //循环添加
    for (int i = 0; i<_titleArr.count; i++)
    {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(i*100, 0, 100, 20);
        btn.backgroundColor = [UIColor grayColor];
        [btn setTitle:_titleArr[i] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        btn.tag = 100+i;
        [_titleScrollView addSubview:btn];
    }
    _titleScrollView.contentSize = CGSizeMake(100*_titleArr.count, 0);
    [self.view addSubview:_titleScrollView];
    //添加指示背景
    _indicatorView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 100, 20)];
    _indicatorView.backgroundColor = [UIColor redColor];
    _indicatorView.alpha = 0.1;
    [_titleScrollView addSubview:_indicatorView];

}

-(void)configPageViewController
{
    _pageViewController = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:nil];
    _pageViewController.delegate = self;
    _pageViewController.dataSource = self;
    [_pageViewController setViewControllers:@[_vcArray[0]] direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
    _pageViewController.view.frame = CGRectMake(0, 64, kScreenWidth, kScreenHeight-64);
    [self.view addSubview:_pageViewController.view];
    
    //找到pageViewController view的scrollview，并将其代理设为self
    for (UIView *view in _pageViewController.view.subviews) {
        if ([view isKindOfClass:[UIScrollView class]])
        {
            ((UIScrollView *)view).delegate = self;
        }
    }
}

#pragma mark - PageViewControllerDelegate
- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController
{
    //查找当前界面viewcontroller是数组中第几个
    NSInteger index = [_vcArray indexOfObject:viewController];
    
    if (index == _vcArray.count-1) {
        return nil;
    }
    //返回下一页
    return _vcArray[index+1];
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController
{
    //返回上一页的界面
    NSInteger index = [_vcArray indexOfObject:viewController];
    if (index == 0) {
        return nil;
    }
    return _vcArray[index-1];
}

////翻页结束触发的代理方法
- (void)pageViewController:(UIPageViewController *)pageViewController didFinishAnimating:(BOOL)finished previousViewControllers:(NSArray *)previousViewControllers transitionCompleted:(BOOL)completed
{
    //获取当前页数
    UIViewController * x1 = pageViewController.viewControllers[0];
    NSInteger index = [_vcArray indexOfObject:x1];
    _curPage = index;
}


#pragma mark - ScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    CGFloat width = self.view.frame.size.width;
    CGFloat offSetX = scrollView.contentOffset.x;
    CGFloat offSetIndicatorX = 100/width * (offSetX-width);
    CGRect frame = _indicatorView.frame;
    
    frame.origin.x = offSetIndicatorX + _curPage*100;
    _indicatorView.frame = frame;
    
    
   CGFloat indicatorMaxX = _indicatorView.frame.origin.x + _indicatorView.frame.size.width;
    if (indicatorMaxX > _titleScrollView.frame.size.width) {
        _titleScrollView.contentOffset = CGPointMake(indicatorMaxX - _titleScrollView.frame.size.width, 0);
    }
}

-(void)configNavItems
{
    UIButton * navBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.view.backgroundColor = [UIColor whiteColor];
    [navBtn setTitle:@"分分更清楚" forState:UIControlStateNormal];
    navBtn.titleLabel.textAlignment = NSTextAlignmentLeft;
    CGFloat navBtnWidth = [Helper widthOfString:navBtn.titleLabel.text font:[UIFont systemFontOfSize:20] height:35];
    navBtn.frame = CGRectMake(kScreenWidth/2-navBtnWidth, 20, 200, 35);
    [self.view addSubview:navBtn];
}





@end
