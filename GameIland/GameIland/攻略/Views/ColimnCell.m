//
//  ColimnCell.m
//  GameIland
//
//  Created by Air on 15/8/17.
//  Copyright (c) 2015年 Air. All rights reserved.
//

#import "ColimnCell.h"

@implementation ColimnCell
{
    //第一个model的滚动视图
    UIScrollView * _scroll;
}
//初始化方法
+(instancetype)tableView:(UITableView *)tableView
{
    static NSString * cellID = @"ID";
    ColimnCell * cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[ColimnCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        //添加子控件
        [cell addSubviews];
    }
    return cell;
}

//添加cell子视图
-(void)addSubviews
{
    _iconView = [[UIImageView alloc] init];
    _titleLabel = [[UILabel alloc] init];
    _scroll = [[UIScrollView alloc] init];
    [self addSubview:_iconView];
    [self addSubview:_titleLabel];
    [self addSubview:_scroll];
}

//重写model的SET方法
-(void)setModel:(ColumnModel *)model
{
    if (_model != model) {
        _model = nil;
        _model = model;
    }
    
    if (model.isFirstModel == YES)
    {
       _iconView.frame = CGRectMake(0, 0, 0, 0);
        _scroll.delegate = self;
        _scroll.frame = CGRectMake(0, 0, kScreenWidth, 200);
        _scroll.contentSize = CGSizeMake(kScreenWidth*[_model.iconArr[0] count], 0);
        _scroll.pagingEnabled = YES;
        for (int i = 0 ; i < [_model.iconArr[0] count]; i++) {
            UIImageView * iv = [[UIImageView alloc] initWithFrame:CGRectMake(kScreenWidth * i, 0, kScreenWidth, 200)];
            [iv setImageWithURL:model.iconArr[0][i] placeholderImage:[UIImage imageNamed:@"默认图片@2x"]];           [_scroll addSubview:iv];
            _titleLabel.text = model.titleLabel.text;
            
            CGFloat  MaxY = CGRectGetMaxY(_scroll.frame);
            
            //标题frame
            _titleLabel.font = [UIFont systemFontOfSize:14.5];
            _titleLabel.numberOfLines = 0;
            _titleLabel.frame =CGRectMake(5, MaxY, kScreenWidth,50);
        }
    } else {
        _scroll.frame = CGRectMake(0, 0, 0, 0);
        [_iconView setImageWithURL:model.iconUrl placeholderImage:[UIImage imageNamed:@"默认图片@2x"]];
        NSLog(@"%@",model.iconUrl);
        _iconView.frame = CGRectMake(5, 5, kScreenWidth/3.5, kScreenHeight/8);
        //获取图片X值
        CGFloat  iconMaxX = CGRectGetMaxX(_iconView.frame);
        //图片Y值
        CGFloat  iconMaxY = CGRectGetMaxY(_iconView.frame);
        _titleLabel.text = model.titleLabel.text;
        //标题frame
        _titleLabel.font = [UIFont systemFontOfSize:14.5];
        _titleLabel.numberOfLines = 0;
        _titleLabel.frame =CGRectMake(iconMaxX+5, 0, kScreenWidth-iconMaxY-20, 80);
    }
}

@end
