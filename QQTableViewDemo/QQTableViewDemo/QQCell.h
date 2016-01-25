//
//  QQCell.h
//  QQTableViewDemo
//
//  Created by hu on 16/1/15.
//  Copyright © 2016年 redye. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QQMessage.h"

typedef NS_ENUM(NSUInteger, QQCellSlideType) {
    QQCellSlideTypeDelete        = 1 << 0,
    QQCellSlideTypeUnSticked     = 1 << 1,
    QQCellSlideTypeSticked       = 1 << 2,
    QQCellSlideTypeUnReaded      = 1 << 3,
    QQCellSlideTypeReaded        = 1 << 4
};


typedef NS_ENUM(NSUInteger, QQCellType) {
    QQCellTypeNormal,
    QQCellTypeVIP,
    QQCellTypeOther
};

@class QQCell;

@protocol QQCellDelegate <NSObject>

@optional
- (void)cell:(QQCell *)cell didChangeSlideType:(QQCellSlideType)slideType;
@end


typedef void(^CellDidChangeStateBlock)(QQCell *cell);
typedef void(^CellDidCloseBlock)(QQCell *cell);
typedef void(^CellDidOpenBlock)(QQCell *cell);

@interface QQCell : UITableViewCell

@property (nonatomic, assign) id <QQCellDelegate> delegate;

@property (nonatomic, strong) QQMessage         *message;
@property (nonatomic, assign) QQCellType         type;
@property (nonatomic, assign) QQCellSlideType    slideType;

@property (nonatomic, copy) CellDidChangeStateBlock changeStateBlock;
@property (nonatomic, copy) CellDidCloseBlock        closeBlock;
@property (nonatomic, copy) CellDidOpenBlock         openBlock;

- (void)openCell;
- (void)closeCell;
@end
