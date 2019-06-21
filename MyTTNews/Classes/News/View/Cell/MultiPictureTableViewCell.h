//
//  MultiPictureTableViewCell.h
//  MyTTNews
//
//  Created by george on 2019/5/27.
//  Copyright © 2019 com.george. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface MultiPictureTableViewCell : UITableViewCell

@property (nonatomic, strong) NSArray *imageUrls;
@property (nonatomic, copy) NSString *theTitle;
@property (nonatomic, copy) NSString *iconImage;

@end
