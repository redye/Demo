//
//  QQMessage.m
//  QQTableViewDemo
//
//  Created by hu on 16/1/20.
//  Copyright © 2016年 redye. All rights reserved.
//

#import "QQMessage.h"

@implementation QQMessage
- (instancetype)initWithName:(NSString *)name content:(NSString *)content avtarURL:(NSString *)url timeString:(NSString *)timeString count:(NSUInteger)count {
    self = [super init];
    self.name = name;
    self.content = content;
    self.avtarURL = url;
    self.timeString = timeString;
    self.count = count;
    return self;
}
@end
