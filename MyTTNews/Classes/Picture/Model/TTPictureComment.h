//
//  TTPictureComment.h
//  MyTTNews
//
//  Created by george on 2019/6/5.
//  Copyright © 2019 com.george. All rights reserved.
//

#import <Foundation/Foundation.h>

@class TTPictureUser;

@interface TTPictureComment : NSObject<NSCoding>

@property (nonatomic, copy) NSString *ID;
@property (nonatomic, copy) NSString *voiceUrl;
/** 音频文件的时长 */
@property (nonatomic, assign) NSInteger voicetime;
/** 评论的文字内容 */
@property (nonatomic, copy) NSString *content;
/** 被点赞的数量 */
@property (nonatomic, assign) NSInteger like_count;
/** 用户 */
@property (nonatomic, strong) TTPictureUser *user;

@end
