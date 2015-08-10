//
//  BottonMenu.h
//  QQ空间
//
//  Created by heew on 15/8/9.
//  Copyright (c) 2015年 adhx. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef enum {
    kBottomMenuTypeMood,
    kBottomMenuTypePhoto,
    kBottomMenuTypeBlog,
}BottomMenuType;
@class BottomMenu;
@protocol BottomMenuDelegate <NSObject>

- (void)bottomMenu:(BottomMenu *)bottomMenu type:(BottomMenuType)type;

@end
@interface BottomMenu : UIView
@property (nonatomic, weak) id <BottomMenuDelegate> delegate; /**代理 */
// 告知BottomMenu目前屏幕的方向
- (void)rotateToLandscape:(BOOL)isLandscape;
@end
