//
//  ItemCell.h
//  AllScrollView
//
//  Created by RoZ on 2018/6/8.
//  Copyright © 2018年 RoZ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ItemCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (nonatomic, strong) NSIndexPath *indexPath;

@end
