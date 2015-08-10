# QQ-Masonry-
##Masonry实现QQ空间自动布局思路
#### 首先设置dock和content的约束
* dock的左\上\下和父控件对齐 宽度随屏幕变化
```objc
    [dock makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.bottom.equalTo(self.view);
        make.width.equalTo(dockWidth);
    }];
```
* content的左对齐dock 右\上\下对齐父控件
```objc
    // 设置content约束
    [contentView makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.dock.right);
        make.right.top.bottom.equalTo(self.view);
    }];
```
* 屏幕旋转后只需对dock更新即可
```objc
    [self.dock updateConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(dockWidth);
    }];
```
#### bottomMenu约束 及其子控件约束 `在这里横竖屏 由于约束的second对象不同,必须要remake`
* bottomMenu约束 左\右\下对齐父控件 高度随屏幕变化
```objc
    [self updateConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.equalTo(self.superview);
        make.height.equalTo(buttonMenuH);
    }];
```
* 子控件约束
* 横屏时 遍历子控件设置约束
```objc
            // 上下和父控件对齐
            // 宽分割父控件宽
            // 左边根据左距离比例设置
            [button remakeConstraints:^(MASConstraintMaker *make) {
                make.top.bottom.equalTo(self);
                make.width.equalTo(self.width).dividedBy(count);
                make.left.equalTo(self.left).offset(leftMaginRatio * bottomMenuW);
            }];
```
* 竖屏时 遍历子控件设置约束
```objc
            // 左右和父控件对齐
            // 高度分割父控件高度
            // 顶部根据顶部距离比例设置
            [button remakeConstraints:^(MASConstraintMaker *make) {
                make.left.right.equalTo(self);
                make.height.equalTo(self.height).dividedBy(count);
                make.top.equalTo(self.top).offset(topMaginRatio * bottomMenuH);
            }];
```
####TabBar约束 及其子控件约束
* 自身约束
```objc
    // 左右和父控件对齐
    // 高度约束根据子控件数量
    // 底部和dock的顶部对齐
    [self updateConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.superview);
        make.height.equalTo(tabBarH);
        make.bottom.equalTo(dock.bottomMenu.top);
    }];
```
* 子控件横竖屏约束一样 遍历设置约束
```objc
        // 左右和父控件对齐
        // 高度是父控件高度被count等分
        // 顶部根据刷新父控件高度乘以距离顶部的比例
        [button makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self);
            make.height.equalTo(self.height).dividedBy(count);
            make.top.equalTo(self.top).offset(topMaginRatio * bottomMenuH);
        }];
```

### iconButton约束  `在这里横竖屏 由于约束的second对象相同,使用update既可`
```objc
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
```
