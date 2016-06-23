//
//  ViewController.m
//  No.7 涂鸦画板
//
//  Created by 尹星 on 15/8/31.
//  Copyright (c) 2015年 cn.yinxing. All rights reserved.
//

#import "ViewController.h"
#import "BJDrawView.h"
#import "MBProgressHUD+MJ.h"

@interface ViewController () <UINavigationControllerDelegate,UIImagePickerControllerDelegate>

@property (weak, nonatomic) IBOutlet BJDrawView *drawView;


@end

@implementation ViewController


#pragma mark - 获取颜色
- (IBAction)clickColorBtn:(UIButton *)sender {
    
    self.drawView.color = sender.backgroundColor;
    
}

#pragma maek - 获取线宽
- (IBAction)lineWith:(UISlider *)sender {
    
    self.drawView.lineWidth = sender.value;
    
}

#pragma mark - 清屏
- (IBAction)clearScreen:(UIBarButtonItem *)sender {
    
    [self.drawView clearAll];
    
}

#pragma mark - 撤销
- (IBAction)undo:(UIBarButtonItem *)sender {
    
    [self.drawView undo];
    
}

#pragma mark - 橡皮擦
- (IBAction)eraser:(UIBarButtonItem *)sender {
    
    [self.drawView eraser];
    
}

#pragma mark - 获取照片
- (IBAction)imageFromPhone:(UIBarButtonItem *)sender {
    
    //创建一个照片选择器
    UIImagePickerController *pickerVc = [[UIImagePickerController alloc]init];
    
    //设置相册数据源
    pickerVc.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
    
    //照片选择器的代理
    pickerVc.delegate = self;
    
    //modar
    [self presentViewController:pickerVc animated:YES completion:nil];
    
}

#pragma mark - 当选中一个照片是调用
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{

    //获取选中的图片
    UIImage *image = info[UIImagePickerControllerOriginalImage];
    
    //把选中的图片绘制到面板
    self.drawView.image = image;
    
    
    //与上面的modar相对应，隐藏照片选择器
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - 保存照片
- (IBAction)saveImage:(UIBarButtonItem *)sender {
    
    //开启位图
    UIGraphicsBeginImageContextWithOptions(self.drawView.bounds.size, NO, 0);
    //获取上下文
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    //截取内容到上下位图
    [self.drawView.layer renderInContext:ctx];
    
    //获取图片
    UIImage *iamge = UIGraphicsGetImageFromCurrentImageContext();
    
    //关闭上下文
    UIGraphicsEndImageContext();
    
    //保存到手机相册

    UIImageWriteToSavedPhotosAlbum(iamge, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
    
}


#pragma mark - 保存到相册之后的回调方法
- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo{
    
    if (error)
    {
        [MBProgressHUD showError:@"保存失败"];
    }
    else {
        //成功
        [MBProgressHUD showSuccess:@"保存成功"];
    }
    
}

#pragma mark- /*******************隐藏状态栏*****************/
- (BOOL)prefersStatusBarHidden{
    
    return YES;
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
