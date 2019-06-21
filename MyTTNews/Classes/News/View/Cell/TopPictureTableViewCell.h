//
//  TopPictureTableViewCell.h
//  MyTTNews
//
//  Created by george on 2019/5/27.
//  Copyright © 2019 com.george. All rights reserved.
// 新闻：banner picture
//

#import <UIKit/UIKit.h>


@interface TopPictureTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *imgIcon;// 图片
@property (weak, nonatomic) IBOutlet UILabel *LblTitleLabel;// 标题

@end
