//
//  ColumnModel.h
//  GameIland
//
//  Created by Air on 15/8/17.
//  Copyright (c) 2015年 Air. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ColumnModel : NSObject
//图标
@property (nonatomic , strong) UIImageView * iconImage;

@property (nonatomic , strong) NSURL * iconUrl;
//标题
@property (nonatomic , strong) UILabel * titleLabel;

//详情网址
@property (nonatomic , strong) NSString * urlStr;
@property (nonatomic , strong) UILabel * detailLabel;
//图片数组
@property (nonatomic , strong) NSMutableArray * iconArr;
//是否是第一张
@property (nonatomic , assign) BOOL isFirstModel;
//是否是大图
@property (nonatomic , assign) NSString * hasHead;

@end

