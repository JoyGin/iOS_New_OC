//
//  MeTableViewController.h
//  MyTTNews
//
//  Created by george on 2019/5/23.
//  Copyright © 2019 com.george. All rights reserved.
//

#import <UIKit/UIKit.h>

// 协议(接口)
@protocol MeTableViewControllerDelegate <NSObject>
@optional
- (void)shakeCanChangeSkin:(BOOL)status;

@end

@interface MeTableViewController : UITableViewController

@property(nonatomic, weak) id<MeTableViewControllerDelegate> delegate;
@property(nonatomic, weak) UISwitch *changeSkinSwitch;

@end
