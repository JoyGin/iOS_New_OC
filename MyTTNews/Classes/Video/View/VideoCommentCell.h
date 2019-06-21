//
//  VideoCommentCell.h
//  MyTTNews
//
//  Created by george on 2019/6/13.
//  Copyright © 2019 com.george. All rights reserved.
//

#import <UIKit/UIKit.h>
@class TTVideoComment;

NS_ASSUME_NONNULL_BEGIN

@interface VideoCommentCell : UITableViewCell
/** 评论 */
@property (nonatomic, strong) TTVideoComment *comment;

@end

NS_ASSUME_NONNULL_END
