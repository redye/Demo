//
//  ViewController.m
//  QQTableViewDemo
//
//  Created by hu on 16/1/15.
//  Copyright © 2016年 redye. All rights reserved.
//

#import "QQMessageViewController.h"
#import "YHKit.h"
#import "QQCell.h"

@interface QQMessageViewController ()<UITableViewDataSource, UITableViewDelegate, UIScrollViewDelegate, QQCellDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *messages;
@end

NSString * const kQQCellId = @"QQCell";
@implementation QQMessageViewController

- (instancetype)init {
    self = [super init];
    _tableView = [UITableView new];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    if ([self respondsToSelector:@selector(setAutomaticallyAdjustsScrollViewInsets:)]) {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    
    [self addMessages];
    
    _tableView.frame = self.view.bounds;
    _tableView.contentInset = UIEdgeInsetsMake(64, 0, 0, 0);
    _tableView.scrollIndicatorInsets = _tableView.contentInset;
    [_tableView registerClass:[QQCell class] forCellReuseIdentifier:kQQCellId];
    [self.view addSubview:_tableView];
    [self.tableView reloadData];
}

- (void)addMessages {
    QQMessage *message = [QQMessage new];
    message.name = @"小明";
    message.content = @"在 Cocoa 中，我们也有一部分 API 需要涉及到类型或者实例的内存尺寸，这时候就可以使用 sizeof 来计算。";
    message.timeString = @"09:00";
    message.count = 5;
    message.isGroup = YES;
    [self.messages addObject:message];
    
    QQMessage *message2 = [[QQMessage alloc] initWithName:@"小红" content:@"在 Cocoa 中，我们也有一部分 API 需要涉及到类型或者实例的内存尺寸，这时候就可以使用 sizeof 来计算。" avtarURL:nil timeString:@"2016-01-03" count:100];
    message2.isHasHonor = YES;
    [self.messages addObject:message2];
    
    QQMessage *message3 = [[QQMessage alloc] initWithName:@"小蓝" content:@"在 Cocoa 中，我们也有一部分 API 需要涉及到类型或者实例的内存尺寸，这时候就可以使用 sizeof 来计算。" avtarURL:nil timeString:@"2016-01-03" count:0];
    message3.isHasHonor = YES;
    [self.messages addObject:message3];
    
    for (int i = 0; i < 20; i ++) {
        QQMessage *message3 = [[QQMessage alloc] initWithName:@"小蓝" content:@"在 Cocoa 中，我们也有一部分 API 需要涉及到类型或者实例的内存尺寸，这时候就可以使用 sizeof 来计算。" avtarURL:nil timeString:@"2016-01-03" count:i];
        message3.isHasHonor = i % 2 == 0 ? YES : NO;
        message3.isGroup = !message3.isHasHonor;
        [self.messages addObject:message3];
    }
    
}

- (NSMutableArray *)messages {
    if (!_messages) {
        _messages = [NSMutableArray new];
    }
    
    return _messages;
}

#pragma mark -
#pragma mark UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.messages count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    QQCell *cell = (QQCell *)[tableView dequeueReusableCellWithIdentifier:kQQCellId forIndexPath:indexPath];
    cell.message = [self.messages objectAtIndex:indexPath.row];
    if ([self.lastIndexPath isEqual:indexPath]) {
        [cell openCell];
    }

    __weak typeof(self) _self = self;
    [cell setChangeStateBlock:^(QQCell *cell){
        [_self closeSomeCell];
    }];
    [cell setCloseBlock:^(QQCell *cell){
        _self.lastIndexPath = nil;
    }];
    [cell setOpenBlock:^(QQCell *cell){
        _self.lastIndexPath = [_self.tableView indexPathForCell:cell];
    }];
    return cell;
}

#pragma mark UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 66;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self closeSomeCell];
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}

- (void)closeSomeCell {
    if (self.lastIndexPath) {
        QQCell *cell = [self.tableView cellForRowAtIndexPath:self.lastIndexPath];
        [cell closeCell];
        self.lastIndexPath = nil;
    }
}

#pragma mark UIScrollViewDelegate
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    if (self.lastIndexPath) {
        QQCell *cell = [self.tableView cellForRowAtIndexPath:self.lastIndexPath];
        [cell closeCell];
        self.lastIndexPath = nil;
    }
}

#pragma mark QQCellDelegate
- (void)cell:(QQCell *)cell didChangeSlideType:(QQCellSlideType)slideType {
    //TODO:

}

@end
