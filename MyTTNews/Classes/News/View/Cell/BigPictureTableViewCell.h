//
//  BigPictureTableViewCell.h
//  MyTTNews
//
//  Created by george on 2019/5/27.
//  Copyright © 2019 com.george. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface BigPictureTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *LblTitleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *imgIcon;
@property (weak, nonatomic) IBOutlet UILabel *subTitleLabel;

@end
