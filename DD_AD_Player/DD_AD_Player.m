//
//  DD_AD_Player.m
//  DD_AD_Player
//
//  Created by 张小冬 on 15/12/26.
//  Copyright © 2015年 dadong. All rights reserved.
//

#import "DD_AD_Player.h"
#import "UIImageView+WebCache.h"
@interface DD_AD_Player()<UIScrollViewDelegate>
/**
 *  播放的视图
 */
@property (nonatomic,weak) UIScrollView *player ;
/**
 *  滚动图上的小圆点
 */
@property (nonatomic,weak) UIPageControl *pageControll ;
/**
 *  定时器
 */
@property (nonatomic,strong) NSTimer *timer ;
/**
 *  一共有多少张图片，用于从最后一张跳到第一张使用的
 */
@property (nonatomic,assign) NSUInteger imageCount ;
@end
@implementation DD_AD_Player
- (instancetype)initWithFrame:(CGRect)frame imageUrls:(NSArray <NSString *> *)imageUrls
{
    if (self = [super initWithFrame:frame]) {
        if (imageUrls&&imageUrls.count>0) {
            self.imageCount = imageUrls.count ;
            [self setupWithUrls:(NSArray <NSString *> *)imageUrls];
        }
    }
    return self ;
}
- (void) setupWithUrls:(NSArray <NSString *> *)imageUrls
{
    CGFloat width = self.bounds.size.width ;
    CGFloat height = self.bounds.size.height ;
    UIScrollView *s = [[UIScrollView alloc]initWithFrame:self.bounds] ;
    self.player = s;
    self.player.contentSize = CGSizeMake(width * imageUrls.count, height);
    self.player.pagingEnabled = YES ;
    self.player.bounces = NO;
    self.player.delegate = self ;
    self.player.showsHorizontalScrollIndicator = NO;
    [self addSubview:self.player];
    
    //滚动中添加图片
    [imageUrls enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        //
        UIImageView *imageView =[[UIImageView alloc]init];
        [imageView sd_setImageWithURL:[NSURL URLWithString:obj] placeholderImage:nil];
        CGFloat x = idx * width;
        imageView.frame = CGRectMake(x, 0, width, height);
        UIGestureRecognizer *recognizer = [[UIGestureRecognizer alloc]initWithTarget:self action:@selector(tapImageView:)];
        [imageView addGestureRecognizer:recognizer];
        imageView.userInteractionEnabled = YES ;
        imageView.tag = 1024 + idx ;
        [self.player addSubview:imageView];
    }];
    
    //添加小圆点
    CGFloat centerX = width/2 ;
    CGFloat centerY = height - 5 ;
    UIPageControl *pageControll = [[UIPageControl alloc]init] ;
    self.pageControll = pageControll;
    self.pageControll.center = CGPointMake(centerX, centerY) ;
    [self addSubview:self.pageControll];
    self.pageControll.numberOfPages = imageUrls.count ;
    self.pageControll.currentPage = 0 ;
    self.pageControll.currentPageIndicatorTintColor = [UIColor orangeColor];//设置当前页的小圆点颜色
//    self.pageControll.pageIndicatorTintColor = [UIColor orangeColor];//会出现当前点和下一个运动的点两点
}

- (void)tapImageView:(UIGestureRecognizer *)recognizer
{
    if (_delegate &&[_delegate respondsToSelector:@selector(AD_Player:tapImageViewWithIndex:)]) {
        UIView *view = recognizer.view ;
        NSInteger index = view.tag - 1024 ;
        [_delegate AD_Player:self tapImageViewWithIndex:index];
    }
}
- (void)nextPage
{
    NSUInteger i = self.pageControll.currentPage ;
    if (i == self.imageCount-1) {
        i = 0 ;
    }else{
        i ++ ;
    }
    self.player.contentOffset = CGPointMake(i * self.bounds.size.width, 0);
}

#pragma mark - ScrollView的代理方法
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    [self startTimer];
}
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self removeTimer];
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat w = scrollView.frame.size.width ;
    NSUInteger index = floor((scrollView.contentOffset.x + w/2)/w );
    self.pageControll.currentPage = index ;
}

- (void)startTimer
{
    NSTimeInterval t = self.timerInterval ;
    if (!t){
        t = 3.0 ; //如果不设置时间，默认是3秒跳一次
    }
    self.timer = [NSTimer scheduledTimerWithTimeInterval:t target:self selector:@selector(nextPage) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
}

- (void)removeTimer
{
    [self.timer invalidate];
    self.timer = nil ;
}

- (void)setTimerInterval:(NSTimeInterval)timerInterval
{
    _timerInterval = timerInterval ;
    [self removeTimer];
    [self startTimer];
}
@end
