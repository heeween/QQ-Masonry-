//
//  mainViewController.m
//  QQ空间
//
//  Created by heew on 15/8/9.
//  Copyright (c) 2015年 adhx. All rights reserved.
//

#import "mainViewController.h"
#import "MoodViewController.h"
#import "AllStatusViewController.h"
#import "Dock.h"
#import "TabBar.h"
#import "BottomMenu.h"
#import "IconButton.h"

@interface mainViewController () <BottomMenuDelegate,TabBarDelegate>
@property (nonatomic, weak) Dock *dock; /**左侧菜单栏 */
@property (nonatomic, weak) UIView *contentView; /* 内容的View */
@property (nonatomic, assign) NSInteger currentIndex; /** 当前控制器的下标 */
@end

@implementation mainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = HYWColr(46, 46, 46);
    [self setupDock];
    [self setupControllers];
    [self setupContentView];
    [self iconButtonClick];
}

- (void)setupDock {
    Dock *dock = [[Dock alloc] init];
    [self.view addSubview:dock];
    self.dock = dock;
    
    // 设置代理
    dock.bottomMenu.delegate = self;
    dock.tabBar.delegate = self;
    [dock.iconButton addTarget:self action:@selector(iconButtonClick) forControlEvents:UIControlEventTouchUpInside];
    
    // 设置dock约束
    BOOL isLandscape = self.view.viewWidth == kLandscapeWidth;
    CGFloat dockWidth = isLandscape ? kDockLandscapeWidth : kDockPortraitWidth;
    [dock makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.bottom.equalTo(self.view);
        make.width.equalTo(dockWidth);
    }];
    
    // 更新dock方向
    [self.dock rotateToLandscape:isLandscape];
}

- (void)setupContentView {
    // 设置内容View
    UIView *contentView = [[UIView alloc] init];
    [self.view addSubview:contentView];
    self.contentView = contentView;
    
    // 设置content约束
    [contentView makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.dock.right);
        make.right.top.bottom.equalTo(self.view);
    }];
}

/**
 *  初始化六个控制器
 */
- (void)setupControllers
{
    AllStatusViewController *vc1 = [[AllStatusViewController alloc] init];
    [self packNav:vc1];
    
    UIViewController *vc2 = [[UIViewController alloc] init];
    vc2.view.backgroundColor = [UIColor blackColor];
    [self packNav:vc2];
    
    UIViewController *vc3 = [[UIViewController alloc] init];
    vc3.view.backgroundColor = [UIColor purpleColor];
    [self packNav:vc3];
    
    UIViewController *vc4 = [[UIViewController alloc] init];
    vc4.view.backgroundColor = [UIColor orangeColor];
    [self packNav:vc4];
    
    UIViewController *vc5 = [[UIViewController alloc] init];
    vc5.view.backgroundColor = [UIColor yellowColor];
    [self packNav:vc5];
    
    UIViewController *vc6 = [[UIViewController alloc] init];
    vc6.view.backgroundColor = [UIColor greenColor];
    [self packNav:vc6];
    
    UIViewController *vc7 = [[UIViewController alloc] init];
    vc7.title = @"个人中心";
    vc7.view.backgroundColor = [UIColor lightGrayColor];
    [self packNav:vc7];
}

/**
 *  抽出一个包装导航控制器的方法,并且将他加入到我们的ChildViewControllers里面
 */
- (void)packNav:(UIViewController *)vc
{
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
    [self addChildViewController:nav];
}

#pragma mark - bottomMenu代理方法
- (void)bottomMenu:(BottomMenu *)bottomMenu type:(BottomMenuType)type {
    switch (type) {
        case kBottomMenuTypeMood:
        {
            MoodViewController *moodVc = [[MoodViewController alloc] init];
            UINavigationController *moodNav = [[UINavigationController alloc] initWithRootViewController:moodVc];
            
            // 设置呈现样式
            moodNav.modalPresentationStyle = UIModalPresentationFormSheet;
            
            // 设置过度样式
            moodNav.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
            
            [self presentViewController:moodNav animated:YES completion:nil];
        }
            break;
            
        case kBottomMenuTypePhoto:
            NSLog(@"点击了发表照片");
            break;
            
        case kBottomMenuTypeBlog:
            NSLog(@"点击了发表日志");
            break;
            
        default:
            break;
    }

}


#pragma mark - tabBar代理方法
- (void)tabBarClick:(TabBar *)tabBar fromIndex:(NSInteger)from toIndex:(NSInteger)to {    // 1.取出旧控制器的View,移除掉
    UIViewController *oldVc = self.childViewControllers[from];
    [oldVc.view removeFromSuperview];
    
    // 2.取出新的控制器的View,添加到self.view(控制器的View的autoresizing属性,默认情况是宽度和高度随着父控件拉伸而拉伸)
    UIViewController *newVc = self.childViewControllers[to];
    newVc.view.frame = self.contentView.bounds;
    [self.contentView addSubview:newVc.view];
    
    // 3.记录当前下标
    self.currentIndex = to;
}


- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator {
    
    // 更新dock约束
    BOOL isLandscape = size.width == kLandscapeWidth;
    CGFloat dockWidth = isLandscape ? kDockLandscapeWidth : kDockPortraitWidth;
    [self.dock updateConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(dockWidth);
    }];
    
    // 设置动画
    CGFloat duration = [coordinator transitionDuration];
    [UIView animateWithDuration:duration animations:^{
        [self.dock layoutIfNeeded];
    }];
    
    // 更新dock方向
    [self.dock rotateToLandscape:isLandscape];
}

#pragma mark - 监听IconButton的点击
- (void)iconButtonClick
{
    [self tabBarClick:nil fromIndex:self.currentIndex toIndex:self.childViewControllers.count - 1];
    
    [self.dock.tabBar unSelected];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
