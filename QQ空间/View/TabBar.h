//
//  TabBar.h
//  QQ空间
//
//  Created by heew on 15/8/9.
//  Copyright (c) 2015年 adhx. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TabBar;
@protocol TabBarDelegate <NSObject>

- (void)tabBarClick:(TabBar *)tabBar
          fromIndex:(NSInteger)from
            toIndex:(NSInteger)to;

@end

@interface TabBar : UIView
@property (nonatomic, strong) id <TabBarDelegate> delegate; /**代理 */
- (void)rotateToLandscape:(BOOL)isLandscape; // 告知TabBar目前屏幕的方向
- (void)unSelected; // 让SelectItem变成不选中
@end


@interface TabbarItem : UIButton

@end