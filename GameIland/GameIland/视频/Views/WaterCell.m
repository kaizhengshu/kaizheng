//
//  WaterCell.m
//  GameIland
//
//  Created by Air on 15/8/24.
//  Copyright (c) 2015年 Air. All rights reserved.
//

#import "WaterCell.h"

@implementation WaterCell

// 重写initWithFrame方法.
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        NSLog(@"initWithFrame:%@", NSStringFromCGRect(frame));
        //图片
        _iv  = [[UIImageView alloc] init];
        //标题
        _label = [[UILabel alloc] init];
        _label.textAlignment = NSTextAlignmentCenter;
        _label.font = [UIFont systemFontOfSize:12.0f];
        _label.textColor = [UIColor orangeColor];
        
        [self addSubview:_label];
        [self addSubview:_iv];
    }
    
    return self;
}

-(void)setModel:(ColumnModel *)model
{
    _iv.frame = CGRectMake(0, 0, kScreenWidth/2-10, 130);
    _label.text = model.titleLabel.text;
    _label.numberOfLines = 0;
    CGFloat heght = [Helper heightOfString:_label.text font:[UIFont systemFontOfSize:12.0] width:kScreenWidth/2-10];
    _label.frame = CGRectMake(0, 130, kScreenWidth/2-10, heght);
    [_iv setImageWithURL:model.iconUrl placeholderImage:[UIImage imageNamed:@"默认图片@2x"]];
}

// 改变cell的frame会调用
//- (void)layoutSubviews
//{
//    [super layoutSubviews];
//    // 根据cell的宽高重新设置label的宽高
//    _label.frame = CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height);
//}

// 返回复用ID
+ (NSString *)identifier
{
    return @"myCell";
}
@end
