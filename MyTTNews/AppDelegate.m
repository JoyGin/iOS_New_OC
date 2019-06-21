//
//  AppDelegate.m
//  MyTTNews
//
//  Created by george on 2019/5/23.
//  Copyright © 2019 com.george. All rights reserved.
//

#import "AppDelegate.h"
#import "TTTabBarController.h"
#import "TTConst.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    NSLog(@"ios-AppDelegate-入口");
    [self setupUserDefaults];
    // bounds：屏幕的全部区域
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    // 根视图
    self.window.rootViewController=[[TTTabBarController alloc] init];//主页入口：根控制器替换
    // 让uiWindow显示出来（让窗口成为主窗口 并显示出来），一个应用程序只有一个主窗口
    [self.window makeKeyAndVisible];
    return YES;
}

#pragma mark --private Method--设置preference key-value信息
-(void)setupUserDefaults{
    // 设置-》摇一摇夜间：小数据存储 preference文件夹 plist文件。获取值bool
    BOOL isShakeCanChangeSkin = [[NSUserDefaults standardUserDefaults]
                                 boolForKey:IsShakeCanChangeSkinKey];
    if (!isShakeCanChangeSkin) {
        // 设置key-value NO
        [[NSUserDefaults standardUserDefaults] setObject:@(NO) forKey:IsShakeCanChangeSkinKey];
        [[NSUserDefaults standardUserDefaults] synchronize];// 立即写入
    }
    
    BOOL isDownLoadNoImageIn3G = [[NSUserDefaults standardUserDefaults] boolForKey:IsDownLoadNoImageIn3GKey];
    if (!isDownLoadNoImageIn3G) {
        [[NSUserDefaults standardUserDefaults] setObject:@(NO) forKey:IsDownLoadNoImageIn3GKey];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
    
    NSString *userName = [[NSUserDefaults standardUserDefaults] stringForKey:UserNameKey];
    if (userName==nil) {
        [[NSUserDefaults standardUserDefaults] setObject:@"TTNews" forKey:UserNameKey];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
    
    NSString *userSignature = [[NSUserDefaults standardUserDefaults] stringForKey:UserSignatureKey];
    if (userSignature==nil) {
        [[NSUserDefaults standardUserDefaults] setObject:@"这个家伙很懒,什么也没有留下" forKey:UserSignatureKey];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
