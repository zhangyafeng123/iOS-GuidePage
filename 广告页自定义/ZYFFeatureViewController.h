//
//  ZYFFeatureViewController.h
//  广告页自定义
//
//  Created by linjianguo on 2018/6/30.
//  Copyright © 2018年 com.justsee. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZYFFeatureViewController : UIViewController

/**
 图片数组
 是否跳过
 选择小圆点的颜色
 是否展示小圆点
 基础设置
 */
- (void)setUpFeatureAttribute:(void(^)(NSArray **imageArray,UIColor **selColor,BOOL *showSkip,BOOL *showPageCount))BaseSettingBlock;
/** 或者 **/
- (void)setupFeatureAttributeNewMethod:(NSArray *)imageArr color:(UIColor *)selColor isShowSkip:(BOOL )showSkip isShowPageCount:(BOOL)showpageCount;








@end
