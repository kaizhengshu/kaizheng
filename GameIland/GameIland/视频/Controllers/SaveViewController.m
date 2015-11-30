//
//  SaveViewController.m
//  GameIland
//
//  Created by Air on 15/8/24.
//  Copyright (c) 2015年 Air. All rights reserved.
//

#import "SaveViewController.h"
#import "CHTCollectionViewWaterfallLayout.h"
#import "WaterCell.h"
#import "MyView.h"
#import "DBManager.h"
#import "DetailViewController.h"
@interface SaveViewController ()<CHTCollectionViewDelegateWaterfallLayout,UICollectionViewDataSource>
{
    UIImageView * _tabbarView;
    UICollectionView    *_collectionView;
    UIButton * _editingBtn;
    UIImageView * _backIV;
    BOOL _isEditing;
}
@end

@implementation SaveViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadData];

    // 初始化瀑布流布局
    CHTCollectionViewWaterfallLayout *layout = [[CHTCollectionViewWaterfallLayout alloc] init];
    // 列之间的间距
    layout.minimumColumnSpacing = 10;
    
    // 每列之间cell的间距
    layout.minimumInteritemSpacing = 10;
    
    
    // 每组的内边距
    layout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
    
    // 列数
    layout.columnCount = 2;
    //设置背景
    UIImageView * backIV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 64, kScreenWidth, kScreenHeight-64-44)];
    [backIV setImage:[UIImage imageNamed:@"默认图片"]];
    _collectionView.backgroundView = backIV;
    
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 64, kScreenWidth, kScreenHeight-64-44) collectionViewLayout:layout];
    _collectionView.dataSource = self;
    _collectionView.delegate = self;
    _collectionView.backgroundColor = [UIColor whiteColor];
    [self loadData];
    [_collectionView reloadData];
    //创建刷新视图
    _collectionView.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
    [self loadData];
    }];
    [self.view addSubview:_collectionView];
    
    // 注册可复用的cell类
    [_collectionView registerClass:[WaterCell class] forCellWithReuseIdentifier:[WaterCell identifier]];
    
    // 注册可复用的头部视图
    [_collectionView registerClass:[MyView class] forSupplementaryViewOfKind:CHTCollectionElementKindSectionHeader withReuseIdentifier:[MyView identifier]];
    
    // 注册可复用的尾部视图
    [_collectionView registerClass:[MyView class] forSupplementaryViewOfKind:CHTCollectionElementKindSectionFooter withReuseIdentifier:[MyView identifier]];
    
    
    //创建编辑按钮
    [self createEditingBtn];
    //创建分享
}


-(void)createEditingBtn
{
    _editingBtn = [[UIButton alloc] initWithFrame:CGRectMake(kScreenWidth-100, 20, 100, 40)];
    [_editingBtn setTitle:@"编辑" forState:UIControlStateNormal];
    [_editingBtn addTarget:self action:@selector(touchBtn) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_editingBtn];
    
    UIButton * titleBtn = [[UIButton alloc] initWithFrame:CGRectMake(kScreenWidth/2-100, 20, 200, 40)];
    [titleBtn setTitle:@"我的收藏" forState:UIControlStateNormal];
    [self.view addSubview:titleBtn];
}

#pragma mark 编辑按钮点击事件
-(void)touchBtn
{
    if (_isEditing == YES) {
        UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"编辑完成" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
        [_editingBtn setTitle:@"编辑" forState:UIControlStateNormal];
        _isEditing = NO;
    }else if(_isEditing == NO)
    {
        UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"点击删除" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
        [_editingBtn setTitle:@"完成" forState:UIControlStateNormal];
        _isEditing = YES;
    }
}

- (void)loadData {
    _saveDataArr = [NSMutableArray arrayWithCapacity:0];
    _saveDataArr = [[DBManager shareManager] searchAllData];
    if (_saveDataArr.count == 0) {
        UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"亲，暂无收藏" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [_collectionView reloadData];
        [_collectionView.header endRefreshing];
        [alert show];
    }
    if (_saveDataArr.count != 0) {
            [_collectionView reloadData];
            [_collectionView.header endRefreshing];
        }
}

#pragma mark - CollectionView Delegate&DataSource
#pragma mark 组
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return  1;
}

#pragma mark 每组多少项
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _saveDataArr.count;
}

#pragma mark 填充cell
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    WaterCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:[WaterCell identifier] forIndexPath:indexPath];
    cell.model = _saveDataArr[indexPath.row];
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    
    MyView *myView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:[MyView identifier] forIndexPath:indexPath];

    return myView ;
}

#pragma mark 返回cell的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ColumnModel * model = [[ColumnModel alloc] init];
    CGFloat heght = [Helper heightOfString:model.titleLabel.text font:[UIFont systemFontOfSize:40.0] width:kScreenWidth/2-10];
    //return CGSizeMake(kScreenWidth/2-10, 130+heght);
    return CGSizeMake(kScreenHeight/4.4, kScreenWidth/2-10);
}

#pragma mark cell点击事件
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (_isEditing == YES) {
        ColumnModel * model = _saveDataArr[indexPath.row];
        [[DBManager shareManager] deleteDataWithModel:model];
        [self loadData];
        [_collectionView reloadData];
    }else if(_isEditing == NO)
    {
        ColumnModel * model = _saveDataArr[indexPath.row];
        DetailViewController * detail = [[DetailViewController alloc]init];
        detail.model = model;
        detail.url = [NSURL URLWithString:model.urlStr];
        [self.navigationController pushViewController:detail animated:YES];
        [_collectionView reloadData];
    }
}

@end
