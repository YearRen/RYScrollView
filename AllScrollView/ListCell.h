//
//  ListCell.h
//  AllScrollView
//
//  Created by RoZ on 2018/6/8.
//  Copyright © 2018年 RoZ. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ListCellDelegate <NSObject>

- (void)deleteIndexPath:(NSIndexPath *)indexPath;

@end

@interface ListCell : UICollectionViewCell

@property (nonatomic, strong) NSIndexPath *indexPath;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@property (nonatomic, weak) id <ListCellDelegate> delegate;

@end
