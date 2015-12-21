//
//  TableViewController.m
//  TableMove
//
//  Created by hu on 15/12/15.
//  Copyright © 2015年 redye. All rights reserved.
//

#import "TableViewController.h"
#import "TableViewCell.h"

@interface TableViewController ()<UIScrollViewDelegate>

@property (nonatomic, assign) NSInteger lastRow;

@end

@implementation TableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initData];
    
    UINib *nib = [UINib nibWithNibName:@"TableViewCell" bundle:[NSBundle mainBundle]];
    [self.tableView registerNib:nib forCellReuseIdentifier:@"Cell"];
}

- (void)initData
{
    self.lastRow = -1;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 100;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *kCellID = @"Cell";
    TableViewCell *cell = (TableViewCell *)[tableView dequeueReusableCellWithIdentifier:kCellID forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.row = indexPath.row;
    
    __weak typeof(self) safeSelf = self;
    [cell setSwipedBlock:^(NSInteger row){
        [safeSelf showCellOfRow:row];
    }];
    
    if (indexPath.row < 99) {
        cell.badgeLabel.text = [NSString stringWithFormat:@"%d", (int)indexPath.row+1];
    } else {
        cell.badgeLabel.text = @" 99+   ";
    }
    //防止 cell 重用时 cell 的状态处于打开状态；也可在 cell 的 prepareForReuse 方法里 reset cell 的状态
//    if (self.lastRow == indexPath.row) {
//        [cell backToOrginPoint];
//    }
    
    if (indexPath.row % 5 == 0) {
        cell.topRightContraint.constant = 0;
        cell.markReadButton.hidden = YES;
    } else {
        cell.topRightContraint.constant = cell.markReadButton.bounds.size.width;
        cell.markReadButton.hidden = NO;
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.lastRow != -1) {
        TableViewCell *cell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:self.lastRow inSection:0]];
        [cell backToOrginPoint];
        self.lastRow = -1;
        return;
    }
    
    NSLog(@"cell 被点击了");
}

- (void)showCellOfRow:(NSInteger)row
{
    if (self.lastRow != row && self.lastRow != -1) {
        TableViewCell *cell = (TableViewCell *)[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:self.lastRow inSection:0]];
        [cell backToOrginPoint];
    }
    self.lastRow = row;
}

//在将要移动的时候将置顶等按钮收回
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    if (self.lastRow != -1) {
        TableViewCell *lastCell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:self.lastRow inSection:0]];
        [lastCell backToOrginPoint];

        self.lastRow = -1;
    }
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
