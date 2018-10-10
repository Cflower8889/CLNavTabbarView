//
//  CLNavTabBarView.m
//  CFPicGame
//
//  Created by chen on 2018/10/9.
//  Copyright © 2018年 chen. All rights reserved.
//

#import "CLNavTabBarView.h"
#import <YYKit/YYKit.h>
static NSInteger const kItemViewBaseTag     =   1000;

@interface CLNavTabBarView ()
@property(nonatomic,strong)UIScrollView         *contentView;
/**
 底部未选中的线
 */
@property(nonatomic,strong)UIView       *bottomUnselectLineView;

/**
 底部选中的线
 */
@property(nonatomic,strong)UIView   *bottomSelectLineView;

/**
 选中view的maskView
 */
@property(nonatomic,strong)UIView       *selectLineMaskView;

@end

@implementation CLNavTabBarView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.selectIndex        = 0;
        self.selectLineColor    = [UIColor redColor];
        self.unselectLineColor  = [UIColor grayColor];
        self.backgroundColor    = [UIColor whiteColor];
    }
    return self;
}

- (void)setTitleArray:(NSArray<NSString *> *)titleArray
{
    if (!titleArray||titleArray.count==0) {
        return;
    }
    
    [self removeAllSubviews];
    
    _titleArray = titleArray;
    
    [self addTabbarItem];
}

/**
 添加tabbaritem
 */
- (void)addTabbarItem
{
    [self.contentView removeAllSubviews];
    
    CGFloat width   = self.width / self.titleArray.count;
    self.selectLineMaskView.width   = width;
    
    for (NSString *title in self.titleArray) {
        CLNavTabBarViewItem *item = [[CLNavTabBarViewItem alloc]initWithFrame:CGRectMake(width*[self.titleArray indexOfObject:title], 0,width , self.height)];
        item.tag    = [self.titleArray indexOfObject:title] + kItemViewBaseTag;
        item.titleString    = title;
        __weak typeof(self)weakSelf = self;
        item.block = ^(NSInteger itemTag) {
            weakSelf.selectIndex    = itemTag - kItemViewBaseTag;
            if (weakSelf.selectBlock) {
                weakSelf.selectBlock(itemTag - kItemViewBaseTag);
            }
        };
        
        [self.contentView addSubview:item];
    }
    self.selectIndex    = 0;
    
    [self addSubview:self.contentView];
    [self addSubview:self.bottomUnselectLineView];
    [self addSubview:self.bottomSelectLineView];
}

- (void)setSelectIndex:(NSInteger)selectIndex
{
    
    CLNavTabBarViewItem *oldItem = [self.contentView viewWithTag:_selectIndex + kItemViewBaseTag];
    if (oldItem) {
        oldItem.isSelect    = NO;
    }
    
    CLNavTabBarViewItem *nowItem = [self.contentView viewWithTag:selectIndex + kItemViewBaseTag];
    if (nowItem) {
        nowItem.isSelect    = YES;
    }
    
    _selectIndex    = selectIndex;
    
    [UIView animateWithDuration:.5 animations:^{
        self.selectLineMaskView.left    = selectIndex * nowItem.width;
    }];
}

#pragma mark - lazyload
- (UIScrollView *)contentView
{
    if (!_contentView) {
        _contentView    = [[UIScrollView alloc]initWithFrame:self.bounds];
        _contentView.showsVerticalScrollIndicator   = NO;
        _contentView.showsHorizontalScrollIndicator = NO;
    }
    return _contentView;
}

- (UIView *)bottomUnselectLineView
{
    if (!_bottomUnselectLineView) {
        _bottomUnselectLineView = [[UIView alloc]initWithFrame:CGRectMake(0, self.height - 2, self.width, 2)];
        _bottomUnselectLineView.backgroundColor = self.unselectLineColor;
    }
    return _bottomUnselectLineView;
}

- (UIView *)bottomSelectLineView
{
    if (!_bottomSelectLineView) {
        _bottomSelectLineView = [[UIView alloc]initWithFrame:CGRectMake(0, self.height - 2, self.width, 2)];
        _bottomSelectLineView.backgroundColor = self.selectLineColor;
        _bottomSelectLineView.maskView  = self.selectLineMaskView;
    }
    return _bottomSelectLineView;
}

- (UIView *)selectLineMaskView
{
    if (!_selectLineMaskView) {
        _selectLineMaskView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 0, 2)];
        _selectLineMaskView.backgroundColor = [UIColor whiteColor];
        }
    return _selectLineMaskView;
}
@end
