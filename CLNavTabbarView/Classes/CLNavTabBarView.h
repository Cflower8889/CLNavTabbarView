//
//  CLNavTabBarView.h
//  CFPicGame
//
//  Created by chen on 2018/10/9.
//  Copyright © 2018年 chen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CLNavTabBarViewItem.h"

NS_ASSUME_NONNULL_BEGIN

@interface CLNavTabBarView : UIView

/**
 标题数组
 */
@property(nonatomic,copy)NSArray    <NSString *>* titleArray;

/**
 当前选中的item ，默认第0个
 */
@property(nonatomic,assign)NSInteger    selectIndex;

/**
 选中后的回调
 */
@property(nonatomic,copy)itemSelectBlock    selectBlock;

/**
 选中时候线的颜色；默认红色
 */
@property(nonatomic,copy)UIColor        *selectLineColor;

/**
 未选中时候的线的颜色； 默认灰色
 */
@property(nonatomic,copy)UIColor        *unselectLineColor;
@end

NS_ASSUME_NONNULL_END
