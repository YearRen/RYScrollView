//
//  AllCollectionCell.m
//  AllScrollView
//
//  Created by RoZ on 2018/6/8.
//  Copyright © 2018年 RoZ. All rights reserved.
//

#import "AllCollectionCell.h"

#import "ItemCell.h"
#import "CarInfoModel.h"

#define kCount 30

@implementation AllCollectionCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.tableView.dataSource = self;
    self.tableView.bounces = NO;
    UINib *nib = [UINib nibWithNibName:NSStringFromClass([ItemCell class]) bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:NSStringFromClass([ItemCell class])];
}

//- (void)layoutSubviews {
//    [super layoutSubviews];
//    
//    self.tableView.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
//}

- (void)setIndexPath:(NSIndexPath *)indexPath {
    
    _indexPath = indexPath;
    [self.tableView reloadData];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.listTableViewDataArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    GroupParams *groupParams = [self.listTableViewDataArray objectAtIndex:section];
    return groupParams.paramList.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 40;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 40)];
    view.backgroundColor = [UIColor clearColor];
    return view;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ItemCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([ItemCell class]) forIndexPath:indexPath];
    CarInfoModel *model = [self.dataArray objectAtIndex:self.indexPath.row];
    GroupParams *groupParams = [model.groupParamsViewModelList objectAtIndex:indexPath.section];
    Params *params = [groupParams.paramList objectAtIndex:indexPath.row];
    cell.titleLabel.text = params.paramValue;

    return cell;
}

@end
