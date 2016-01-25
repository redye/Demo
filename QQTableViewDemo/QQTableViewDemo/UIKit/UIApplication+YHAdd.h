//
//  UIApplication+YHAdd.h
//  QQTableViewDemo
//
//  Created by hu on 16/1/18.
//  Copyright © 2016年 redye. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIApplication (YHAdd)

/// "Documents" folder in this app's sandbox.
@property (nonatomic, readonly) NSURL *documentsURL;
@property (nonatomic, readonly) NSString *documentsPath;

/// "Caches" folder in this app's sandbox.
@property (nonatomic, readonly) NSURL *cachesURL;
@property (nonatomic, readonly) NSString *cachesPath;

/// "Library" folder in this app's sandbox.
@property (nonatomic, readonly) NSURL *libraryURL;
@property (nonatomic, readonly) NSString *libraryPath;

/// Application's Bundle Name (show in SpringBoard).
@property (nonatomic, readonly) NSString *appBundleName;

/// Application's Bundle ID. e.g. "com.redye.MyApp".
@property (nonatomic, readonly) NSString *appBundleID;

/// Application's Version. e.g. "1.2.0".
@property (nonatomic, readonly) NSString *appVersion;

/// Application's Bundle number. e.g. "123".
@property (nonatomic, readonly) NSString *appBuildVersion;

/// Weather this app is being pirated (not install from appstore).
@property (nonatomic, readonly) BOOL isPirated;

/// Weather this app is being debugged (debugger attached).
@property (nonatomic, readonly) BOOL isBeingDebugged;

/// Current thread real memroy used in byte.(-1 when error occurs)
@property (nonatomic, readonly) int64_t memoryUsage;

/// Current thread CPU usage, 1.0 means 100%.(-1 when error occur)
@property (nonatomic, readonly) float cpuUsages;


- (void)incrementNetworkActivityCount;

- (void)decrementNetworkActivityCount;

/// Return YES in APP Extension
+ (BOOL)isAppExtension;

/// Same as sharedApplication, but return nil in App extensin.
+ (UIApplication *)sharedExtensionApplication;

@end
