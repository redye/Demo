//
//  TableViewCell.h
//  TableMove
//
//  Created by hu on 15/12/15.
//  Copyright © 2015年 redye. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^CellDidSwipedBlock)(NSInteger row);
@interface TableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *messageLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *badgeLabel;
@property (weak, nonatomic) IBOutlet UIImageView *avtarImageView;
@property (weak, nonatomic) IBOutlet UIButton *markReadButton;
@property (weak, nonatomic) IBOutlet UIButton *topButton;
@property (weak, nonatomic) IBOutlet UIButton *deleteButton;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topRightContraint;

@property (assign, nonatomic) NSInteger row;
@property (copy, nonatomic) CellDidSwipedBlock swipedBlock;

- (void)backToOrginPoint;

@end
