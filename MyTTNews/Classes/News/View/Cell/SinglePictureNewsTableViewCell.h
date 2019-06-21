//
//  SinglePictureNewsTableViewCell.h
//  MyTTNews
//
//  Created by george on 2019/5/27.
//  Copyright © 2019 com.george. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SXNewsEntity.h"

@interface SinglePictureNewsTableViewCell : UITableViewCell
@property (nonatomic, strong) NSArray *pictureArray;
@property (nonatomic, copy) NSString *imageUrl;
@property (nonatomic, copy) NSString *contentTittle;
@property (nonatomic, copy) NSString *desc;
@property (weak, nonatomic) IBOutlet UIImageView *iconImage;
@property (weak, nonatomic) IBOutlet UILabel *LblTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *subTitleLabel;

@end
