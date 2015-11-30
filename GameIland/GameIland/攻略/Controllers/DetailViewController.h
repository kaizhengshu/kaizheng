//
//  DetailViewController.h
//  GameIland
//
//  Created by Air on 15/8/19.
//  Copyright (c) 2015年 Air. All rights reserved.
//

#import "RootViewController.h"
#import "ColumnModel.h"
@interface DetailViewController : RootViewController

//webview适配屏幕
@property(nonatomic) BOOL scalesPageToFit;
@property (nonatomic,strong) NSURL * url;
@property (nonatomic ,strong) ColumnModel * model;
@end
