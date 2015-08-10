//
//  BottonMenu.m
//  QQ空间
//
//  Created by heew on 15/8/9.
//  Copyright (c) 2015年 adhx. All rights reserved.
//

#import "BottomMenu.h"


#pragma mark - TabbarItem类

@implementation BottomMenu

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setupBottomMenuItemWithImageName:@"tabbar_mood"
                                          type:kBottomMenuTypeMood];
        [self setupBottomMenuItemWithImageName:@"tabbar_photo"
                                          type:kBottomMenuTypePhoto];
        [self setupBottomMenuItemWithImageName:@"tabbar_blog"
                                          type:kBottomMenuTypeBlog];
    }
    return self;
}

/**
 *  设置底部菜单栏按钮方法
 */
- (void)setupBottomMenuItemWithImageName:(NSString *)imageName
                                    type:(BottomMenuType)type {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    button.tag = type;
    [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchDown];
    [self addSubview:button];
}

- (void)buttonClick:(UIButton *)button {
    if ([self.delegate respondsToSelector:@selector(bottomMenu:type:)]) {
        [self.delegate bottomMenu:self type:(BottomMenuType)button.tag];
    }
}

- (void)rotateToLandscape:(BOOL)isLandscape {
    NSInteger count = self.subviews.count;
    CGFloat buttonMenuH = isLandscape ? kDockItemHeight : count * kDockItemHeight;
    
    // 自身的约束
    [self updateConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.equalTo(self.superview);
        make.height.equalTo(buttonMenuH);
    }];
    
    // 刷新约束,取得最新自身宽高
    [self layoutIfNeeded];
    CGFloat bottomMenuW = self.viewWidth;
    CGFloat bottomMenuH = self.viewHeight;
    
    
    // 横竖屏 由于约束的second对象不同,必须要remake
    if (isLandscape) {
        for (int i = 0; i < count; i++) {
            UIButton *button = self.subviews[i];
            CGFloat leftMaginRatio = i / (CGFloat)count;
            
            // 上下和父控件对齐
            // 宽分割父控件宽
            // 左边根据左距离比例设置
            [button remakeConstraints:^(MASConstraintMaker *make) {
                make.top.bottom.equalTo(self);
                make.width.equalTo(self.width).dividedBy(count);
                make.left.equalTo(self.left).offset(leftMaginRatio * bottomMenuW);
            }];
        };
    } else {
        for (int i = 0; i < count; i++) {
            UIButton *button = self.subviews[i];
            CGFloat topMaginRatio = i / (CGFloat)count;
            
            // 左右和父控件对齐
            // 高度分割父控件高度
            // 顶部根据顶部距离比例设置
            [button remakeConstraints:^(MASConstraintMaker *make) {
                make.left.right.equalTo(self);
                make.height.equalTo(self.height).dividedBy(count);
                make.top.equalTo(self.top).offset(topMaginRatio * bottomMenuH);
            }];
        };
    }
    
}
@end
