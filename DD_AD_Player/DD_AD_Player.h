//
//  DD_AD_Player.h
//  DD_AD_Player
//
//  Created by 张小冬 on 15/12/26.
//  Copyright © 2015年 dadong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DD_AD_Player : UIView
/**
 *  切换图片的间隔时间
 */
@property (nonatomic, assign) NSTimeInterval timerInterval ;
/**
 *  创建一个轮播器
 *
 *  @param frame     <#frame description#>
 *  @param imageUrls <#imageUrls description#>
 *
 *  @return <#return value description#>
 */
- (instancetype)initWithFrame:(CGRect)frame imageUrls:(NSArray <NSString *> *)imageUrls ;
@end
