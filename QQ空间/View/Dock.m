//
//  dock.m
//  QQ空间
//
//  Created by heew on 15/8/9.
//  Copyright (c) 2015年 adhx. All rights reserved.
//

#import "Dock.h"
#import "BottomMenu.h"
#import "TabBar.h"
#import "IconButton.h"

@implementation Dock
- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setupBottomMenu];
        [self setupTabBar];
        [self setupIconButton];
    }
    return self;
}

- (void)setupBottomMenu {
    BottomMenu *bottomMenu = [[BottomMenu alloc] init];
    [self addSubview:bottomMenu];
    _bottomMenu = bottomMenu;
}

- (void)setupTabBar {
    TabBar *tabBar = [[TabBar alloc] init];
    [self addSubview:tabBar];
    _tabBar = tabBar;
}

- (void)setupIconButton {
    IconButton *iconButton = [[IconButton alloc] init];
    [self addSubview:iconButton];
    _iconButton = iconButton;
}


// 告知子控件目前屏幕的方向
- (void)rotateToLandscape:(BOOL)isLandscape {
    [self.bottomMenu rotateToLandscape:isLandscape];
    [self.tabBar rotateToLandscape:isLandscape];
    [self.iconButton rotateToLandscape:isLandscape];
}
@end
