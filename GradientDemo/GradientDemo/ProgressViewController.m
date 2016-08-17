//
//  ProgressViewController.m
//  GradientDemo
//
//  Created by Hu on 16/7/5.
//  Copyright © 2016年 redye. All rights reserved.
//

#import "ProgressViewController.h"
#import "YHProgressView.h"

@interface ProgressViewController ()
@property (nonatomic, strong) YHProgressView *progressView;
@property (weak, nonatomic) IBOutlet UIProgressView *progressView2;
@property (weak, nonatomic) IBOutlet UISlider *slider;
@property (assign, nonatomic) BOOL animated;
@end

@implementation ProgressViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    _progressView = [[YHProgressView alloc] initWithFrame:CGRectMake(20, 200, 300, 20)];
    _progressView.center = CGPointMake(self.view.bounds.size.width / 2, self.view.bounds.size.height / 2);
    [self.view addSubview:_progressView];
}

- (IBAction)progressChanged:(UISlider *)sender {
    self.progressView.progress = sender.value * 100;
    self.progressView2.progress = sender.value;
}

- (IBAction)valueChanged:(UISegmentedControl *)sender {
    CGFloat value = 0;
    if (sender.selectedSegmentIndex == 0) {
        value = 0;
    } else if (sender.selectedSegmentIndex == 1) {
        value = 50;
    } else {
        value = 100;
    }
    [self.progressView setProgress:value animated:_animated];
    [self.progressView2 setProgress:value /100.0 animated:_animated];
    self.slider.value = value / 100.0;
}

- (IBAction)animatedChanged:(UIButton *)sender {
    _animated = !_animated;
    sender.selected = !sender.selected;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
    
}

@end
