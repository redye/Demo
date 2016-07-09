//
//  BasicViewController.m
//  GradientDemo
//
//  Created by Hu on 16/7/5.
//  Copyright © 2016年 redye. All rights reserved.
//

#import "BasicViewController.h"

typedef NS_ENUM(NSInteger, GradientOrientationStyle) {
    GradientOrientationStyleVertical = 0,
    GradientOrientationStyleHorizontal,
    GradientOrientationStyleArriswise
};

typedef NS_ENUM(NSInteger, GradientShowStyle) {
    GradientShowStylePoint,
    GradientShowStyleLocations
};

@interface BasicViewController ()
@property (weak, nonatomic) IBOutlet UIView *gradientView;
@property (weak, nonatomic) IBOutlet UILabel *locationLabel;
@property (weak, nonatomic) IBOutlet UILabel *ratioLabel;
@property (strong, nonatomic) CAGradientLayer *gradientLayer;
@property (assign, nonatomic) GradientOrientationStyle orientationStyle;
@property (assign, nonatomic) GradientShowStyle showStyle;
@property (assign, nonatomic) CGFloat ratio;
@end

@implementation BasicViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.orientationStyle = GradientOrientationStyleVertical;
    self.ratio = 1;
    
    self.gradientLayer = [self gradientLayer];
    [self.gradientView.layer addSublayer:self.gradientLayer];
    [self parameter];
}

- (IBAction)ratioChanged:(UISlider *)sender {
    self.ratio = sender.value;
    [self updateUI];
}

- (IBAction)orientationChanged:(UISegmentedControl *)sender {
    self.orientationStyle = sender.selectedSegmentIndex;
    [self updateUI];
}

- (IBAction)showStyleChanged:(UISegmentedControl *)sender {
    self.showStyle = sender.selectedSegmentIndex;
    [self updateUI];
}

- (IBAction)colorsChanged:(UISegmentedControl *)sender {
    NSArray *colors = nil;
    switch (sender.selectedSegmentIndex) {
        case 0:
            colors = @[(__bridge id)[UIColor colorWithRed:255 / 255.0 green:225 / 255.0 blue:135 / 255.0 alpha:1].CGColor];
            break;
            
        case 1:
            colors = @[(__bridge id)[UIColor colorWithRed:255 / 255.0 green:225 / 255.0 blue:135 / 255.0 alpha:1].CGColor,
                       (__bridge id)[UIColor colorWithRed:255 / 255.0 green:11 / 255.0 blue:11 / 255.0 alpha:1].CGColor];
            break;

        case 2:
            colors = @[(__bridge id)[UIColor colorWithRed:11/ 255.0 green:247 / 255.0 blue:11 / 255.0 alpha:1].CGColor,
                       (__bridge id)[UIColor colorWithRed:255 / 255.0 green:225 / 255.0 blue:135 / 255.0 alpha:1].CGColor,
                       (__bridge id)[UIColor colorWithRed:255 / 255.0 green:11 / 255.0 blue:11 / 255.0 alpha:1].CGColor];
            break;

        case 3:
            colors = @[(__bridge id)[UIColor colorWithRed:11 / 255.0 green:155 / 255.0 blue:247 / 255.0 alpha:1].CGColor,
                       (__bridge id)[UIColor colorWithRed:11 / 255.0 green:247 / 255.0 blue:11 / 255.0 alpha:1].CGColor,
                       (__bridge id)[UIColor colorWithRed:255 / 255.0 green:225 / 255.0 blue:135 / 255.0 alpha:1].CGColor,
                       (__bridge id)[UIColor colorWithRed:255 / 255.0 green:11 / 255.0 blue:11 / 255.0 alpha:1].CGColor];
            break;

            
        default:
            break;
    }
    self.gradientLayer.colors = colors;
    [self updateUI];
}

- (void)updateUI {
    if (self.showStyle == GradientShowStylePoint) {
        self.gradientLayer.locations = nil;
        self.gradientLayer.startPoint = CGPointMake(0, 0);
        self.gradientLayer.endPoint = [self endPoint];
    } else {
        self.gradientLayer.startPoint = CGPointMake(0, 0);
        self.gradientLayer.endPoint = [self direction];
        self.gradientLayer.locations = [self locations];
    }
    
    [self.gradientView.layer addSublayer:self.gradientLayer];
    [self parameter];
}

- (CGPoint)endPoint {
    CGFloat endX = 1 * self.ratio;
    CGFloat endY = 1 * self.ratio;
    if (self.orientationStyle == GradientOrientationStyleVertical) {
        endX = 0;
    } else if (self.orientationStyle == GradientOrientationStyleHorizontal) {
        endY = 0;
    }
    return CGPointMake(endX, endY);
}

- (CGPoint)direction {
    CGFloat endX = 1;
    CGFloat endY = 1;
    if (self.orientationStyle == GradientOrientationStyleVertical) {
        endX = 0;
    } else if (self.orientationStyle == GradientOrientationStyleHorizontal) {
        endY = 0;
    }
    return CGPointMake(endX, endY);
}

- (NSArray *)locations {
    if (self.gradientLayer.colors.count < 3) {
        CGFloat endLocation = 1 * self.ratio;
        return @[@(0), @(endLocation)];
    } else {
        CGFloat step = 1.0 / self.gradientLayer.colors.count;
        NSMutableArray *locations = @[].mutableCopy;
        for (int i = 0; i < self.gradientLayer.colors.count; i ++) {
            NSNumber *location = @(step * i);
            [locations addObject:location];
        }
        return locations;
    }
}

- (void)parameter {
    NSString *ratio = [NSString stringWithFormat:@"%.2f", self.ratio];
    self.ratioLabel.text = ratio;
    
    NSString *locations = nil;
    if (self.showStyle == GradientShowStylePoint) {
        locations = [NSString stringWithFormat:@"%.2f, %.2f", self.gradientLayer.endPoint.x, self.gradientLayer.endPoint.y];
    } else {
        locations = @"";
        for (NSNumber *location in self.gradientLayer.locations) {
            NSString *str = [NSString stringWithFormat:@"%@\n", location];
            locations = [locations stringByAppendingString:str];
        }
     }
    self.locationLabel.text = locations;
}

- (CAGradientLayer *)gradientLayer {
    if (!_gradientLayer) {
        _gradientLayer = [CAGradientLayer layer];
        NSArray *colors = @[(__bridge id)[UIColor colorWithRed:255 / 255.0 green:225 / 255.0 blue:135 / 255.0 alpha:1].CGColor,
                            (__bridge id)[UIColor colorWithRed:255 / 255.0 green:11 / 255.0 blue:11 / 255.0 alpha:1].CGColor];
        _gradientLayer.colors = colors;
        _gradientLayer.frame = self.gradientView.bounds;
        _gradientLayer.type = @"axial";  //目前只支持 axial(轴向的)
        return _gradientLayer;
    }
    
    return _gradientLayer;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
   
}



@end
