//
//  DBManager.m
//  1508LimitFree_01
//
//  Created by qianfeng on 15/7/9.
//  Copyright (c) 2015年 yangxin. All rights reserved.
//

#import "DBManager.h"
#import "ColumnModel.h"
#import "FMDatabase.h"
@interface DBManager ()
{
    FMDatabase  *_fmdb; // 数据库的成员变量
    NSLock      *_lock; // 锁
}
@end

@implementation DBManager

// DBManager的实例 static修饰的,只能初始化一次
static DBManager *_db;
+ (instancetype)shareManager
{
    static dispatch_once_t predicate; // 谓词
    
    // 这句话里面的代码只会执行一次
    dispatch_once(&predicate, ^{
        _db = [[DBManager alloc] init];
    });
    
    return _db;
}

// 创建数据库和表
- (instancetype)init
{
    if (self = [super init]) {
        // 锁的初始化
        _lock = [[NSLock alloc] init];
        
        // 1.创建数据库
        // 获取沙盒document文件夹路径
        NSString *docPath = [NSHomeDirectory() stringByAppendingString:@"/Documents"];
        // 拼接数据库路径 app.db:数据库名
        NSString *dbPath = [docPath stringByAppendingString:@"/app.db"];
        
        NSLog(@"沙盒路径:%@", dbPath);
        
        // 根据路径创建数据库
        _fmdb = [FMDatabase databaseWithPath:dbPath];
        
        // 2.打开数据库
        BOOL isOpen = [_fmdb open];
        if (isOpen) { // 打开数据库成功
            LFLog(@"打开数据库成功");
            // 3.开始建表
            // 3.1 sql语句
            NSString *sqlStr = @"create table if not exists igame(iconUrl varchar(1024), title varchar(1024), detailUrl varchar(1024))";
            
            // 3.2 执行sql语句
            BOOL isSuccess = [_fmdb executeUpdate:sqlStr];
            
            // 3.3 判断是否成功
            LFLog(@"%@", isSuccess ? @"建表成功" : @"建表失败");
            
        } else {
            LFLog(@"打开数据库失败:%@", _fmdb.lastErrorMessage);
        }
        
    }
    
    return self;
}

#pragma mark 插入一条数据
- (BOOL)insertDataWithModel:(ColumnModel *)model
{
    NSString *docPath = [NSHomeDirectory() stringByAppendingString:@"/Documents"];
    // 拼接数据库路径 app.db:数据库名
    NSString *dbPath = [docPath stringByAppendingString:@"/app.db"];
    
    NSLog(@"沙盒路径:%@", dbPath);
    // 当对数据库的数据做修改(插入, 修改, 删除)操作的时候,为了保证数据的原子性,所以需要加锁.
    
    // 加锁:为了保证只有同一个线程在操作此数据
    [_lock lock];
    
    // 1.创建sql语句
    NSString *sqlStr = @"insert into igame values(?, ?, ?)";
    
    // 2.执行sql语句
    BOOL isSuccess = [_fmdb executeUpdate:sqlStr, model.iconUrl, model.titleLabel.text, model.urlStr];
    
    // 3.判断数据插入是否成功
    LFLog(@"%@", isSuccess ? @"插入成功" : @"插入失败");
    
    // 解锁:当前线程操作完成之后,可以让其它线程访问.
    [_lock unlock];
    
    return isSuccess;
}

#pragma mark 删除一条数据
- (BOOL)deleteDataWithModel:(ColumnModel *)model
{
    [_lock lock];
    
    // 1. 创建sql语句
    NSString *sqlStr = @"delete from igame where detailUrl = ?";
    
    // 2. 执行sql语句
    BOOL isSuccess = [_fmdb executeUpdate:sqlStr, model.urlStr];
    
    // 3.判断是否执行成功
    LFLog(@"%@", isSuccess ? @"删除成功" : @"删除失败");
    
    [_lock unlock];
    return isSuccess;
}



#pragma mark 根据appID查询单条数据
- (BOOL)searchDataWithAppID:(ColumnModel *)model
{
    
    NSString *sqlStr = @"select * from igame where detailUrl = ?";
    
    // 执行查询语句
    // 查询返回一个结果集
    FMResultSet *set = [_fmdb executeQuery:sqlStr, model.urlStr];
    
    // 判断结果集是否有数据
    BOOL b = [set next];
    return b;
}


#pragma mark 查询所有数据
- (NSMutableArray *)searchAllData
{
    NSMutableArray *modelArr = [NSMutableArray arrayWithCapacity:0];
    
    NSString *sqlStr = @"select * from igame";
    FMResultSet *set = [_fmdb executeQuery:sqlStr];
    
    while ([set next]) { // 表示下一条有数据
        ColumnModel *model = [[ColumnModel alloc] init];
        // 根据字段名取值
        model.iconUrl =  [NSURL URLWithString:[set stringForColumn:@"iconUrl"]];
        model.titleLabel = [[UILabel alloc] init];
        model.titleLabel.text = [set stringForColumn:@"title"];
        model.urlStr = [set stringForColumn:@"detailUrl"];
        if (model.urlStr != nil) {
        [modelArr addObject:model];
        }
    }
    return modelArr;
}




@end
