//
//  TTNavigationController.h
//  MyTTNews
//
//  Created by george on 2019/5/23.
//  Copyright © 2019 com.george. All rights reserved.
//

#import <UIKit/UIKit.h>

// 容器类，放UIViewController
@interface TTNavigationController : UINavigationController

-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated;

@end
