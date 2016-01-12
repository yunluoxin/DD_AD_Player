//
//  DD_AD_Player.h
//  DD_AD_Player
//
//  Created by 张小东 on 15/12/26.
//  Copyright © 2015年 dadong. All rights reserved.
//

#import <UIKit/UIKit.h>
@class DD_AD_Player;

@protocol DD_AD_PlayerDelegate <NSObject>
@optional
/**
 *  点击了第index张图片时候的操作
 *
 *  @param player 轮播器
 *  @param index  imageView的索引
 */
- (void) AD_Player:(DD_AD_Player *)player tapImageViewWithIndex:(NSInteger )index ;
@end

@interface DD_AD_Player : UIView
/**
 *  代理
 */
@property (nonatomic, weak) id<DD_AD_PlayerDelegate> delegate ;
/**
 *  切换图片的间隔时间
 */
@property (nonatomic, assign) NSTimeInterval timerInterval ;

/**
 *  创建一个轮播器
 *
 *  @param frame     整个轮播器的Frame
 *  @param imageUrls 图片的Url地址数组
 *
 *  @return 一个创建好的轮播器，放在父控件中就好
 */
- (instancetype)initWithFrame:(CGRect)frame imageUrls:(NSArray <NSString *> *)imageUrls ;
@end
