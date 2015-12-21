//
//  TableViewCell.m
//  TableMove
//
//  Created by hu on 15/12/15.
//  Copyright © 2015年 redye. All rights reserved.
//

#import "TableViewCell.h"

@interface TableViewCell ()<UIGestureRecognizerDelegate>
{
    UITapGestureRecognizer *_tap;
}

@property (weak, nonatomic) IBOutlet UIView *swipeView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *leftContraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topBtnWidthContraint;
@property (assign, nonatomic) BOOL isOnLeft;

@end

@implementation TableViewCell

//确保 Cell 在其回收重利用时再次关闭
- (void)prepareForReuse
{
    [super prepareForReuse];
    
    [self backToOrginPoint];
}

- (void)awakeFromNib {
    
    [self setUI];

    [self addGestures];
}

- (void)setUI
{
    //这样做的目的是能够让 cell 的分割线向后缩
    self.imageView.image = [UIImage imageNamed:@"placeholder"];
    self.imageView.hidden = YES;

    self.avtarImageView.layer.cornerRadius = self.avtarImageView.bounds.size.width / 2;
    self.avtarImageView.layer.masksToBounds = YES;
    
    self.badgeLabel.layer.cornerRadius = self.badgeLabel.bounds.size.height / 2;
    self.badgeLabel.layer.masksToBounds = YES;
    self.badgeLabel.text = @"1";

}

- (void)addGestures
{
    //添加点击手势
    _tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(backToOrginPoint)];
    _tap.enabled = NO;
    [self.swipeView addGestureRecognizer:_tap];
    
    //拖动手势
    UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(pan:)];
    panGesture.delegate = self;
    panGesture.delaysTouchesBegan = 0.5;
    [self.swipeView addGestureRecognizer:panGesture];
    [panGesture requireGestureRecognizerToFail:_tap];

}

- (void)pan:(UIPanGestureRecognizer *)gesture
{
    self.swipedBlock(self.row);
    
    CGFloat offsetX = [gesture translationInView:self.swipeView].x;
    CGFloat maxOffsetX = [self maxOffsetX];

    if (offsetX < 0) {
        if (self .isOnLeft) {
            self.leftContraint.constant += 0;
        } else if (fabs(offsetX) < maxOffsetX ) {
            self.leftContraint.constant = -8 + offsetX;
        } else if (fabs(offsetX) >= maxOffsetX){
            self.leftContraint.constant = -(8 + maxOffsetX);
        }
    }
    
    if (gesture.state == UIGestureRecognizerStateEnded || gesture.state == UIGestureRecognizerStateCancelled) {
        if (offsetX <= -maxOffsetX / 2) {
            [self swipeToEndPoint];
            self.isOnLeft = YES;
        } else {
            [self backToOrginPoint];
            self.isOnLeft = NO;
        }
    }
    
}

- (CGFloat)maxOffsetX
{
    CGFloat maxOffsetX = self.markReadButton.bounds.size.height + self.topBtnWidthContraint.constant;
    if (!self.markReadButton.hidden) {
        maxOffsetX += self.markReadButton.bounds.size.width;
    }
    
    return maxOffsetX;
}

- (void)swipeToEndPoint
{
    CGFloat offsetX = self.markReadButton.bounds.size.height + self.topBtnWidthContraint.constant;
    if (!self.markReadButton.hidden) {
        offsetX += self.markReadButton.bounds.size.width;
    }
    self.leftContraint.constant = -(8 + offsetX);
    [UIView animateWithDuration:0.1 animations:^{
        [self.swipeView layoutIfNeeded];
    } completion:^(BOOL finished) {
        _tap.enabled = YES;  //cell 滑动到左边，此时点击手势可用
    }];
    
}

- (void)backToOrginPoint
{
    self.leftContraint.constant = -8;
    [UIView animateWithDuration:0.3 animations:^{
        [self.swipeView layoutIfNeeded];
    } completion:^(BOOL finished) {
        _tap.enabled = NO; //cell 处于正常状态，点击手势不可用，否则会拦截系统的点选择效果 didSelected 代理
    }];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

#pragma mark - UIGestureRecognizerDelegate
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    return YES;  //告知各手势识别器，它们可以同时工作。
}

@end
