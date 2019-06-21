//
//  TTTopChannelContianerView.h
//  MyTTNews
//
//  Created by george on 2019/5/24.
//  Copyright © 2019 com.george. All rights reserved.
// 这是新闻首页上方的新闻频道选择的scrollview

#import <UIKit/UIKit.h>
@protocol TTTopChannelContianerViewDelegate <NSObject>// 协议定义（接口）
@optional

- (void)showOrHiddenAddChannelsCollectionView:(UIButton *)button;
- (void)chooseChannelWithIndex:(NSInteger)index;

@end // 协议定义结束
// 外部可用
@interface TTTopChannelContianerView : UIView// 屏幕上矩形区域

- (instancetype)initWithFrame:(CGRect)frame;
- (void)addAChannelButtonWithChannelName:(NSString *)channelName;
- (void)selectChannelButtonWithIndex:(NSInteger)index;
- (void)deleteChannelButtonWithIndex:(NSInteger)index;

//- (void)didShowEditChannelView:(BOOL)value;

@property (nonatomic, strong) NSArray *channelNameArray;
@property (nonatomic, weak) UIScrollView *scrollView;
//@property (nonatomic, weak) UIButton *addButton;
@property (nonatomic, weak) id<TTTopChannelContianerViewDelegate> delegate;

@end

