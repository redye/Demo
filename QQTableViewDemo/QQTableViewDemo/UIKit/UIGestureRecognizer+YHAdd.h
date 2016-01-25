//
//  UIGestureRecognizer+YHAdd.h
//  QQTableViewDemo
//
//  Created by hu on 16/1/22.
//  Copyright © 2016年 redye. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIGestureRecognizer (YHAdd)

- (instancetype)initWithActionBlock:(void(^)(id sender))block;

- (void)addActionBlock:(void(^)(id sender))block;

- (void)removeAllActionBlock;
@end
