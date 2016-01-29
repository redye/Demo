//
//  NSString+YHAdd.m
//  CatagoryTestDemo
//
//  Created by hu on 16/1/28.
//  Copyright © 2016年 redye. All rights reserved.
//

#import "NSString+YHAdd.h"

NSString * const kName = @"Name";

@implementation NSString (YHAdd)

- (NSUInteger)count {
    return self.length;
}

- (void)setName:(NSString *)name {
    objc_setAssociatedObject(self, (__bridge const void *)(kName), name, OBJC_ASSOCIATION_COPY);
}

- (NSString *)name {
    return objc_getAssociatedObject(self, (__bridge const void *)(kName));
}


@end
