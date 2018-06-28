//
//  ListCell.m
//  AllScrollView
//
//  Created by RoZ on 2018/6/8.
//  Copyright © 2018年 RoZ. All rights reserved.
//

#import "ListCell.h"

@implementation ListCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setIndexPath:(NSIndexPath *)indexPath {
    
    _indexPath = indexPath;
}

- (IBAction)deleteClick:(UIButton *)sender {
    
    if ([self.delegate respondsToSelector:@selector(deleteIndexPath:)]) {
        [self.delegate deleteIndexPath:self.indexPath];
    }
}

@end
