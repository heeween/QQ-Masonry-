//
//  TabBar.m
//  QQ空间
//
//  Created by heew on 15/8/9.
//  Copyright (c) 2015年 adhx. All rights reserved.
//

#import "TabBar.h"
#import "Dock.h"
#import "BottomMenu.h"

const CGFloat kRatio = 0.4;

@interface TabBar ()

@property (nonatomic, weak) TabbarItem *selectedItem; /**记录选中的索引 */
@end

@implementation TabBar

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        // 设置子控件
        [self setupTabBarItemWithImageName:@"tab_bar_feed_icon"
                                     title:@"全部动态"];
        [self setupTabBarItemWithImageName:@"tab_bar_passive_feed_icon"
                                     title:@"与我相关"];
        [self setupTabBarItemWithImageName:@"tab_bar_pic_wall_icon"
                                     title:@"照片墙"];
        [self setupTabBarItemWithImageName:@"tab_bar_e_album_icon"
                                     title:@"电子相框"];
        [self setupTabBarItemWithImageName:@"tab_bar_friend_icon"
                                     title:@"好友"];
        [self setupTabBarItemWithImageName:@"tab_bar_e_more_icon"
                                     title:@"更多"];
    }
    return self;
}


// 设置子控件方法
- (void)setupTabBarItemWithImageName:(NSString *)imageName
                               title:(NSString *)title {
    TabbarItem *item = [TabbarItem buttonWithType:UIButtonTypeCustom];
    UIImage *image = [UIImage imageNamed:imageName];
    UIImage *bgImage = [UIImage imageNamed:@"tabbar_separate_selected_bg"];
    [item setTitle:title
          forState:UIControlStateNormal];
    [item setImage:image
          forState:UIControlStateNormal];
    [item setBackgroundImage:bgImage
                    forState:UIControlStateSelected];
    [item addTarget:self action:@selector(tabBarItemClick:) forControlEvents:UIControlEventTouchDown];
    // 绑定tag
    item.tag = self.subviews.count;
    [self addSubview:item];
}

- (void)tabBarItemClick:(TabbarItem *)item {
    // 1.选中三部曲
    self.selectedItem.selected = NO;
    self.selectedItem = item;
    self.selectedItem.selected = YES;
    if ([self.delegate respondsToSelector:@selector(tabBarClick:fromIndex:toIndex:)]) {
        [self.delegate tabBarClick:self fromIndex:self.selectedItem.tag toIndex:item.tag];
    }
}

// 告知TabBar目前屏幕的方向
- (void)rotateToLandscape:(BOOL)isLandscape {
    
    NSInteger count = self.subviews.count;
    CGFloat tabBarH = count * kDockItemHeight;
    Dock *dock = (Dock *)self.superview;
    
    // 左右和父控件对齐
    // 高度约束根据子控件数量
    // 底部和dock的顶部对齐
    [self updateConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.superview);
        make.height.equalTo(tabBarH);
        make.bottom.equalTo(dock.bottomMenu.top);
    }];

    // 刷新约束,取得最新自身宽高
    [self layoutIfNeeded];
    CGFloat bottomMenuH = self.viewHeight;
    
    //设置子控件约束
    for (int i = 0; i < count; i++) {
        UIButton *button = self.subviews[i];
        
        // 每个角标的button距离顶部的比例
        CGFloat topMaginRatio = i / (CGFloat)count;
        
        // 左右和父控件对齐
        // 高度是父控件高度被count等分
        // 顶部根据刷新父控件高度乘以距离顶部的比例
        [button makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self);
            make.height.equalTo(self.height).dividedBy(count);
            make.top.equalTo(self.top).offset(topMaginRatio * bottomMenuH);
        }];
    };
}

#pragma mark - 让SelectItem变成不选中
- (void)unSelected
{
    self.selectedItem.selected = NO;
}
@end

/**=============================TabbarItem========================= */

@implementation TabbarItem

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.imageView.contentMode = UIViewContentModeCenter;
    }
    return self;
}

- (void)setHighlighted:(BOOL)highlighted{ }


// Button内部空间返回CGRect方式,只能计算x y w h了
- (CGRect)imageRectForContentRect:(CGRect)contentRect
{
    if (self.viewWidth == self.viewHeight) { // 竖屏
        return self.bounds;
    } else { // 横屏
        CGFloat width = self.viewWidth * kRatio;
        CGFloat height = self.viewHeight;
        CGFloat x = 0;
        CGFloat y = 0;
        return CGRectMake(x, y, width, height);
    }
}

- (CGRect)titleRectForContentRect:(CGRect)contentRect
{
    if (self.viewWidth == self.viewHeight) { // 竖屏
        return CGRectMake(0, 0, -1, -1);
    } else { // 横屏
        CGFloat width = self.viewWidth * (1 - kRatio);
        CGFloat height = self.viewHeight;
        CGFloat x = self.viewWidth * kRatio;
        CGFloat y = 0;
        return CGRectMake(x, y, width, height);
    }
}

@end
