//
//  NewsCell.h
//  GameIland
//
//  Created by Air on 15/8/10.
//  Copyright (c) 2015年 Air. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ColumnModel.h"
@interface NewsCell : UITableViewCell

@property (nonatomic , strong) ColumnModel * model;

@property (nonatomic , assign) CGFloat cellHeight;
//初始化方法
+(instancetype)tableView:(UITableView *)tableView;
@end
