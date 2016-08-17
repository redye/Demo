//
//  YHProgressView.m
//  GradientDemo
//
//  Created by Hu on 16/7/6.
//  Copyright © 2016年 redye. All rights reserved.
//

#import "YHProgressView.h"

#define kProgressViewHeight 5

@interface YHProgressView ()
@property (nonatomic, strong) UIView *contentView;
@property (nonatomic, strong) CAGradientLayer *gradientLayer;
@property (nonatomic, assign) BOOL animated;
@property (nonatomic, strong) UILabel *titleLabel;
@end

@implementation YHProgressView

- (instancetype)init {
    return [self initWithFrame:CGRectZero];
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setUI];
    }
    
    return self;
}

- (void)setUI {
    _contentView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, kProgressViewHeight)];
    _contentView.layer.cornerRadius = kProgressViewHeight / 2.0;
    _contentView.layer.backgroundColor = [UIColor colorWithRed:233 / 255.0 green:233 / 255.0 blue:233 / 255.0 alpha:1].CGColor;
    [self addSubview:_contentView];
    
    _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 30, 12)];
    _titleLabel.font = [UIFont systemFontOfSize:8];
    _titleLabel.textColor = [UIColor whiteColor];
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    _titleLabel.layer.cornerRadius = _titleLabel.bounds.size.height / 2.0;
    _titleLabel.layer.backgroundColor = [UIColor colorWithRed:255 / 255.0 green:95 / 255.0 blue:39 / 255.0 alpha:1].CGColor;
    _titleLabel.text = @"0%";
    [_contentView addSubview:_titleLabel];
    
    _gradientLayer = [CAGradientLayer layer];
    _gradientLayer.colors = @[(__bridge id)[UIColor colorWithRed:233 / 255.0 green:193 / 255.0 blue:60 / 255.0 alpha:1].CGColor,
                              (__bridge id)[UIColor colorWithRed:255 / 255.0 green:95 / 255.0 blue:39 / 255.0 alpha:1].CGColor];
    _gradientLayer.startPoint = CGPointZero;
    _gradientLayer.endPoint = CGPointMake(1, 0);
    _gradientLayer.frame = _contentView.bounds;
    _gradientLayer.cornerRadius = kProgressViewHeight / 2.0;
    [_contentView.layer insertSublayer:_gradientLayer atIndex:0];
    
}

- (void)layoutSubviews {
    [super layoutSubviews];
    _contentView.frame = CGRectMake(0, 0, self.frame.size.width, kProgressViewHeight);
    _contentView.center = CGPointMake(self.frame.size.width / 2, self.frame.size.height / 2);
    CGFloat width = _contentView.bounds.size.width * self.progress / 100.0;
    CGFloat x = width - _titleLabel.bounds.size.width / 2.0;
    CGFloat y = (_contentView.bounds.size.height - _titleLabel.bounds.size.height) / 2;
    [CATransaction begin];
    [CATransaction setDisableActions:!_animated];
    _titleLabel.frame = CGRectMake(x, y, _titleLabel.bounds.size.width, _titleLabel.bounds.size.height);
    _gradientLayer.frame = CGRectMake(0, 0, width, kProgressViewHeight);
    [CATransaction commit];
}

- (void)setProgress:(CGFloat)progress {
    [self setProgress:progress animated:NO];
}

- (void)setProgress:(CGFloat)progress animated:(BOOL)animated {
    _progress = progress;
    _animated = animated;
    _titleLabel.text = [NSString stringWithFormat:@"%.0f%@", _progress, @"%"];
    [self setNeedsLayout];
}

- (void)setFrame:(CGRect)frame {
    [super setFrame:frame];
    [self setNeedsLayout];
}

- (void)setCenter:(CGPoint)center {
    [super setCenter:center];
    [self setNeedsLayout];
}

@end
