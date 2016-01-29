//
//  ViewController.m
//  CatagoryTestDemo
//
//  Created by hu on 16/1/28.
//  Copyright © 2016年 redye. All rights reserved.
//

#import "ViewController.h"
#import "NSString+YHAdd.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSString *string = @"Hello world!";
    string.name = @"ObjC";
    NSLog(@"%d, name = %@", (int)[string count], string.name);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
