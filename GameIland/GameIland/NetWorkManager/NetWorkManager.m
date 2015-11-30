//
//  NetWorkManager.m
//  GameIland
//
//  Created by Air on 15/8/13.
//  Copyright (c) 2015年 Air. All rights reserved.
//

#import "NetWorkManager.h"
#import "GDataXMLNode.h"
@implementation NetWorkManager

+(NSMutableArray *)initXmlWithUrl:(NSString *) urlStr success:(SuccessBlock)success faile:(FailureBlock)falure{
    NSURL * url = [NSURL URLWithString:urlStr];
    NSMutableArray * _titleArr = [[NSMutableArray alloc] initWithCapacity:0];
    NSMutableArray * _shareArr = [[NSMutableArray alloc] initWithCapacity:0];
    NSMutableArray * _iconUrlArr = [[NSMutableArray alloc] initWithCapacity:0];
    NSMutableArray * allArr = [[NSMutableArray alloc] initWithCapacity:0];
    NSData * data = [NSData dataWithContentsOfURL:url];
    GDataXMLDocument * doc = [[GDataXMLDocument alloc] initWithData:data options:0 error:nil];
    //获取根节点
    GDataXMLElement * root = doc.rootElement;
    //NSLog(@"Gdata root%@",root);
    //获取根节点下所有叫articles的自己点
    NSArray * article = [root elementsForName:@"Article"];
    //获取article 下所有medias节点
    for (int i = 0; i<article.count; i++) {
        NSArray * mediaArr = [article[i] elementsForName:@"Medias"];
        //获取medais下所有的media节点
        NSArray * media = [mediaArr[0] elementsForName:@"Media"];
        //循环遍历  存储URl
        NSMutableArray * arr = [NSMutableArray array];
        for (int j = 0;j<media.count;j++) {
        NSString * iconUrl = [[media[j] attributeForName:@"Url"] stringValue];
        [arr addObject:iconUrl];
        }
        [_iconUrlArr addObject:arr];
    }
    for (GDataXMLElement * element in article) {
         NSString * title = [[element attributeForName:@"Title"] stringValue];
        NSString * link  = [[element attributeForName:@"Link"] stringValue];
        [_titleArr addObject:title];
        [_shareArr addObject:link];

    }

    [allArr addObject:_titleArr];
    [allArr addObject:_shareArr];
    [allArr addObject:_iconUrlArr];
    return allArr;
}


@end