//
//  NewsViewController.m
//  GameIland
//
//  Created by Air on 15/8/10.
//  Copyright (c) 2015年 Air. All rights reserved.
//

#import "NewsViewController.h"
#import "ColumnModel.h"
#import "NewsCell.h"
#import "NewsDetailController.h"
#import "DetailViewController.h"
#import "ConfigViewController.h"
@interface NewsViewController ()<UITableViewDelegate,UITableViewDataSource>

{
    
    NSInteger           _pageNumber; // 页数
    
    BOOL                isRemoveAll; // 是否移除所有数据
    //新闻tabelview
    UITableView * _tableView;
    //存储数据的数组
    NSMutableArray * _dataArr;
    //高度
    CGFloat     _newscellHeight;
    //存放收藏数据数组
    NSMutableArray * saveArr;
}

@end

@implementation NewsViewController

#pragma mark 创建导航栏元素
-(void)createNavgationItem
{
    UIButton * navBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.view.backgroundColor = [UIColor whiteColor];
    [navBtn setTitle:@"资讯一箩筐" forState:UIControlStateNormal];
    navBtn.titleLabel.textAlignment = NSTextAlignmentLeft;
    CGFloat navBtnWidth = [Helper widthOfString:navBtn.titleLabel.text font:[UIFont systemFontOfSize:20] height:35];
     navBtn.frame = CGRectMake(kScreenWidth/2-navBtnWidth, 20, 200, 35);
    //设置按钮
    UIButton * configBtn =  [Helper addNavBtnWithFrame:CGRectMake(20, 20, 35, 35) withTitle:nil withIconName:@"我的"];
    [configBtn addTarget:self action:@selector(jumpToSetting) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:configBtn];
    [self.view addSubview:navBtn];
}

-(void)jumpToSetting
{
    ConfigViewController * set = [[ConfigViewController alloc] init];
    [self.navigationController pushViewController:set animated:YES];
}

#pragma mark 创建tableView
-(void)createTableView
{
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, kScreenWidth, kScreenHeight-44-64)];
    //遵循代理
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self loadDataWithNumber:0 isRemoveAll:YES];
    }];
    _tableView.footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        _pageNumber++;
        [self loadDataWithNumber:_pageNumber*20 isRemoveAll:NO];
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
    NewsCell * cell  =[NewsCell tableView:tableView];
    cell.model = _dataArr[indexPath.row];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    ColumnModel *model = _dataArr[indexPath.row];
    if (model.hasHead) {
        return kScreenHeight/3+20+10;
    }
    return kScreenHeight/8+10;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _dataArr = [NSMutableArray arrayWithCapacity:0];
    //创建导航栏元素项目
    [self createNavgationItem];
    //创建tableView
    [self createTableView];
    //解析数据
    [self loadDataWithNumber:0 isRemoveAll:NO];
}

#pragma mark 解析数据
-(void)loadDataWithNumber:(NSInteger)pageNumber isRemoveAll:(BOOL)isRemoveAll
{

    [Helper showHudToView:self.view text:@"正在加载..."];
    //网络请求管理类
        AFHTTPRequestOperationManager * manager = [AFHTTPRequestOperationManager manager];
    //设置不解析
        manager.responseSerializer = [AFHTTPResponseSerializer serializer];
        // 开始网络请求
        /** 参数
         1，请求的url
         2，请求所要拼接的参数
         3，请求成功的block
         4，请求失败的block
         */
        NSString * urlStr = [NSString stringWithFormat:@"http://c.3g.163.com/nc/article/list/T1348654151579/%i-20.html",pageNumber];
        [manager GET:urlStr parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
            //移除刷新视图
           [MBProgressHUD hideHUDForView:self.view animated:YES];
            [_tableView.header endRefreshing];
            [_tableView.footer endRefreshing];
            id backData = responseObject;
            NSDictionary * rootData = [NSJSONSerialization JSONObjectWithData:backData options:NSJSONReadingMutableContainers error:nil];
            NSArray * dataArr = rootData[@"T1348654151579"];
            if (isRemoveAll){ // 下拉刷新
                [_dataArr removeAllObjects];
            }
            //遍历数组
            for (NSDictionary * modelDict in dataArr) {
                //取出model
                ColumnModel * model =  [[ColumnModel alloc] init];
                //填充model
                //图片
                model.iconUrl = [[NSURL alloc] init];
                model.iconUrl = modelDict[@"imgsrc"];
                //标题
                model.titleLabel = [[UILabel alloc] init];
                model.titleLabel.text = modelDict[@"title"];
                //简介
                model.detailLabel = [[UILabel alloc] init];
                model.detailLabel.text = modelDict[@"digest"];
                //网址
                model.urlStr = modelDict[@"url"];
                if (nil != modelDict[@"hasHead"]) {
                    model.hasHead = modelDict[@"hasHead"];
                }
                //放入数组
                [_dataArr addObject:model];
            }
            [_tableView reloadData];
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"error:%@",error.localizedDescription);
            if (LFIsNetWorking == NO){
                UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"连接失败" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:nil, nil];
            [alert show];
            return;
            }
        }];
}

#pragma mark cell点击事件
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ColumnModel * model = _dataArr[indexPath.row];
    NSURL * url = [NSURL URLWithString:model.urlStr];
    NewsDetailController * nd = [[NewsDetailController alloc] init];
    nd.url = url;
    __weak NewsDetailController *wNd = nd;
    nd.saveUrlBlock = ^(NSURL *url)
    {
        [Helper showHudToView:wNd.view text:@"加载中"];
        [wNd.webView loadRequest:[NSURLRequest requestWithURL:url]];
        wNd.model = model;
    };
    [self.navigationController pushViewController:nd animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




@end
