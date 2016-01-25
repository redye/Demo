//
//  UIImage+YHAdd.h
//  QQTableViewDemo
//
//  Created by hu on 16/1/20.
//  Copyright © 2016年 redye. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (YHAdd)

- (UIImage *)imageByRoundCornerRadius:(CGFloat)radius;

- (UIImage *)imageByRoundCornerRadius:(CGFloat)radius
                          borderWidth:(CGFloat)borderWidth
                          borderColor:(UIColor *)borderColor;

- (UIImage *)imageByRoundCornerRadius:(CGFloat)radius
                              corners:(UIRectCorner)corners
                          borderWidth:(CGFloat)borderWidth
                          borderColor:(UIColor *)borderColor
                       borderLineJoin:(CGLineJoin)borderLineJoin;

@end
