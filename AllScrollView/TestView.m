//
//  ViewController.m
//  AllScrollView
//
//  Created by RoZ on 2018/6/7.
//  Copyright © 2018年 RoZ. All rights reserved.
//

#import "TestView.h"

#import "ListCell.h"
#import "AllCollectionCell.h"
#import "ListTableCell.h"
#import "CarInfoModel.h"
#import "ListTableViewHeaderView.h"
#import "CompareTableView.h"

#define kCount 30

#define iPhoneX ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? ((NSInteger)(([[UIScreen mainScreen] currentMode].size.height/[[UIScreen mainScreen] currentMode].size.width)*100) == 216) : NO)

@interface TestView () <UITableViewDelegate,UITableViewDataSource,UICollectionViewDelegate,UICollectionViewDataSource,ListCellDelegate,UICollectionViewDelegateFlowLayout>

@property (weak, nonatomic) IBOutlet CompareTableView *listTableView;
@property (weak, nonatomic) IBOutlet UICollectionView *listCollectionView;
@property (weak, nonatomic) IBOutlet UICollectionView *allCollectionView;


@property (nonatomic, strong) NSArray *listTableViewDataArray;

@property (nonatomic) CGFloat listTableY;

@end

@implementation TestView

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.listTableView.dataSource = self;
    self.listTableView.delegate = self;
    self.listCollectionView.dataSource = self;
    self.listCollectionView.delegate = self;
    self.allCollectionView.dataSource = self;
    self.allCollectionView.delegate = self;
    
    [self.listCollectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:NSStringFromClass([UICollectionViewCell class])];
    
    UINib *listNib = [UINib nibWithNibName:NSStringFromClass([ListCell class]) bundle:nil];
    [self.listCollectionView registerNib:listNib forCellWithReuseIdentifier:NSStringFromClass([ListCell class])];
    
    UINib *allNib = [UINib nibWithNibName:NSStringFromClass([AllCollectionCell class]) bundle:nil];
    [self.allCollectionView registerNib:allNib forCellWithReuseIdentifier:NSStringFromClass([AllCollectionCell class])];
    
    UINib *listTableNib = [UINib nibWithNibName:NSStringFromClass([ListTableCell class]) bundle:nil];
    [self.listTableView registerNib:listTableNib forCellReuseIdentifier:NSStringFromClass([ListTableCell class])];
    
    [self.listTableView registerNib:[UINib nibWithNibName:NSStringFromClass([ListTableViewHeaderView class]) bundle:nil] forHeaderFooterViewReuseIdentifier:NSStringFromClass([ListTableViewHeaderView class])];
    
    self.listCollectionView.collectionViewLayout = self.listCollectionViewFlowLayout;
    self.allCollectionView.collectionViewLayout = self.allCollectionViewFlowLayout;
    
    [self.listTableView addObserver:self forKeyPath:@"contentSize" options:NSKeyValueObservingOptionOld | NSKeyValueObservingOptionNew context:nil];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    if ([keyPath isEqualToString:@"contentSize"]) {
        CGSize newSize = [[change objectForKey:NSKeyValueChangeNewKey] CGSizeValue];
        UIBezierPath *path = [UIBezierPath bezierPathWithRect:CGRectMake(0, 100, 100, newSize.height)];
        self.listTableView.path = path;
    }
}

- (void)setDataArray:(NSArray *)dataArray {
    
    _dataArray = dataArray;
    if (dataArray.count) {
        CarInfoModel *model = [dataArray objectAtIndex:0];
        self.listTableViewDataArray = model.groupParamsViewModelList;
    }
    
    [self.listTableView reloadData];
    [self.listCollectionView reloadData];
    [self.allCollectionView reloadData];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    if (scrollView == self.listCollectionView) {
        //头部滚动
        self.allCollectionView.contentOffset = scrollView.contentOffset;
        for (int i = 0; i < self.dataArray.count; i++) {
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:i inSection:0];
            AllCollectionCell *cell = (AllCollectionCell *)[self.allCollectionView cellForItemAtIndexPath:indexPath];
            cell.tableView.contentOffset = self.listTableView.contentOffset;
        }
    } else if (scrollView == self.listTableView) {
        //左侧滚动
        self.listTableY = self.listTableView.contentOffset.y;
        for (int i = 0; i < self.dataArray.count; i++) {
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:i inSection:0];
            AllCollectionCell *cell = (AllCollectionCell *)[self.allCollectionView cellForItemAtIndexPath:indexPath];
            cell.tableView.contentOffset = self.listTableView.contentOffset;
        }
    } else if (scrollView == self.allCollectionView) {
        //内容容器滚动
        self.listCollectionView.contentOffset = self.allCollectionView.contentOffset;
    } else {
        //内容item滚动
        self.listTableView.contentOffset = scrollView.contentOffset;
    }
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

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    ListTableViewHeaderView *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:NSStringFromClass([ListTableViewHeaderView class])];
    GroupParams *groupParams = [self.listTableViewDataArray objectAtIndex:section];
    headerView.titleLabel.text = groupParams.groupName;
    return headerView;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ListTableCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([ListTableCell class]) forIndexPath:indexPath];
    GroupParams *groupParams = [self.listTableViewDataArray objectAtIndex:indexPath.section];
    Params *params = [groupParams.paramList objectAtIndex:indexPath.row];
    cell.titleLabel.text = params.paramName;

    return cell;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (CGSize)collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewLayout *)collectionViewLayout
  sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (collectionView == self.listCollectionView) {
        return CGSizeMake(100, 100);
    }
    CGRect rectOfStatusbar = [[UIApplication sharedApplication] statusBarFrame];
    if (iPhoneX) {
        if ([UIDevice currentDevice].orientation != UIDeviceOrientationPortrait) {
            return CGSizeMake(100, [UIScreen mainScreen].bounds.size.height - rectOfStatusbar.size.height - 100 - 21);
        }
        return CGSizeMake(100, [UIScreen mainScreen].bounds.size.height - rectOfStatusbar.size.height - 100 - 34);
    }
    return CGSizeMake(100, [UIScreen mainScreen].bounds.size.height - rectOfStatusbar.size.height - 100);
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    if (collectionView == self.listCollectionView) {
        ListCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([ListCell class]) forIndexPath:indexPath];
        CarInfoModel *model = [self.dataArray objectAtIndex:indexPath.row];
        cell.titleLabel.text = model.specName;
        cell.delegate = self;
        cell.indexPath = indexPath;
        return cell;
    }
    AllCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([AllCollectionCell class]) forIndexPath:indexPath];
    cell.tableView.delegate = self;
    cell.indexPath = indexPath;
    cell.listTableViewDataArray = self.listTableViewDataArray;
    cell.dataArray = self.dataArray;
    return cell;
}

- (void)deleteIndexPath:(NSIndexPath *)indexPath {
    
    NSMutableArray *array = [self.dataArray mutableCopy];
    [array removeObjectAtIndex:indexPath.row];
    self.dataArray = array;
    [self.allCollectionView reloadData];
}

- (UICollectionViewFlowLayout *)allCollectionViewFlowLayout {
    
    if (_allCollectionViewFlowLayout == nil) {
        _allCollectionViewFlowLayout = [[UICollectionViewFlowLayout alloc] init];
        CGRect rectOfStatusbar = [[UIApplication sharedApplication] statusBarFrame];
        if (iPhoneX) {
            if ([UIDevice currentDevice].orientation != UIDeviceOrientationPortrait) {
                _allCollectionViewFlowLayout.itemSize = CGSizeMake(100, [UIScreen mainScreen].bounds.size.height - rectOfStatusbar.size.height - 100 - 21);
            } else {
                _allCollectionViewFlowLayout.itemSize = CGSizeMake(100, [UIScreen mainScreen].bounds.size.height - rectOfStatusbar.size.height - 100 - 34);
            }
        } else {
            _allCollectionViewFlowLayout.itemSize = CGSizeMake(100, [UIScreen mainScreen].bounds.size.height - rectOfStatusbar.size.height - 100);
        }
        _allCollectionViewFlowLayout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
        _allCollectionViewFlowLayout.minimumLineSpacing = 0;
        _allCollectionViewFlowLayout.minimumInteritemSpacing = 0;
        _allCollectionViewFlowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    }
    return _allCollectionViewFlowLayout;
}

- (UICollectionViewFlowLayout *)listCollectionViewFlowLayout {
    
    if (_listCollectionViewFlowLayout == nil) {
        _listCollectionViewFlowLayout = [[UICollectionViewFlowLayout alloc] init];
        _listCollectionViewFlowLayout.itemSize = CGSizeMake(100, 100);
        _listCollectionViewFlowLayout.minimumLineSpacing = 0;
        _listCollectionViewFlowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    }
    return _listCollectionViewFlowLayout;
}

- (void)dealloc {
    
    [self.listTableView removeObserver:self forKeyPath:@"contentSize"];
}

@end
