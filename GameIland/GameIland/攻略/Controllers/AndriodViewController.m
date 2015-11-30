//
//  AndriodViewController.m
//  GameIland
//
//  Created by Air on 15/8/19.
//  Copyright (c) 2015年 Air. All rights reserved.
//

#import "AndriodViewController.h"
#import "NetWorkManager.h"
#import "ColimnCell.h"
#import "ColumnModel.h"
#import "DetailViewController.h"
@interface AndriodViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    //数据源
    NSMutableArray * _andriodData;
    NSMutableArray* _dataArr;
    UITableView * _tableView;
    //标题
    NSMutableArray * _titleArr;
    //图片
    NSMutableArray * _iconArr;
    //详情
    NSMutableArray * _detailArr;
    //是否移除所有的数据
    BOOL            isRemoveAll;
}
@end

@implementation AndriodViewController

- (void)viewDidLoad {
    //创建tableView
    [self createTableView];
    //解析数据
    [self loadDataWithRemoveAll:NO];
}

#pragma mark 解析数据
-(void)loadDataWithRemoveAll:(BOOL)isRemoveAll
{
    //解析数据
    _andriodData =  [NetWorkManager initXmlWithUrl:AndriodUrl success:nil faile:nil];
    //如果无数据 报告
    if (_andriodData == nil){
        UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"连接失败" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:nil, nil];
        [alert show];
        return;
    }
    //结束刷新视图
    [_tableView.header endRefreshing];
    [_tableView.footer endRefreshing];
    if (isRemoveAll == 1){ // 下拉刷新
        [_dataArr removeAllObjects];
    }
    _dataArr  = [NSMutableArray array];
    _titleArr = _andriodData[0];
    _detailArr = _andriodData[1];
    _iconArr = _andriodData[2];
    //遍历数组
    for (int i = 0 ; i < _titleArr.count ; i++)
    {
        ColumnModel * model = [[ColumnModel alloc] init];
        if (0 == [_iconArr[i] count]) {
            model.iconUrl = [NSURL URLWithString:Xbox];
        }else{
            model.iconUrl = [NSURL URLWithString:_iconArr[i][0]];
        }
        model.titleLabel = [[UILabel alloc] init];
        model.titleLabel.text = _titleArr[i];
        model.urlStr = _detailArr[i];
        model.iconArr = _iconArr;
        [_dataArr addObject:model];
        if (0 == i) {
            model.isFirstModel = YES;
        }else
        {
            model.isFirstModel = NO;
        }
    }
}

#pragma mark 创建tableView
-(void)createTableView
{
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 20, kScreenWidth, kScreenHeight-24-64)];
    //遵循代理
    _tableView.delegate = self;
    _tableView.dataSource = self;
    //创建刷新视图
    _tableView.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self loadDataWithRemoveAll:YES];
    }];
    _tableView.footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"已经没有更多数据" message:nil delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
    }];
    [self.view addSubview:_tableView];
}


#pragma mark tableView - Delegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataArr.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ColimnCell * cell  =[ColimnCell tableView:tableView];
    cell.model = _dataArr[indexPath.row];
    return cell;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (0 == indexPath.row) {
        return 250;
    }
    return kScreenHeight/8+10;
}


#pragma mark cell点击事件
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ColumnModel * model = [[ColumnModel alloc] init];
    model = _dataArr[indexPath.row];
    NSURL * _url = [NSURL URLWithString:model.urlStr];
    _pushBlock(_url,model);
}

@end
