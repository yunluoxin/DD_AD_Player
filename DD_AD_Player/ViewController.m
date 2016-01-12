//
//  ViewController.m
//  DD_AD_Player
//
//  Created by 张小冬 on 15/12/26.
//  Copyright © 2015年 dadong. All rights reserved.
//

#import "ViewController.h"
#import "DD_AD_Player.h"
#import "UIImageView+WebCache.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSString *url = @"file:///Users/xiaodong/Desktop/3.png";
    NSString *url2 = @"file:///Users/xiaodong/Desktop/2.png";
    NSString *url3 = @"file:///Users/xiaodong/Desktop/1.png";
    DD_AD_Player *AD_Player = [[DD_AD_Player alloc]initWithFrame:CGRectMake(0, 100, self.view.bounds.size.width, 100) imageUrls:@[url,url2,url3]];
    AD_Player.timerInterval = 2 ;
    [self.view addSubview:AD_Player];
    UIImageView *i =  [[UIImageView alloc]init];
    [i sd_setImageWithURL:[NSURL URLWithString:url]];
    [self.view addSubview:i];
    i.frame = CGRectMake(0, 0, 50, 50);
    

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
