//
//  AllCollectionCell.h
//  AllScrollView
//
//  Created by RoZ on 2018/6/8.
//  Copyright © 2018年 RoZ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AllCollectionCell : UICollectionViewCell <UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSIndexPath *indexPath;
@property (nonatomic, strong) NSArray *listTableViewDataArray;
@property (nonatomic, strong) NSArray *dataArray;

@end
