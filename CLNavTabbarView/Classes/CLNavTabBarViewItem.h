//
//  CLNavTabBarViewItem.h
//  CFPicGame
//
//  Created by chen on 2018/10/9.
//  Copyright © 2018年 chen. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^itemSelectBlock)(NSInteger itemTag);

@interface CLNavTabBarViewItem : UIView

/**
 标题
 */
@property(nonatomic,copy)NSString   *titleString;

/**
 标题大小，默认16
 */
@property(nonatomic,copy)UIFont     *titleFont;
/**
 选择后的标题颜色、默认绿色
 */
@property(nonatomic,copy)UIColor    *selectColor;

/**
 未选中时候的标题颜色，默认灰色
 */
@property(nonatomic,copy)UIColor    *unselectColor;

/**
 选中状态，默认NO
 */
@property(nonatomic,assign)BOOL     isSelect;

@property(nonatomic,copy)itemSelectBlock    block;
@end

NS_ASSUME_NONNULL_END
