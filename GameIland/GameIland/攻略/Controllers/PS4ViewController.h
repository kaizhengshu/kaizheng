//
//  PS4ViewController.h
//  GameIland
//
//  Created by Air on 15/8/19.
//  Copyright (c) 2015年 Air. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RootViewController.h"
#import "ColumnModel.h"
typedef void(^pushViewBlock)(NSURL *,ColumnModel * );
@interface PS4ViewController : RootViewController


@property (nonatomic , assign) NSInteger pageNum;

@property (nonatomic , copy) pushViewBlock pushBlock;

@end
