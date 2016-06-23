//
//  BJDrawView.h
//  No.7 涂鸦画板
//
//  Created by 尹星 on 15/8/31.
//  Copyright (c) 2015年 cn.yinxing. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BJDrawView : UIView
@property (nonatomic, strong) UIColor *color;
@property (nonatomic, assign) int lineWidth;
@property (nonatomic, strong) UIImage *image;

- (void)clearAll;
- (void)undo;
- (void)eraser;
@end
