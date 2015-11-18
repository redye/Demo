//
//  ViewController.m
//  EShowDemo
//
//  Created by hu on 15/11/17.
//  Copyright © 2015年 redye. All rights reserved.
//

#import "ViewController.h"
#import "UIDevice+SysInfo.h"

#define kINCH 25.4

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightContraint;
@property (weak, nonatomic) IBOutlet UILabel *levelLabel;
@property (strong, nonatomic) NSArray *lengthArray;
@property (assign, nonatomic) CGFloat  level;
@property (assign, nonatomic) CGFloat  DPI;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initData];
    
    [self calculateHeight];
}

- (void)initData
{
    self.lengthArray = @[@(36.45), @(28.95), @(23.00), @(18.27), @(14.51), @(11.53), @(9.16), @(7.27), @(5.78), @(4.59), @(3.64), @(2.89)];
    self.level = 4.1;
    
    self.DPI = [self DPI];
}

- (IBAction)nextE {
    self.level += 0.1;
    
    int index = ceilf((self.level - 4.1) * 10);
    if (index >= self.lengthArray.count-1) {
        [[[UIAlertView alloc] initWithTitle:nil message:@"已经测试到最大标准值，恭喜您，您的视力非常好" delegate:nil cancelButtonTitle:@"我知道了" otherButtonTitles:nil, nil] show];
        return;
    }
    
    self.levelLabel.text = [NSString stringWithFormat:@"%.1f", self.level];
    
    [self calculateHeight];
}

- (void)calculateHeight
{
    int index = ceilf((self.level - 4.1) * 10);
    CGFloat legth = [self.lengthArray[index] floatValue];
    CGFloat height = self.DPI * (legth/kINCH) / [UIScreen mainScreen].scale;
    self.heightContraint.constant = height;

}

- (CGFloat)DPI
{
    CGFloat DPI  = 0;
    
    CGFloat scale = [[UIScreen mainScreen] scale];
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    CGFloat height = [UIScreen mainScreen].bounds.size.height;
    
    //获取当前设备类型是 iPad 或是 mini
    NSString *deviceVersion = [[UIDevice currentDevice] deviceVersion];
    CGFloat inch = 9.7;
    if ([deviceVersion containsString:@"mini"]) {
        inch = 7.9;
    }
    
    CGFloat x = width * scale;
    CGFloat y = height * scale;
    DPI  = (sqrt(x*x + y*y))/inch;
    
    return DPI;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
