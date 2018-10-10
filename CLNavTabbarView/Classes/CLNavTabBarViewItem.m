//
//  CLNavTabBarViewItem.m
//  CFPicGame
//
//  Created by chen on 2018/10/9.
//  Copyright © 2018年 chen. All rights reserved.
//

#import "CLNavTabBarViewItem.h"
#import <Masonry/Masonry.h>
//#import "Masonry.h"
@interface CLNavTabBarViewItem()
@property(nonatomic,strong)UILabel          *titleLabel;
@property(nonatomic,strong)UIButton         *actionBtn;
@end

@implementation CLNavTabBarViewItem
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.titleFont      = [UIFont systemFontOfSize:16];
        self.selectColor    = [UIColor greenColor];
        self.unselectColor  = [UIColor grayColor];
        self.isSelect       = NO;
        
        [self addSubview:self.titleLabel];
        [self addSubview:self.actionBtn];
        [self configMasonry];
    }
    
    return self;
}

- (void)configMasonry
{
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    
    [self.actionBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
}

- (void)setTitleString:(NSString *)titleString
{
    _titleString = titleString;
    self.titleLabel.text    = titleString;
}

- (void)setIsSelect:(BOOL)isSelect
{
    _isSelect   = isSelect;
    
    self.titleLabel.textColor   = isSelect?self.selectColor:self.unselectColor;
}

#pragma mark - action
- (void)tabbarItemDidSelected:(UIButton *)sender
{
    if (self.block) {
        self.block(self.tag);
    }
}

#pragma mark - lazyLoad
- (UILabel *)titleLabel
{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.textAlignment   = NSTextAlignmentCenter;
        _titleLabel.font            = self.titleFont;
        _titleLabel.textColor       = self.unselectColor;
    }
    return _titleLabel;
}

- (UIButton *)actionBtn
{
    if (!_actionBtn) {
        _actionBtn = [[UIButton alloc]init];
        [_actionBtn setBackgroundColor:[UIColor clearColor]];
        [_actionBtn addTarget:self action:@selector(tabbarItemDidSelected:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _actionBtn;
}

@end
