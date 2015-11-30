//
//  ColimnCell.h
//  GameIland
//
//  Created by Air on 15/8/17.
//  Copyright (c) 2015年 Air. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ColumnModel.h"
@interface ColimnCell : UITableViewCell<UIScrollViewDelegate>

@property (nonatomic , strong) ColumnModel * model;
@property (nonatomic , strong) UIImageView * iconView;
@property (nonatomic , strong) UILabel * titleLabel;
@property (nonatomic , assign) CGFloat cellHeight;
//初始化方法
+(instancetype)tableView:(UITableView *)tableView;

@end
