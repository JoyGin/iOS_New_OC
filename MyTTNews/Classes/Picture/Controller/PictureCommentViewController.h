//
//  PictureCommentViewController.h
//  MyTTNews
//
//  Created by george on 2019/6/5.
//  Copyright © 2019 com.george. All rights reserved.
//

#import <UIKit/UIKit.h>
@class TTPicture;

NS_ASSUME_NONNULL_BEGIN

@interface PictureCommentViewController : UIViewController

/** 帖子模型 */
@property (nonatomic, strong) TTPicture *picture;

@end

NS_ASSUME_NONNULL_END
