//
//  UIScreen+YHAdd.h
//  QQTableViewDemo
//
//  Created by hu on 16/1/19.
//  Copyright © 2016年 redye. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIScreen (YHAdd)

+ (CGFloat)screenScale;
- (CGRect)currentBounds;
- (CGRect)boundsForOrientation:(UIInterfaceOrientation)orientation;

@property (nonatomic, readonly) CGSize sizeInPixel;
@property (nonatomic, readonly) CGFloat pixelsPerInch;

@end
