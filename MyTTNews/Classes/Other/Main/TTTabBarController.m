//
//  TTTabBarController.m
//  MyTTNews
//
//  Created by george on 2019/5/23.
//  Copyright © 2019 com.george. All rights reserved.
//

#import "TTTabBarController.h"
#import "MeTableViewController.h"
#import "NewsViewController.h"
#import "PictureViewController.h"
#import "VideoViewController.h"
#import "TTNavigationController.h"
// 换肤
#import <DKNightVersion.h>
#import "TTConst.h"
#import <SDImageCache.h>

// 导航
@interface TTTabBarController ()<MeTableViewControllerDelegate>{
    MeTableViewController *_MeController;// 我的vc
}

@property (nonatomic, assign) BOOL isShakeCanChangeSkin;

@end

@implementation TTTabBarController


#pragma mark --private Method-- tab：新闻、图片、视频、我的
- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 设置底部导航 图片按钮
    NewsViewController *vc1 = [[NewsViewController alloc] init];
    [self addChildViewController:vc1 withImage:[UIImage imageNamed:@"tabbar_news"] selectedImage:[UIImage imageNamed:@"tabbar_news_hl"] withTittle:@"新闻"];
    
    PictureViewController *vc2 = [[PictureViewController alloc] init];
    [self addChildViewController:vc2 withImage:[UIImage imageNamed:@"tabbar_picture"] selectedImage:[UIImage imageNamed:@"tabbar_picture_hl"] withTittle:@"图片"];
    
    VideoViewController *vc3 = [[VideoViewController alloc] init];
    [self addChildViewController:vc3 withImage:[UIImage imageNamed:@"tabbar_video"] selectedImage:[UIImage imageNamed:@"tabbar_video_hl"] withTittle:@"视频"];
    
    MeTableViewController *vc4 = [[MeTableViewController alloc] init];
    _MeController = vc4;
    [self addChildViewController:vc4 withImage:[UIImage imageNamed:@"tabbar_setting"] selectedImage:[UIImage imageNamed:@"tabbar_setting_hl"] withTittle:@"我的"];
    
    vc4.delegate = self;
    
    [self setupBasic];
}

#pragma mark --private Method-- 换肤，键盘设置，摇一摇
-(void)setupBasic{
    if([self.dk_manager.themeVersion isEqualToString:DKThemeVersionNormal]){// 白天
        self.tabBar.barTintColor = [UIColor whiteColor];
    }else{// 夜晚
        self.tabBar.barTintColor = [UIColor colorWithRed:34/255.0 green:34/255.0
                                                    blue:34/255.0
                                                    alpha:1.0];
    }
    // 运行的应用程序集中控制和协调点，触发撤销重做
    [UIApplication sharedApplication].applicationSupportsShakeToEdit = YES;
    // 键盘相关
    [self becomeFirstResponder];
    // 根据key获取preference中的value
    self.isShakeCanChangeSkin = [[NSUserDefaults standardUserDefaults] boolForKey:IsShakeCanChangeSkinKey];
    
}

#pragma mark --private Method-- 添加底部tab--》vc
// 参数：带：和不带
- (void)addChildViewController:(UIViewController *)controller withImage:(UIImage *)image selectedImage:(UIImage *)selectImage withTittle:(NSString *)tittle{
     TTNavigationController *nav = [[TTNavigationController alloc] initWithRootViewController:controller];
    [nav.tabBarItem setImage:image];// 底部导航图片
    [nav.tabBarItem setSelectedImage:selectImage];// 选中的
    controller.title =tittle;// 底部导航title
    // 选中的title标记为红色
    [nav.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor redColor]} forState:UIControlStateSelected];
    nav.tabBarItem.titlePositionAdjustment=UIOffsetMake(0, -3);
    // 添加子控制器
    [self addChildViewController:nav];
}

#pragma mark --private Method-- 这个类被release、对象的retain count为0或者说一个对象被设置为nil的时候调用
- (void)dealloc{
}

#pragma mark --private Method-- 系统自带的传感器 摇一摇 换肤
- (void)motionBegan:(UIEventSubtype)motion withEvent:(UIEvent *)event{
    if (motion == UIEventSubtypeMotionShake) {
        if (self.isShakeCanChangeSkin == NO) return;
        if ([self.dk_manager.themeVersion isEqualToString:DKThemeVersionNormal]) {// 将要切换到夜间模式
            self.dk_manager.themeVersion = DKThemeVersionNight;// 颜色模式-夜间
            self.tabBar.barTintColor = [UIColor colorWithRed:34/255
                                                       green:34/255
                                                        blue:34/255
                                                       alpha:1];
            _MeController.changeSkinSwitch.on = YES;// 开关
        }else{
            self.dk_manager.themeVersion = DKThemeVersionNormal;// 颜色模式-白天
            self.tabBar.barTintColor = [UIColor whiteColor];
            _MeController.changeSkinSwitch.on = NO;
        }
    }
}

// 属性值修改
- (void)shakeCanChangeSkin:(BOOL)status{
    self.isShakeCanChangeSkin = status;
}

// 收到内存警告
- (void)didReceiveMemoryWarning{
    [[SDImageCache sharedImageCache] clearDisk];// 清理图片缓存
}
@end
