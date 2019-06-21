//
//  VideoTableViewCell.h
//  MyTTNews
//
//  Created by george on 2019/6/5.
//  Copyright © 2019 com.george. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VideoPlayView.h"

@class VideoPlayView;
@class TTVideo;

@protocol  VideoTableViewCellDelegate<NSObject>

@optional

-(void)clickMoreButton:(TTVideo *)video;
-(void)clickVideoButton:(NSIndexPath *)indexPath;
-(void)clickCommentButton:(NSIndexPath *)indexPath;

@end

@interface VideoTableViewCell : UITableViewCell

+(instancetype)cell;

@property (nonatomic, strong) TTVideo *video;
@property (nonatomic, weak) id<VideoTableViewCellDelegate> delegate;
@property (nonatomic, strong) NSIndexPath *indexPath;
@property (nonatomic, weak) VideoPlayView *playView;

@end
