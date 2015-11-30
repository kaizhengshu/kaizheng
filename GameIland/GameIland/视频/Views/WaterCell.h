//
//  WaterCell.h
//  GameIland
//
//  Created by Air on 15/8/24.
//  Copyright (c) 2015年 Air. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ColumnModel.h"
@interface WaterCell : UICollectionViewCell

@property (nonatomic , strong) ColumnModel * model;

@property (nonatomic, strong) UILabel *label;
@property (nonatomic, strong) UIImageView * iv;
@property (nonatomic, assign) BOOL isEditing;


+ (NSString *)identifier;


@end
