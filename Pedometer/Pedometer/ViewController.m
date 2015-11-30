//
//  ViewController.m
//  Pedometer
//
//  Created by hu on 15/11/30.
//  Copyright © 2015年 redye. All rights reserved.
//

#import "ViewController.h"
#import <CoreMotion/CoreMotion.h>

@interface ViewController ()

@property (strong, nonatomic) CMPedometer *pedometer;  // CMStepCounter 8.0已废弃

@property (weak, nonatomic) IBOutlet UILabel *stepLabel;

@end


/*
 
 磁力计传感器（Magnetometer Sensor）
 陀螺仪（Gyroscope）
 运动传感器\加速度传感器\加速计（Motion/Accelerometer Sensor）
 
 这几个传感器都在 CoreMotion 中
 */
@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
}

- (CMPedometer *)pedometer
{
    if (!_pedometer) {
        _pedometer = [[CMPedometer alloc] init];
    }
    
    return _pedometer;
}

- (IBAction)startStepCount:(id)sender {
    
    //判断是否支持记步
    if (![CMPedometer isStepCountingAvailable]) {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"您的设备不支持记步" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *alertAction = [UIAlertAction actionWithTitle:@"我知道了" style:UIAlertActionStyleDefault handler:nil];
        [alertController addAction:alertAction];
        [self presentViewController:alertController animated:YES completion:nil];
        return;
    }
    
    __weak typeof(self) weakSelf = self;
    
    NSDate *date = [NSDate date];
    NSTimeZone *timeZone = [NSTimeZone systemTimeZone];
    NSInteger interval = [timeZone secondsFromGMTForDate:date];
    NSDate *localDate = [date dateByAddingTimeInterval:interval];
    [_pedometer queryPedometerDataFromDate:[NSDate dateWithTimeInterval:-24*60*60 sinceDate:localDate] toDate:localDate withHandler:^(CMPedometerData * _Nullable pedometerData, NSError * _Nullable error) {
        if (error) {
            NSLog(@"查询错误 %@", error);
            return ;
        }
        NSLog(@"%@", pedometerData);
        dispatch_async(dispatch_get_main_queue(), ^{
            weakSelf.stepLabel.text = [NSString stringWithFormat:@"%@", pedometerData];
        });
    }];
    
    [_pedometer startPedometerUpdatesFromDate:[NSDate dateWithTimeInterval:-24*60*60 sinceDate:localDate] withHandler:^(CMPedometerData * _Nullable pedometerData, NSError * _Nullable error) {
        if (error) {
            NSLog(@"更新错误 %@", error);
            return ;
        }
        NSLog(@"%@", pedometerData);
        dispatch_async(dispatch_get_main_queue(), ^{
            weakSelf.stepLabel.text = [NSString stringWithFormat:@"%@", pedometerData];
        });
    }];
}

- (IBAction)stopStepCount:(id)sender {
    [_pedometer stopPedometerUpdates];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
