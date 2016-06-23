//
//  BJDrawPath.h
//  No.7 涂鸦画板
//
//  Created by 尹星 on 15/8/31.
//  Copyright (c) 2015年 cn.yinxing. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BJDrawPath : UIBezierPath
@property (nonatomic, strong) UIColor *color;

+ (instancetype)pathWithColor:(UIColor *)color andLineWidth:(CGFloat)lineWidth;
@end
