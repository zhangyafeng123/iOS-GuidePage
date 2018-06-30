//
//  ZYFFeatureCell.m
//  广告页自定义
//
//  Created by linjianguo on 2018/6/30.
//  Copyright © 2018年 com.justsee. All rights reserved.
//

#import "ZYFFeatureCell.h"
#define ScreenW [UIScreen mainScreen].bounds.size.width
#define ScreenH [UIScreen mainScreen].bounds.size.height
@interface ZYFFeatureCell()
/** button **/
@property (nonatomic, strong) UIButton *hideButton;
@end

@implementation ZYFFeatureCell

-(instancetype)initWithFrame:(CGRect)frame
{
    if ([super initWithFrame:frame]) {
        
        _nfImageView = [[UIImageView alloc] init];
        [self insertSubview:_nfImageView atIndex:0];
    }
    return self;
}
- (UIButton *)hideButton
{
    if (!_hideButton) {
        _hideButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
        _hideButton.adjustsImageWhenHighlighted = NO;
        _hideButton.hidden = YES;
        [_hideButton addTarget:self action:@selector(hideButtonClick) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_hideButton];
    }
    return _hideButton;
}
#pragma mark ---- super ----
- (void)layoutSubviews
{
    [super layoutSubviews];
    self.nfImageView.frame = self.bounds;
}

- (void)setHideBtnImg:(NSString *)hideBtnImg
{
    _hideBtnImg = hideBtnImg;
    if (hideBtnImg.length != 0) {
        [self.hideButton sizeToFit];//自适应
        [self.hideButton setImage:[UIImage imageNamed:hideBtnImg] forState:(UIControlStateNormal)];
        self.hideButton.center = CGPointMake(ScreenW * 0.5, ScreenH * 0.9);
    }
}

- (void)dc_GetCurrentPageIndex:(NSInteger)currentIndex lastPageIndex:(NSInteger)lastIndex
{
    _hideButton.hidden = (currentIndex == lastIndex) ? NO :YES;//只有当前index和最后index相等时隐藏按钮才显示
    
}
#pragma mark ---- 隐藏点击 ----
- (void)hideButtonClick
{
    !_hideButtonClickBlock ? :_hideButtonClickBlock();
}




@end
