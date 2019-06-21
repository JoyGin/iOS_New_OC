//
//  SinglePictureNewsTableViewCell.m
//  MyTTNews
//
//  Created by george on 2019/5/27.
//  Copyright © 2019 com.george. All rights reserved.
// 新闻：item img+content
//

#import "SinglePictureNewsTableViewCell.h"
#import <UIImageView+WebCache.h>
#import <DKNightVersion.h>

@interface SinglePictureNewsTableViewCell()
@property (weak, nonatomic) IBOutlet UIImageView *pictureImageView;
@property (weak, nonatomic) IBOutlet UILabel *newsTittleLabel;
@property (weak, nonatomic) IBOutlet UILabel *commentCount;
@property (weak, nonatomic) IBOutlet UILabel *descLabel;

@property (weak, nonatomic) IBOutlet UIView *separatorLine;
@end

@implementation SinglePictureNewsTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.commentCount.text = [NSString stringWithFormat:@"%d评论",arc4random()%1000];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.dk_backgroundColorPicker = DKColorPickerWithRGB(0xffffff, 0x343434, 0xfafafa);
    self.newsTittleLabel.dk_textColorPicker = DKColorPickerWithKey(TEXT);
    self.commentCount.dk_textColorPicker = DKColorPickerWithKey(TEXT);
    self.descLabel.dk_textColorPicker = DKColorPickerWithKey(TEXT);
    self.separatorLine.dk_backgroundColorPicker = DKColorPickerWithKey(SEP);
    
}

-(void)setImageUrl:(NSString *)imageUrl {
    _imageUrl = imageUrl;
    [self.pictureImageView  sd_setImageWithURL:[NSURL URLWithString:imageUrl]];
}

-(void)setContentTittle:(NSString *)contentTittle {
    _contentTittle = contentTittle;
    self.newsTittleLabel.text = contentTittle;
}

-(void)setDesc:(NSString *)desc {
    _desc = desc;
    self.descLabel.text = desc;
}

@end
