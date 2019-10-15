//
//  LargeLongImgViewController.m
//  LargeLongImageShow
//
//  Created by huangjian on 2019/10/14.
//  Copyright © 2019 huangjian. All rights reserved.
//

#import "LargeLongImgViewController.h"
#import "LargeLongImageView.h"
#import <UIImageView+WebCache.h>
@interface LargeLongImgViewController ()
@property(nonatomic,strong)UIImageView *imgView;

@property(nonatomic,strong)UIScrollView *scoll;
@property(nonatomic,strong)LargeLongImageView *largeLongImgView;
@end

@implementation LargeLongImgViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    NSString *imgName = @"img777";//长图
    imgName = @"large_leaves_70mp.jpg";//高清大图
//    UIImage *image = [UIImage imageNamed:imgName];
    UIScrollView *scoll = [[UIScrollView alloc]initWithFrame:self.view.bounds];
//    scoll.contentSize = CGSizeMake(0, image.size.height*(self.view.frame.size.width/image.size.width));
    [self.view addSubview:scoll];
    self.scoll = scoll;
    
    LargeLongImageView *v = [[LargeLongImageView alloc]initWithFrame:self.view.bounds];
    [scoll addSubview:v];
    self.largeLongImgView = v;
    //加载本地大长图
//    v.largeLongImage = image;
    
    __weak __typeof(&*self)weakSelf = self;
    //加载网络长图
    [v setImageUrl:@"http://img.xidu98.com/data/postmsg/f295434b93e11d83ade0ae4796a8521e" completion:^{
        weakSelf.scoll.contentSize = CGSizeMake(0, weakSelf.largeLongImgView.frame.size.height);
    }];
    
}



@end
