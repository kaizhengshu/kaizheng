//
//  TowerViewController.h
//  GameIland
//
//  Created by Air on 15/8/20.
//  Copyright (c) 2015年 Air. All rights reserved.
//

#import "RootViewController.h"
#import "NetWorkManager.h"
#import "ColimnCell.h"
#import "ColumnModel.h"
typedef void(^pushViewBlock)(NSURL *,ColumnModel * );
@interface TowerViewController : RootViewController
@property (nonatomic , assign) NSInteger pageNum;
@property (nonatomic , copy) pushViewBlock pushBlock;
@end
