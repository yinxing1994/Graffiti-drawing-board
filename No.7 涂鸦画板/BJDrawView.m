//
//  BJDrawView.m
//  No.7 涂鸦画板
//
//  Created by 尹星 on 15/8/31.
//  Copyright (c) 2015年 cn.yinxing. All rights reserved.
//

#import "BJDrawView.h"
#import "BJDrawPath.h"
@interface BJDrawView ()
@property (nonatomic,strong)BJDrawPath *path;

@property (nonatomic,strong)NSMutableArray *pathsArray;
@end

@implementation BJDrawView

#pragma maek - 设置文字初始大小颜色
- (void)awakeFromNib{

    self.lineWidth = 1;
    self.color = [UIColor blackColor];
}


#pragma mark - 懒加载初始化数组
- (NSMutableArray *)pathsArray{

    if (_pathsArray == nil) {

        _pathsArray = [NSMutableArray array];
    }
    
    return _pathsArray;
    
}

#pragma mark - 重写image的set方法
- (void)setImage:(UIImage *)image{

    _image = image;
    [self.pathsArray addObject:image];
    
    [self setNeedsDisplay];
    
}

#pragma mark - 根据集合抽象出一个触摸点
- (CGPoint)pointWithTouch:(NSSet *)touches{

    //获取手指
    UITouch *touch = [touches anyObject];
    
    //返回触摸点
    return [touch locationInView:self];
    
}

#pragma mark- 开始点击
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{

    //获取当前点
    CGPoint curP = [self pointWithTouch:touches];
    
    //创建路径
    BJDrawPath *path = [BJDrawPath pathWithColor:self.color andLineWidth:self.lineWidth];
    
    [path moveToPoint:curP];
    
    self.path = path;
//    path.lineWidth = self.lineWidth;
    
    //添加路径到路径数组
    [self.pathsArray addObject:path];

}

#pragma mark - 根据滑动画线
- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{

    //获取当前点
    CGPoint curP = [self pointWithTouch:touches];
    
    [self.path addLineToPoint:curP];
    //重绘
    [self setNeedsDisplay];
    
}


#pragma mark - 画线
- (void)drawRect:(CGRect)rect{
    
    if (self.pathsArray.count == 0) return;
    
    for (BJDrawPath *path in self.pathsArray) {
        
        if ([path isKindOfClass:[UIImage class]]) {
            
            UIImage *image = (UIImage *)path;
            
            [image drawInRect:rect];
            
        }
        else{
            
            //不能直接使用颜色，//这样不行，因为前面线条的颜色都会和最后一个线条颜色一样
            [path.color set];
            [path stroke];
            
        }
    
    }
    
}

#pragma mark -清屏
- (void)clearAll{

    [self.pathsArray removeAllObjects];
    
    [self setNeedsDisplay];
}


#pragma mark - 撤销
- (void)undo{

    [self.pathsArray removeLastObject];

    [self setNeedsDisplay];
    
}

#pragma mark - 橡皮擦
- (void)eraser{
    
    self.color = [UIColor whiteColor];
    [self setNeedsDisplay];
    
}
@end
