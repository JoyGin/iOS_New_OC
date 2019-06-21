//
//  ContentTableViewController.h
//  MyTTNews
//
//  Created by george on 2019/5/24.
//  Copyright © 2019 com.george. All rights reserved.
//

#import <UIKit/UIKit.h>
@class TTNormalNews;

NS_ASSUME_NONNULL_BEGIN

@interface ContentTableViewController : UITableViewController

@property(nonatomic, strong) TTNormalNews *news;
@property (nonatomic, copy) NSString *channelId;
@property (nonatomic, copy) NSString *channelName;
@property(nonatomic,copy) NSString *urlString;
@property (nonatomic,assign) NSInteger index;

@end

NS_ASSUME_NONNULL_END
