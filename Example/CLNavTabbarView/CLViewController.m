//
//  CLViewController.m
//  CLNavTabbarView
//
//  Created by Cflower8889 on 10/09/2018.
//  Copyright (c) 2018 Cflower8889. All rights reserved.
//

#import "CLViewController.h"
#import "CLNavTabBarView.h"
#import <YYKit/YYKit.h>
@interface CLViewController ()<UIScrollViewDelegate>
@property(nonatomic,strong)UIScrollView     *contentView;

@property(nonatomic,strong)CLNavTabBarView  *navTabbarView;
@end

@implementation CLViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    self.navTabbarView = [[CLNavTabBarView alloc]initWithFrame:CGRectMake(0, 44, self.view.width, 50)];
    self.navTabbarView.titleArray = @[@"item1",@"item2",@"item3"];
    self.navTabbarView.selectIndex   = 2;
    __weak typeof(self)weakSelf = self;
    self.navTabbarView.selectBlock = ^(NSInteger itemTag) {
        [UIView animateWithDuration:.5 animations:^{
            [weakSelf.contentView setContentOffset:CGPointMake(weakSelf.contentView.width*itemTag, 0) animated:YES];
        }];
    };
    [self.view addSubview:self.navTabbarView];
    
    [self.view addSubview:self.contentView];
    
    NSArray *colorArray = @[[UIColor yellowColor],[UIColor cyanColor],[UIColor purpleColor]];
    
    for (NSInteger index = 0; index < 3; index++) {
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(index*self.contentView.width, 0, self.contentView.width, self.contentView.height)];
        view.backgroundColor = colorArray[index];
        [self.contentView addSubview:view];
    }
    [self.contentView setContentOffset:CGPointMake(self.navTabbarView.selectIndex*self.contentView.width, 0) animated:YES];
    [self.contentView setContentSize:CGSizeMake(self.contentView.width*3, 0)];
}

#pragma mark - scrollViewDelegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    CGFloat pageWidth = scrollView.frame.size.width;
    int page = floor((scrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
    if (self.navTabbarView.selectIndex != page) {
        self.navTabbarView.selectIndex  = page;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - lazy load
- (UIScrollView *)contentView
{
    if (!_contentView) {
        _contentView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 44 + 50, self.view.width, self.view.height - 44 - 50)];
        _contentView.pagingEnabled      = YES;
        _contentView.delegate           = self;
        _contentView.showsVerticalScrollIndicator   = NO;
        _contentView.showsHorizontalScrollIndicator = NO;
    }
    
    return _contentView;
}
@end
