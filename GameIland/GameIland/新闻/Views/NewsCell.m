//
//  NewsCell.m
//  GameIland
//
//  Created by Air on 15/8/10.
//  Copyright (c) 2015年 Air. All rights reserved.
//

#import "NewsCell.h"
#import "ColumnModel.h"

@implementation NewsCell
{
    UIImageView * _iconImage;
    UILabel * _titleLabel;
    UILabel * _detailLabel;
}
//初始化方法
+(instancetype)tableView:(UITableView *)tableView
{
    static NSString * cellID = @"ID";
    NewsCell * cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[NewsCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        //添加子控件
        [cell addSubviews];
    }
    return cell;
}

//添加cell子视图
-(void)addSubviews
{
    _iconImage = [[UIImageView alloc] init];
    _titleLabel = [[UILabel alloc] init];
    _detailLabel = [[UILabel alloc] init];
    [self addSubview:_iconImage];
    [self addSubview:_titleLabel];
    [self addSubview:_detailLabel];
}

//重写model的SET方法
-(void)setModel:(ColumnModel *)model
{
    if (_model != model) {
        _model = nil;
        _model = model;
    }
    if (_model.hasHead == nil) {
    [_iconImage setImageWithURL:_model.iconUrl placeholderImage:[UIImage imageNamed:@"新闻"]];
    _iconImage.frame = CGRectMake(5, 5, kScreenWidth/3.5, kScreenHeight/8);
    //获取图片Y值
    CGFloat  iconMaxX = CGRectGetMaxX(_iconImage.frame);
    _titleLabel.text = _model.titleLabel.text;
    _titleLabel.numberOfLines = 0;
    //标题frame
    _titleLabel.font = [UIFont systemFontOfSize:14.5];
    _titleLabel.frame =CGRectMake(iconMaxX+5, 5, kScreenWidth-kScreenWidth/2.5, 20);
    //详情frame
    CGFloat titleMaxY = CGRectGetMaxY(_titleLabel.frame);
    _detailLabel.text = _model.detailLabel.text;
    _detailLabel.numberOfLines = 0;
    _detailLabel.font = [UIFont systemFontOfSize:12];
    _detailLabel.textColor = [UIColor grayColor];
    _detailLabel.textAlignment = NSTextAlignmentLeft;
    _detailLabel.frame = CGRectMake(iconMaxX+5,titleMaxY-10, kScreenWidth-iconMaxX-5, kScreenHeight/8);
    }else
    {
       [_iconImage setImageWithURL:_model.iconUrl placeholderImage:[UIImage imageNamed:@"默认图片@2x"]];
        _iconImage.frame = CGRectMake(5, 5, kScreenWidth-10,kScreenHeight/3);
        [_detailLabel removeFromSuperview];
            _titleLabel.font = [UIFont systemFontOfSize:15];
        _titleLabel.frame =CGRectMake(5, kScreenHeight/3+5, kScreenWidth, 20);
        _titleLabel.text = _model.titleLabel.text;
    }
}


@end
