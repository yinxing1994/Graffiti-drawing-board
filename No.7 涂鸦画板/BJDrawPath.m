//
//  BJDrawPath.m
//  No.7 涂鸦画板
//
//  Created by 李献红 on 15/8/31.
//  Copyright (c) 2015年 cn.lixianhong. All rights reserved.
//

#import "BJDrawPath.h"

@implementation BJDrawPath

+ (instancetype)pathWithColor:(UIColor *)color andLineWidth:(CGFloat)lineWidth{

    BJDrawPath *path = [[self alloc]init];
    path.color = color;
    path.lineWidth = lineWidth;
    
    return path;
    
}
@end
