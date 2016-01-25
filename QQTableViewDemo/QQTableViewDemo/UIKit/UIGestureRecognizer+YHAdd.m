//
//  UIGestureRecognizer+YHAdd.m
//  QQTableViewDemo
//
//  Created by hu on 16/1/22.
//  Copyright © 2016年 redye. All rights reserved.
//

#import "UIGestureRecognizer+YHAdd.h"
#import "YHKitMacro.h"
#import <objc/runtime.h>

static const int block_key;

@interface _YHUIGestureRecognizerBlockTarget : NSObject

@property (nonatomic, copy) void (^block)(id sender);

- (id)initWithBlock:(void(^)(id sender))block;
- (void)invoke:(id)sender;
@end

@implementation _YHUIGestureRecognizerBlockTarget

- (id)initWithBlock:(void (^)(id))block {
    self = [super init];
    if (self) {
        _block = [block copy];
    }
    return self;
}

- (void)invoke:(id)sender {
    if (_block) _block(sender);
}

@end

YHSYNTH_DUMMY_CLASS(UIGestureRecognizer_YHAdd)
@implementation UIGestureRecognizer (YHAdd)

- (instancetype)initWithActionBlock:(void (^)(id))block {
    self = [self init];
    [self addActionBlock:block];
    return self;
}

- (void)addActionBlock:(void (^)(id))block {
    _YHUIGestureRecognizerBlockTarget *target = [[_YHUIGestureRecognizerBlockTarget alloc] initWithBlock:block];
    [self addTarget:target action:@selector(invoke:)];
    NSMutableArray *targets = [self _yh_allUIGestureRecognizerBlockTarget];
    [targets addObject:target];
}

- (void)removeAllActionBlock {
    NSMutableArray *targets = [self _yh_allUIGestureRecognizerBlockTarget];
    [targets enumerateObjectsUsingBlock:^(_YHUIGestureRecognizerBlockTarget *target, NSUInteger idx, BOOL * _Nonnull stop) {
        [self removeTarget:target action:@selector(invoke:)];
    }];
    [targets removeAllObjects];
}

- (NSMutableArray *)_yh_allUIGestureRecognizerBlockTarget{
    NSMutableArray *targets = objc_getAssociatedObject(self, &block_key);
    if (!targets) {
        targets = [NSMutableArray array];
        objc_setAssociatedObject(self, &block_key, targets, OBJC_ASSOCIATION_COPY_NONATOMIC);
    }
    
    return targets;
}

@end
