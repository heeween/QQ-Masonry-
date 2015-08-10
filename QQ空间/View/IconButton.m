//
//  IconButton.m
//  QQ空间
//
//  Created by heew on 15/8/9.
//  Copyright (c) 2015年 adhx. All rights reserved.
//

#import "IconButton.h"

@implementation IconButton

- (instancetype)init
{
    self = [super init];
    if (self) {
        UIImage *image = [UIImage imageNamed:@"Easy"];
        [self setImage:image
              forState:UIControlStateNormal];
        [self setTitle:@"小码哥"
              forState:UIControlStateNormal];
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return self;
}

- (void)rotateToLandscape:(BOOL)isLandscape {
    if (isLandscape) {
        // 横屏更新约束 只需要宽高约束为常量值既可
        [self updateConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(kIconButtonY);
            make.centerX.equalTo(self.superview);
            make.width.equalTo(kIconButtonLandscapeWidth);
            make.height.equalTo(kIconButtonLandscapeHeight);
        }];
    }else {
        // 横屏更新约束 只需要宽高约束为常量值既可
        [self updateConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(kIconButtonY);
            make.centerX.equalTo(self.superview);
            make.width.equalTo(kIconButtonPortraitWH);
            make.height.equalTo(kIconButtonPortraitWH);
        }];
    }
} // 告知IconButton目前屏幕的方向


// Button内部空间返回CGRect方式,只能计算x y w h了
- (CGRect)imageRectForContentRect:(CGRect)contentRect
{
    if (self.viewHeight == self.viewWidth) { // 竖屏
        return self.bounds;
    } else { // 横屏
        CGFloat width = self.viewWidth;
        CGFloat height = width;
        CGFloat x = 0;
        CGFloat y = 0;
        return CGRectMake(x, y, width, height);
    }
}

- (CGRect)titleRectForContentRect:(CGRect)contentRect
{
    if (self.viewHeight == self.viewWidth) { // 竖屏
        return CGRectMake(0, 0, -1, -1);
    } else { // 横屏
        CGFloat width = self.viewWidth;
        CGFloat height = kIconButtonLandscapeTitleH;
        CGFloat x = 0;
        CGFloat y = self.viewWidth;
        return CGRectMake(x, y, width, height);
    }
}

@end
