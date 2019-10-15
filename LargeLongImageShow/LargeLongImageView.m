//
//  LargeLongImageView.m
//  LargeLongImageShow
//
//  Created by huangjian on 2019/10/14.
//  Copyright © 2019 huangjian. All rights reserved.
//

#import "LargeLongImageView.h"
#import <SDWebImageManager.h>

@interface LargeLongImageView ()
{
    UIImage* image;
    CGRect imageRect;
    CGFloat imageScale_w;
    CGFloat imageScale_h;
}
@end

@implementation LargeLongImageView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

-(void)setLargeLongImage:(UIImage *)largeLongImage{
    _largeLongImage = largeLongImage;
    image = largeLongImage;
    
    imageRect = CGRectMake(0.0f,
                           0.0f,
                           CGImageGetWidth(image.CGImage),
                           CGImageGetHeight(image.CGImage));
    imageScale_w = self.frame.size.width/imageRect.size.width;
    imageScale_h = self.frame.size.height/imageRect.size.height;
    CATiledLayer *tiledLayer = (CATiledLayer *)[self layer];
    
    int scale = (int)MAX(1/imageScale_w, 1/imageScale_h);
    tiledLayer.levelsOfDetail = 1;
    tiledLayer.levelsOfDetailBias = ceil(scale);
    CGSize tileSize = self.bounds.size;
    tileSize.width /=2;
    tileSize.height /=2;
    tiledLayer.tileSize = tileSize;//影响切片多少
}

-(void)setImageUrl:(NSString *)imageUrl completion:(void(^)(void))completion{
    
    [[SDWebImageManager sharedManager]loadImageWithURL:[NSURL URLWithString:imageUrl] options:SDWebImageQueryMemoryData progress:nil completed:^(UIImage * _Nullable image, NSData * _Nullable data, NSError * _Nullable error, SDImageCacheType cacheType, BOOL finished, NSURL * _Nullable imageURL) {
        if (finished && !error && image) {
            dispatch_async(dispatch_get_main_queue(), ^{
                //根据图片size 修正 frame
                self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, image.size.height*(self.frame.size.width/image.size.width));
                [self setLargeLongImage:image];
                !completion?:completion();
            });
        }
    }];
}


+ (Class)layerClass {
    return [CATiledLayer class];
}

- (void)drawRect:(CGRect)rect {
    
    @autoreleasepool{
        CGRect imageCutRect = CGRectMake(rect.origin.x / imageScale_w,
                                         rect.origin.y / imageScale_h,
                                         rect.size.width / imageScale_w,
                                         rect.size.height / imageScale_h);
        CGImageRef imageRef = CGImageCreateWithImageInRect(image.CGImage, imageCutRect);
        UIImage *tileImage = [UIImage imageWithCGImage:imageRef];
        CGContextRef context = UIGraphicsGetCurrentContext();
        UIGraphicsPushContext(context);
        [tileImage drawInRect:rect];
        CGImageRelease(imageRef);
        UIGraphicsPopContext();
    }
    
}
@end
