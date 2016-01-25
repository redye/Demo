//
//  UIDevice+YHAdd.h
//  QQTableViewDemo
//
//  Created by hu on 16/1/18.
//  Copyright © 2016年 redye. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIDevice (YHAdd)

/// Device system version (e.g. 8.1)
+ (float)systemVersion;

/// Whether the device is iPad/iPad mini
+ (BOOL)isPad;

/// Whether the device is a simulator
@property (nonatomic, readonly) BOOL isSimulator;

/// The device's machine model.  e.g. "iPhone6,1" "iPad4,6"
/// @see http://theiphonewiki.com/wiki/Models
@property (nonatomic, readonly) NSString *machineModel;

/// The device's machine model name. e.g. iPhone 6s
@property (nonatomic, readonly) NSString *machineModelName;

/// Whether the device is JailBroken.
@property (nonatomic, readonly) BOOL isJailBroken;

- (BOOL)canMakePhoneCalls;

@end
