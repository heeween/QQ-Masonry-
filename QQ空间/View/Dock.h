//
//  dock.h
//  QQ空间
//
//  Created by heew on 15/8/9.
//  Copyright (c) 2015年 adhx. All rights reserved.
//

#import <UIKit/UIKit.h>
@class BottomMenu,TabBar,IconButton;
@interface Dock : UIView
@property (nonatomic, weak, readonly) BottomMenu *bottomMenu; /**底部菜单栏 */
@property (nonatomic, weak, readonly) TabBar *tabBar; /**中部菜单栏 */
@property (nonatomic, weak, readonly) IconButton *iconButton; /**顶部头像 */
- (void)rotateToLandscape:(BOOL)isLandscape; // 告知Dock目前屏幕的方向
@end
