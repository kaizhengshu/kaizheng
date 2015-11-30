//
//  NetWorkManager.h
//  GameIland
//
//  Created by Air on 15/8/13.
//  Copyright (c) 2015年 Air. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GDataXMLNode.h"
typedef void(^SuccessBlock)(id respondData);
typedef void(^FailureBlock)(NSString * errDece);

@interface NetWorkManager : NSObject

//栏目
+(NSMutableArray *)initXmlWithUrl:(NSString *) urlStr success:(SuccessBlock)success faile:(FailureBlock)falure;


@end


