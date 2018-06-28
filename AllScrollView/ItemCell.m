//
//  ItemCell.m
//  AllScrollView
//
//  Created by RoZ on 2018/6/8.
//  Copyright © 2018年 RoZ. All rights reserved.
//

#import "ItemCell.h"

@implementation ItemCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setIndexPath:(NSIndexPath *)indexPath {
    
    _indexPath = indexPath;
    self.titleLabel.text = [NSString stringWithFormat:@"item %ld - %ld",self.indexPath.section,indexPath.row];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
