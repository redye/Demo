//
//  QQMessage.h
//  QQTableViewDemo
//
//  Created by hu on 16/1/20.
//  Copyright © 2016年 redye. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QQMessage : NSObject
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *content;
@property (nonatomic, copy) NSString *avtarURL;
@property (nonatomic, assign) BOOL isHasHonor;
@property (nonatomic, assign) BOOL isGroup;
@property (nonatomic, copy) NSString *timeString;
@property (nonatomic, assign) NSUInteger count;

- (instancetype)initWithName:(NSString *)name content:(NSString *)content avtarURL:(NSString *)url timeString:(NSString *)timeString count:(NSUInteger)count;
@end
