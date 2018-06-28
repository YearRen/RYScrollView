//
//  ViewController.m
//  AllScrollView
//
//  Created by RoZ on 2018/6/7.
//  Copyright © 2018年 RoZ. All rights reserved.
//

#import "ViewController.h"
#import "TestView.h"
#import "CarInfoModel.h"
#import "MJExtension.h"
#import "AllCollectionCell.h"
#import "AppDelegate.h"

@interface ViewController () <UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property (strong, nonatomic) TestView *testView;

@property (nonatomic, strong) UICollectionViewFlowLayout *flowLayout;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.

    [self.view addSubview:self.testView];
    
    NSDictionary *dic = [self readLocalFileWithName:@"1529993409429"];
    
    NSArray *array = [CarInfoModel mj_objectArrayWithKeyValuesArray:[dic objectForKey:@"data"]];
    self.testView.dataArray = array;
    
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    appDelegate.allowRotation = YES;
    self.edgesForExtendedLayout = UIRectEdgeNone;
}

// 是否支持自动转屏
- (BOOL)shouldAutorotate {
    
    return YES;
}

// 支持哪些屏幕方向
- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskAllButUpsideDown ;
}

// 默认的屏幕方向（当前ViewController必须是通过模态出来的UIViewController（模态带导航的无效）方式展现出来的，才会调用这个方法）
- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation {
    return UIInterfaceOrientationPortrait;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 40;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    AllCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([AllCollectionCell class]) forIndexPath:indexPath];
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {

    return CGSizeMake([UIScreen mainScreen].bounds.size.width, 50);
}

- (BOOL)prefersStatusBarHidden {
    return NO;
}

- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator {
    [super viewWillTransitionToSize:size withTransitionCoordinator:coordinator];

    [self.testView.allCollectionViewFlowLayout invalidateLayout];
}

// 读取本地JSON文件
- (NSDictionary *)readLocalFileWithName:(NSString *)name {
    // 获取文件路径
    NSString *path = [[NSBundle mainBundle] pathForResource:name ofType:@"json"];
    // 将文件数据化
    NSData *data = [[NSData alloc] initWithContentsOfFile:path];
    // 对数据进行JSON格式化并返回字典形式
    return [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    self.testView.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
    
}

- (TestView *)testView {
    
    if (_testView == nil) {
        _testView = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([TestView class]) owner:self
                                                 options:nil] lastObject];
    }
    return _testView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
