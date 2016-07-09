//
//  YHProgressView.h
//  GradientDemo
//
//  Created by Hu on 16/7/6.
//  Copyright © 2016年 redye. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YHProgressView : UIView
@property (nonatomic, assign) CGFloat progress;

- (void)setProgress:(CGFloat)progress animated:(BOOL)animated;
@end
