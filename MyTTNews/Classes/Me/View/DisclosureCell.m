//
//  DisclosureCell.m
//  MyTTNews
//
//  Created by george on 2019/6/14.
//  Copyright © 2019 com.george. All rights reserved.
//

#import "DisclosureCell.h"
#import <DKNightVersion.h>

@implementation DisclosureCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:reuseIdentifier];
    if (self) {
        UILabel *label = [[UILabel alloc] init];
        self.leftLabel = label;
        label.frame = CGRectMake(15, 0, 120, self.frame.size.height);
        label.dk_textColorPicker = DKColorPickerWithKey(TEXT);
        [self addSubview:label];
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.dk_backgroundColorPicker = DKColorPickerWithRGB(0xffffff, 0x343434, 0xfafafa);
    }
    return self;
}

@end
