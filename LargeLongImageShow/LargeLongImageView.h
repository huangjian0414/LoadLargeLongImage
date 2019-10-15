//
//  LargeLongImageView.h
//  LargeLongImageShow
//
//  Created by huangjian on 2019/10/14.
//  Copyright © 2019 huangjian. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface LargeLongImageView : UIView
//本地图片
@property(nonatomic,strong)UIImage *largeLongImage;
//网络图片
-(void)setImageUrl:(NSString *)imageUrl completion:(void(^)(void))completion;
@end

NS_ASSUME_NONNULL_END
