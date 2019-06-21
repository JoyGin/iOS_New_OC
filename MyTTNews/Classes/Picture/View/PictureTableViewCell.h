//
//  PictureTableViewCell.h
//  MyTTNews
//
//  Created by george on 2019/5/31.
//  Copyright © 2019 com.george. All rights reserved.
//

#import <UIKit/UIKit.h>
@class TTPicture;

@protocol  PictureTableViewCellDelegate<NSObject>
@optional

-(void)clickMoreButton:(TTPicture *)picture;
-(void)clickCommentButton:(NSIndexPath *)indexPath;

@end

@interface PictureTableViewCell : UITableViewCell

+(instancetype)cell;

@property (nonatomic, strong) TTPicture *picture;
@property (nonatomic, weak) id<PictureTableViewCellDelegate> delegate;
@property (nonatomic, strong) NSIndexPath *indexPath;
@end
