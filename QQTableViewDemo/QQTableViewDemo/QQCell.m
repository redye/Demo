//
//  QQCell.m
//  QQTableViewDemo
//
//  Created by hu on 16/1/15.
//  Copyright © 2016年 redye. All rights reserved.
//

#import "QQCell.h"
#import "YHKit.h"

#define kQQCellMargin 12
#define kQQCellSubMargin 5

#define kQQCellFont [UIFont systemFontOfSize:16.0]
#define kQQCellSubFont [UIFont systemFontOfSize:13.0]

#define kQQCellSubColor [UIColor colorWithHexString:@"#636363"]

#define kQQCellBadgeTextPadding 5
#define kQQCellButtonTextPadding 16

#define kQQCellHeight 66

#pragma mark -
#pragma mark ============ QQContentView  ==============
@interface QQContentView : UIView
@property (nonatomic, strong) UIImageView   *avtarImageView;
@property (nonatomic, strong) UILabel       *nameLabel;
@property (nonatomic, strong) UILabel       *noteLabel;
@property (nonatomic, strong) UIImageView   *honorImageView;
@property (nonatomic, strong) UILabel       *contentLabel;
@property (nonatomic, strong) UILabel       *timeLabel;
@property (nonatomic, strong) UILabel       *badgeLabel;
@property (nonatomic, strong) QQMessage     *message;
@property (nonatomic, assign) QQCellType     type;
@end

@implementation QQContentView
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    [self setUI];
    return self;
}

- (void)setUI {
    self.backgroundColor = [UIColor whiteColor];
    _avtarImageView = [[UIImageView alloc] initWithFrame:CGRectMake(kQQCellMargin, 0, 50, 50)];
    _avtarImageView.top = 8;
    _avtarImageView.image = [[UIImage imageNamed:@"defaultAvtar"] imageByRoundCornerRadius:200];
    [self addSubview:_avtarImageView];
    
    _nameLabel = [UILabel new];
    _nameLabel.font = kQQCellFont;
    [self addSubview:_nameLabel];
    
    _noteLabel = [UILabel new];
    _noteLabel.hidden = YES;
    _noteLabel.font = kQQCellFont;
    _noteLabel.textColor = kQQCellSubColor;
    [self addSubview:_noteLabel];
    
    _honorImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 16, 16)];
    _honorImageView.hidden = YES;
    _honorImageView.contentMode = UIViewContentModeScaleAspectFit;
    [self addSubview:_honorImageView];
    
    _contentLabel = [UILabel new];
    _contentLabel.textColor = kQQCellSubColor;
    _contentLabel.font = [UIFont systemFontOfSize:13.0];
    [self addSubview:_contentLabel];
    
    _timeLabel = [UILabel new];
    _timeLabel.textAlignment = NSTextAlignmentRight;
    _timeLabel.font = kQQCellSubFont;
    _timeLabel.textColor = kQQCellSubColor;
    [self addSubview:_timeLabel];
    
    _badgeLabel = [UILabel new];
    _badgeLabel.textColor = [UIColor whiteColor];
    _badgeLabel.backgroundColor = [UIColor redColor];
    _badgeLabel.textAlignment = NSTextAlignmentCenter;
    _badgeLabel.font = [UIFont systemFontOfSize:10.0];
    [self addSubview:_badgeLabel];
}

- (void)layout {
    _timeLabel.size = [_message.timeString sizeWithFont:_timeLabel.font];
    _timeLabel.right = self.width - kQQCellMargin;
    
    if (!_badgeLabel.hidden) {
        _badgeLabel.height = 20;
        CGFloat width = [_badgeLabel.text sizeWithFont:_badgeLabel.font].width + 2 * kQQCellBadgeTextPadding;
        _badgeLabel.width = width < _badgeLabel.height ? _badgeLabel.height : width;
        _badgeLabel.right = _timeLabel.right;
        _badgeLabel.layer.cornerRadius = _badgeLabel.height / 2;
        _badgeLabel.layer.masksToBounds = YES;
    }
    
    CGFloat width = 0;
    if (!_noteLabel.hidden) {
        _noteLabel.size = [_noteLabel.text sizeWithFont:_noteLabel.font];
        width += _noteLabel.size.width;
    }
    
    if (!_honorImageView.hidden) {
        width += _honorImageView.size.width;
        width += kQQCellSubMargin;
    }
    
    CGSize nameSize = [_nameLabel.text sizeWithFont:_nameLabel.font];
    CGFloat nameWidth = nameSize.width;
    CGFloat availableWidth = self.timeLabel.left - kQQCellMargin - width - kQQCellMargin;
    if (nameWidth > availableWidth) {
        nameWidth = availableWidth;
    }
    _nameLabel.size = CGSizeMake(nameWidth, nameSize.height);
    _nameLabel.top = self.top + kQQCellMargin;
    _nameLabel.left = _avtarImageView.right + kQQCellMargin;
    _timeLabel.centerY = _nameLabel.centerY;
    _badgeLabel.top = _timeLabel.bottom + kQQCellSubMargin;
    
    _noteLabel.left = self.nameLabel.right + 3;
    _noteLabel.centerY = self.nameLabel.centerY;
    _noteLabel.size = [_noteLabel.text sizeWithFont:_noteLabel.font];
    
    _honorImageView.left = self.nameLabel.right + kQQCellSubMargin;
    _honorImageView.centerY = self.nameLabel.centerY;
    
    _contentLabel.left = _nameLabel.left;
    _contentLabel.top = _nameLabel.bottom + kQQCellSubMargin;
    _contentLabel.height = [_contentLabel.text sizeWithFont:_contentLabel.font].height;
    CGFloat rightAvailable = (_badgeLabel.hidden ? 2 * kQQCellMargin : _badgeLabel.width + 3 * kQQCellMargin);
    CGFloat contentWidth = self.width - _contentLabel.left - rightAvailable;
    _contentLabel.width = contentWidth;
    
}

- (void)setMessage:(QQMessage *)message {
    _message = message;
    
    _nameLabel.text = message.name;
    _contentLabel.text = message.content;
    _timeLabel.text = message.timeString;
    if (message.count <= 0) {
        _badgeLabel.hidden = YES;
    } else if (message.count <= 99) {
        _badgeLabel.text = [NSString stringWithFormat:@"%d", (int)message.count];
        _badgeLabel.hidden = NO;
    } else {
        _badgeLabel.text = @"99+";
        _badgeLabel.hidden = NO;
    }
    if (message.isGroup) {
        _noteLabel.hidden = NO;
        _noteLabel.text = @"(5)";
    } else {
        _noteLabel.hidden = YES;
    }
    if (message.isHasHonor) {
        _honorImageView.hidden = NO;
        _honorImageView.image = [UIImage imageNamed:@"honor"];
    } else {
        _honorImageView.hidden = YES;
    }
    [self layout];
}

- (void)setType:(QQCellType)type {
    _type = type;
    if (type == QQCellTypeNormal) {
    
    } else if (QQCellTypeVIP) {
    
    } else {
        
    }
}

@end

#pragma mark -
#pragma mark ============ QQControlView  =============

typedef void(^QQCellButtonDidClickedBlock)(QQCellSlideType slideType);

@interface QQControlView : UIView
@property (nonatomic, strong) UIButton      *deleteButton;
@property (nonatomic, strong) UIButton      *readButton;
@property (nonatomic, strong) UIButton      *stickButton;
@property (nonatomic, assign) QQCellSlideType slideType;
@property (nonatomic, copy) QQCellButtonDidClickedBlock  buttonClickedBlock;

@end


@implementation QQControlView
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    [self setUI];
    return self;
}

- (void)setUI {
    NSString *buttonTitle = @"删除";
    _deleteButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _deleteButton.backgroundColor = [UIColor colorWithHexString:@"#ff3b27"];
    [_deleteButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_deleteButton setTitle:buttonTitle forState:UIControlStateNormal];
    [_deleteButton addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_deleteButton];
    CGFloat width = [buttonTitle sizeWithFont:_deleteButton.titleLabel.font].width + 2 * kQQCellButtonTextPadding;
    _deleteButton.size = CGSizeMake(width, self.height);
    _deleteButton.top = self.top;
    _deleteButton.right = self.right;
    
    buttonTitle = @"标为已读";
    _readButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _readButton.backgroundColor = [UIColor colorWithHexString:@"#ff9c00"];
    [_readButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_readButton setTitle:@"标为已读" forState:UIControlStateNormal];
    [_readButton setTitle:@"标为未读" forState:UIControlStateSelected];
    [_readButton addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_readButton];
    width = [buttonTitle sizeWithFont:_readButton.titleLabel.font].width + 2 * kQQCellButtonTextPadding;
    _readButton.size = CGSizeMake(width, self.height);
    _readButton.top = self.top;
    _readButton.right = _deleteButton.left;
    
    buttonTitle = @"置顶";
    _stickButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _stickButton.backgroundColor = [UIColor colorWithHexString:@"#c8c7cc"];
    [_stickButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_stickButton setTitle:@"置顶" forState:UIControlStateNormal];
    [_stickButton setTitle:@"取消置顶" forState:UIControlStateSelected];
    [_stickButton addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_stickButton];
    width = [buttonTitle sizeWithFont:_stickButton.titleLabel.font].width + 2 * kQQCellButtonTextPadding;
    _stickButton.size = CGSizeMake(width, self.height);
    _stickButton.top = self.top;
    _stickButton.right = _readButton.left;
}

- (void)buttonClick:(UIButton *)button {
    button.selected = !button.selected;
    if (button == _deleteButton) {
        self.slideType = QQCellSlideTypeDelete;
    } else if (button == _readButton) {
        self.slideType = button.selected ? QQCellSlideTypeReaded : QQCellSlideTypeUnReaded;
    } else {
        self.slideType = button.selected ? QQCellSlideTypeSticked : QQCellSlideTypeUnSticked;
    }
    self.buttonClickedBlock(self.slideType);
}

- (void)setSlideType:(QQCellSlideType)slideType {
    _slideType = slideType;
    switch (slideType) {
        case QQCellSlideTypeReaded: {
            self.readButton.selected = YES;
        }
            break;
            
        case QQCellSlideTypeUnReaded: {
            self.readButton.selected = NO;
        }
            break;

        case QQCellSlideTypeSticked: {
            self.stickButton.selected = YES;
        }
            break;

            
        case QQCellSlideTypeUnSticked: {
            self.stickButton.selected = NO;
        }
            break;

            
        default:
            break;
    }
    [self layout];
}

- (void)layout {
    NSString *buttonTitle = _stickButton.selected ? @"取消置顶" : @"置顶";
    CGFloat width = [buttonTitle sizeWithFont:_stickButton.titleLabel.font].width + 2 * kQQCellButtonTextPadding;
    _stickButton.size = CGSizeMake(width, self.height);
    _stickButton.top = self.top;
    _stickButton.right = _readButton.left;

}

@end

#pragma mark -
#pragma mark =============== QQCell  ===============

#define kMaxRightMargin [self maxRightMargin]
#define kAnimationDuration 0.1f
#define kBounceOffsetX  10

@interface QQCell ()<UIGestureRecognizerDelegate>
@property (nonatomic, strong) QQContentView     *qqContentView;
@property (nonatomic, strong) QQControlView     *qqControlView;
@property (nonatomic, assign) CGPoint            panStartPoint;   // 拖动手势开始的店
@property (nonatomic, assign) CGFloat            contentViewRightMargin;  //内容视图距离右边的距离
@property (nonatomic, assign) BOOL               isOpen;
@end

@implementation QQCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    self.width = [[UIScreen mainScreen] currentBounds].size.width;
    self.height = kQQCellHeight;
    [self setUI];
    return self;
}

- (void)setUI {
    _qqControlView = [[QQControlView alloc] initWithFrame:self.frame];
    _qqControlView.hidden = YES;
    __weak typeof(self) _self = self;
    [_qqControlView setButtonClickedBlock:^(QQCellSlideType slideType){
        [_self closeCell];
        if (_self.delegate && [_self.delegate respondsToSelector:@selector(cell:didChangeSlideType:)]) {
            [_self.delegate cell:_self didChangeSlideType:_self.slideType];
        }
    }];
    [self addSubview:_qqControlView];

    _qqContentView = [[QQContentView alloc] initWithFrame:self.frame];
    [self addSubview:_qqContentView];
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(pan:)];
    pan.delegate = self;
    [_qqContentView addGestureRecognizer:pan];
    
    UIView *line = [UIView new];
    line.backgroundColor = [UIColor colorWithHexString:@"#dedfe0"];
    line.left = _qqContentView.avtarImageView.right + kQQCellMargin;
    line.height = 0.5;
    line.width = self.width - line.left;
    line.bottom = self.bottom;
    [self addSubview:line];

}

- (CGFloat)maxRightMargin {
    return self.qqControlView.right - self.qqControlView.stickButton.left;
}


- (void)pan:(UIPanGestureRecognizer *)pan {
    
    switch (pan.state) {
        case UIGestureRecognizerStateBegan: {
            self.changeStateBlock(self);
            [self show];
            self.panStartPoint = [pan translationInView:self.qqContentView];
            self.contentViewRightMargin = self.right - self.qqContentView.right;
        }
            break;
            
        case UIGestureRecognizerStateChanged: {
            CGPoint currentPoint = [pan translationInView:self.qqContentView];
            CGFloat offsetX = currentPoint.x - self.panStartPoint.x;
            BOOL panningLeft = NO;
            if (currentPoint.x < self.panStartPoint.x) {
                panningLeft = YES;
            }
            
            if (!panningLeft) {
                [self resetRightMarginToZeroWithAnimation:YES notifyBlockDidClose:NO];
            } else {
                if (self.isOpen) {
                    [self resetRightMarginToZeroWithAnimation:YES notifyBlockDidClose:NO];
                } else {
                    CGFloat constant = MIN(-offsetX, kMaxRightMargin);
                    if (constant == kMaxRightMargin) {
                        [self setRightMarginToShowAllWithAnimation:YES notifyBlockDidOpen:NO];
                    } else {
                        self.contentViewRightMargin = constant;
                    }
                }
            }
        }
            break;
            
        case UIGestureRecognizerStateEnded: case UIGestureRecognizerStateCancelled: {
            if (self.contentViewRightMargin >= kMaxRightMargin / 2) {
                [self setRightMarginToShowAllWithAnimation:YES notifyBlockDidOpen:YES];
                self.isOpen = YES;
            } else {
                [self resetRightMarginToZeroWithAnimation:YES notifyBlockDidClose:YES];
                self.isOpen = NO;
            }
        }
            break;
            
        default:
            break;
    }
}

- (void)resetRightMarginToZeroWithAnimation:(BOOL)animated notifyBlockDidClose:(BOOL)isNotify {
    if (isNotify) {
        self.closeBlock(self);
    }

    // 此时 cell 是关闭的状态
    if (self.qqContentView.right == self.right && self.contentViewRightMargin == 0) {
        return;
    }
    
    CGFloat duration = animated ? kAnimationDuration : 0;
    [UIView animateWithDuration:duration animations:^{
        self.contentViewRightMargin = -kBounceOffsetX;
    } completion:^(BOOL finished) {
        [self hidden];
        [UIView animateWithDuration:duration animations:^{
            self.contentViewRightMargin = 0;
        }];
    }];
}

- (void)setRightMarginToShowAllWithAnimation:(BOOL)animated notifyBlockDidOpen:(BOOL)isNotify  {
    if (isNotify) {
        self.openBlock(self);
    }
    // 已经处于完全打开的状态
    if (self.contentViewRightMargin == kMaxRightMargin && self.qqContentView.right == self.right - kMaxRightMargin) {
        return;
    }
    
    CGFloat duration = animated ? kAnimationDuration : 0;
    [UIView animateWithDuration:duration animations:^{
        self.contentViewRightMargin = kMaxRightMargin + kBounceOffsetX;
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:duration animations:^{
            self.contentViewRightMargin = kMaxRightMargin;
        }];
    }];
}

- (void)setContentViewRightMargin:(CGFloat)contentViewRightMargin {
    _contentViewRightMargin = contentViewRightMargin;
    self.qqContentView.right = self.right - self.contentViewRightMargin;
}

- (void)openCell {
    [self setRightMarginToShowAllWithAnimation:YES notifyBlockDidOpen:NO];
}

- (void)closeCell {
    [self resetRightMarginToZeroWithAnimation:YES notifyBlockDidClose:NO];
}

- (void)show {
    self.qqControlView.hidden = NO;
}

- (void)hidden {
    self.qqControlView.hidden = YES;
}

#pragma mark UIGestureRecognizerDelegate
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    return YES;
}

- (void)awakeFromNib {
    
}

- (void)setMessage:(QQMessage *)message {
    _message = message;
    _qqContentView.message = message;
}


- (void)setType:(QQCellType)type {
    _type = type;
//    self.qqContentView.ty
}

@end
