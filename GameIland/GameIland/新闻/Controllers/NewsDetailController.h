//
//  NewsDetailController.h
//  GameIland
//
//  Created by Air on 15/8/11.
//  Copyright (c) 2015年 Air. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ColumnModel.h"
#import "RootViewController.h"
#import "Helper.h"
@interface NewsDetailController : RootViewController

typedef void(^urlBlock)(NSURL *);
@property (nonatomic , strong) ColumnModel * model;
@property (nonatomic , copy) urlBlock saveUrlBlock;
@property (nonatomic , strong) UIWebView * webView;
@property (nonatomic,strong) NSURL *url;

//webview适配屏幕
@property(nonatomic) BOOL scalesPageToFit;


@end
