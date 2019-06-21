//
//  VideoCommentViewController.h
//  MyTTNews
//
//  Created by george on 2019/6/12.
//  Copyright © 2019 com.george. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class TTVideo;
@class VideoTableViewCell;
@interface VideoCommentViewController : UIViewController
/** 帖子模型 */
@property (nonatomic, strong) TTVideo *video;
@end

NS_ASSUME_NONNULL_END
