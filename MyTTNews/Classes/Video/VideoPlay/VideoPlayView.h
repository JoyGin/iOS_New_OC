//
//  VideoPlayView.h
//  MyTTNews
//
//  Created by george on 2019/6/5.
//  Copyright © 2019 com.george. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

@protocol VideoPlayViewDelegate <NSObject>

@optional
- (void)videoplayViewSwitchOrientation:(BOOL)isFull;

@end

@interface VideoPlayView : UIView

+ (instancetype)videoPlayView;// 声明类方法

@property (weak, nonatomic) id<VideoPlayViewDelegate> delegate;

@property (nonatomic, strong) AVPlayerItem *playerItem;

-(void)suspendPlayVideo;

-(void)resetPlayView;

@end
