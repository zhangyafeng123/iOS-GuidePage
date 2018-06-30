//
//  ZYFFeatureCell.h
//  广告页自定义
//
//  Created by linjianguo on 2018/6/30.
//  Copyright © 2018年 com.justsee. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZYFFeatureCell : UICollectionViewCell

/**
 imageView
 */
@property (nonatomic, strong) UIImageView *nfImageView;
/**
 隐藏新特性按钮点击回调
 */
@property(nonatomic, copy) dispatch_block_t hideButtonClickBlock;
/**
 跳过图片素材
 */
@property (nonatomic, strong) NSString *hideBtnImg;

/**
 用来获取页码
 */
-(void)dc_GetCurrentPageIndex:(NSInteger)currentIndex lastPageIndex:(NSInteger)lastIndex;

@end
