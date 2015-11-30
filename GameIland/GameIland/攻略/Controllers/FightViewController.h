//
//  FightViewController.h
//  GameIland
//
//  Created by Air on 15/8/10.
//  Copyright (c) 2015年 Air. All rights reserved.
//

#import "RootViewController.h"
#import "PS4ViewController.h"
#import "ColumnModel.h"
@interface FightViewController : RootViewController

@property (nonatomic ,assign) NSInteger pageNumber;

@property (nonatomic , strong) ColumnModel * model;

@property (nonatomic ,strong) NSURL * detailUrl;

@end
