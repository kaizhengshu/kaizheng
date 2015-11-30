//
//  DBManager.h
//  1508LimitFree_01
//
//  Created by qianfeng on 15/7/9.
//  Copyright (c) 2015年 yangxin. All rights reserved.
//

#import <Foundation/Foundation.h>
@class ColumnModel;
@interface DBManager : NSObject

// 单例模式
+ (instancetype)shareManager;

// 插入一条数据
- (BOOL)insertDataWithModel:(ColumnModel *)model;
// 删除一条数据
- (BOOL)deleteDataWithModel:(ColumnModel *)model;
// 修改一条数据
- (BOOL)updateDataWithModel:(ColumnModel *)model;

// 根据appID查询数据是否存在
- (BOOL)searchDataWithAppID:(ColumnModel *)model;

// 查询所有数据
- (NSMutableArray  *)searchAllData;

@end
