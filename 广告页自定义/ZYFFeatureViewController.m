//
//  ZYFFeatureViewController.m
//  广告页自定义
//
//  Created by linjianguo on 2018/6/30.
//  Copyright © 2018年 com.justsee. All rights reserved.
//

#import "ZYFFeatureViewController.h"
#import "ViewController.h"
#import "ZYFFeatureCell.h"

#define ScreenW [UIScreen mainScreen].bounds.size.width
#define ScreenH [UIScreen mainScreen].bounds.size.height
//判断设备是否为iphoneX
#define DCIsiPhoneX ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) : NO)
/** 弱引用 */
#define WEAKSELF __weak typeof(self) weakSelf = self;
@interface ZYFFeatureViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (nonatomic,strong) UICollectionView *collectionView;

@property(nonatomic, copy) NSArray *imageArray;
/**
 是否显示跳过按钮，默认不显示
 */
@property(nonatomic,assign) BOOL showSkip;
/**
 是否显示page小圆点,默认不显示
 */
@property(nonatomic,assign) BOOL showPageCount;

/**
 小圆点选中颜色
 */
@property (nonatomic,strong) UIColor *selColor;
/**
 跳过按钮
 */
@property (nonatomic,strong) UIButton *skipButton;
/**
 page
 */
@property (nonatomic,strong) UIPageControl *pageControl;

@end

static NSString *const ZYFNewFeatureCellID = @"ZYFNewFeatureCellID";

@implementation ZYFFeatureViewController
/**
 懒加载
 */
-(UICollectionView *)collectionView
{
    if (!_collectionView) {
        UICollectionViewFlowLayout *dcFlowLayout = [[UICollectionViewFlowLayout alloc] init];
        /**
         minimumLineSpacing 设置最小行间距，minimumInteritemSpacing 设置同一列中间隔的cell最小间距
         */
        dcFlowLayout.minimumLineSpacing = dcFlowLayout.minimumInteritemSpacing = 0;
        /**
         水平滚动
         */
        dcFlowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:dcFlowLayout];
        _collectionView.delegate  = self;
        _collectionView.dataSource  = self;
        _collectionView.frame = [UIScreen mainScreen].bounds;
        _collectionView.pagingEnabled = YES;
        _collectionView.bounces = NO;
        _collectionView.showsHorizontalScrollIndicator = NO;
        
        [self.view insertSubview:_collectionView atIndex:0];
        [_collectionView registerClass:[ZYFFeatureCell class] forCellWithReuseIdentifier:ZYFNewFeatureCellID];
    }
    return _collectionView;
}
/**
 跳过按钮
 */
- (UIButton *)skipButton
{
    if (!_skipButton) {
        
        _skipButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
        _skipButton.frame = CGRectMake(ScreenW - 85, 30, 65, 30);
        [_skipButton addTarget:self action:@selector(skipButtonClick) forControlEvents:(UIControlEventTouchUpInside)];
        _skipButton.hidden = YES;
        _skipButton.backgroundColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.8];
        _skipButton.layer.cornerRadius = 15;
        _skipButton.layer.masksToBounds = YES;
        [self.view addSubview:_skipButton];
    }
    return _skipButton;
}
-(UIPageControl *)pageControl
{
    if (!_pageControl && _imageArray.count != 0) {
        _pageControl = [[UIPageControl alloc] init];
        _pageControl.numberOfPages = _imageArray.count;
        _pageControl.userInteractionEnabled = NO;
        [_pageControl setPageIndicatorTintColor:[UIColor lightGrayColor]];
        UIColor *currColor = (_selColor == nil) ? [UIColor darkGrayColor] : _selColor;
        [self.pageControl setCurrentPageIndicatorTintColor:currColor];
        _pageControl.frame = CGRectMake(0, ScreenH * 0.95, ScreenW, 35);
        [self.view addSubview:_pageControl];
    }
    return _pageControl;
}
#pragma mark ---- 基础设置 ----
- (void)setUpFeatureAttribute:(void(^)(NSArray **imageArray,UIColor **selColor,BOOL *showSkip,BOOL *showPageCount))BaseSettingBlock
{
    NSArray *imageArray;
    UIColor *selColor;
    
    BOOL showSkip;
    BOOL showPageCount;
    if (BaseSettingBlock) {
        BaseSettingBlock(&imageArray,&selColor,&showSkip,&showPageCount);
        self.imageArray = imageArray;
        self.selColor = selColor;
        self.showSkip = showSkip;
        self.showPageCount = showPageCount;
    }
    
}

- (void)setupFeatureAttributeNewMethod:(NSArray *)imageArr color:(UIColor *)selColor isShowSkip:(BOOL )showSkip isShowPageCount:(BOOL)showpageCount
{
    self.imageArray = imageArr;
    self.selColor = selColor;
    self.showSkip = showSkip;
    self.showPageCount = showpageCount;
}
#pragma mark ---- 是否展示跳过的按钮 ----

- (void)setShowSkip:(BOOL)showSkip
{
    _showSkip = showSkip;
    self.skipButton.hidden = !self.showSkip;
}
#pragma mark ---- 是否展示page小圆点 ----
-(void)setShowPageCount:(BOOL)showPageCount
{
    _showPageCount = showPageCount;
    self.pageControl.hidden = !self.showPageCount;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self.skipButton setTitle:@"跳过" forState:(UIControlStateNormal)];
    self.collectionView.backgroundColor = [UIColor redColor];
    
}
#pragma mark ---- delegate ----
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _imageArray.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ZYFFeatureCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ZYFNewFeatureCellID forIndexPath:indexPath];
    cell.nfImageView.image = (DCIsiPhoneX) ? [UIImage imageNamed:[NSString stringWithFormat:@"%@_x",_imageArray[indexPath.row]]] :[UIImage imageNamed:_imageArray[indexPath.row]];
    cell.hideBtnImg = @"hidden";
    [cell dc_GetCurrentPageIndex:indexPath.row lastPageIndex:_imageArray.count - 1];
    WEAKSELF
    cell.hideButtonClickBlock = ^{
        [weakSelf restoreRootViewController:[[ViewController alloc] init]];
    };
    return cell;
}
#pragma mark ---- UICollectionViewDelegateFlowLayout ----
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(ScreenW, ScreenH);
}
#pragma mark ---- 通过代理让它滑动到最后一页再滑动就切换控制器 ----
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (_imageArray.count < 2) {
        return;//一张图片或者没有直接返回
    }
    _collectionView.bounces = (scrollView.contentOffset.x >(_imageArray.count - 2) * ScreenW) ? YES : NO;
    /** 当滑动到最后一页跳转到主页 **/
    if (scrollView.contentOffset.x > (_imageArray.count -1) * ScreenW) {
        [self restoreRootViewController:[[ViewController alloc] init]];
    }
    //设置page
    _pageControl.currentPage = scrollView.contentOffset.x /ScreenW;
}
- (void)restoreRootViewController:(UIViewController *)rootViewController
{
    [UIView transitionWithView:[UIApplication sharedApplication].keyWindow duration:0.7f options:(UIViewAnimationOptionTransitionCrossDissolve) animations:^{
        /** 返回一个布尔值表示动画是否结束 **/
        BOOL oldState = [UIView areAnimationsEnabled];
        [UIView setAnimationsEnabled:NO];
        [UIApplication sharedApplication].keyWindow.rootViewController = rootViewController;
        /** 参数enabled如果是YES那就激活动画；否则就是NO讨论当动画参数没有被激活那么动画属性的改变将被忽略。默认动画是被激活的 **/
        [UIView setAnimationsEnabled:oldState];
    } completion:^(BOOL finished) {
        
    }];
}


#pragma mark - 跳过点击
- (void)skipButtonClick
{
    [self restoreRootViewController:[[ViewController alloc] init]];
}


@end
