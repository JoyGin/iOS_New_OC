//
//  NewsViewController.m
//  MyTTNews
//
//  Created by george on 2019/5/23.
//  Copyright © 2019 com.george. All rights reserved.
//  新闻：viewController
//

#import "NewsViewController.h"
#import <DKNightVersion.h>
#import "TTTopChannelContianerView.h"
#import "ContentTableViewController.h"

@interface NewsViewController ()<UIScrollViewDelegate,TTTopChannelContianerViewDelegate>
@property (nonatomic, strong) NSMutableArray *currentChannelsArray;
@property (nonatomic, weak) TTTopChannelContianerView *topContianerView;
@property (nonatomic, strong) NSArray *arrayLists;
@property (nonatomic, weak) UIScrollView *contentScrollView;

@end

@implementation NewsViewController

#pragma mark -- 从plist获取的数组
- (NSArray *)arrayLists
{
    if (_arrayLists == nil) {
        _arrayLists = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle]pathForResource:@"NewsURLs.plist" ofType:nil]];
    }
    return _arrayLists;
}

#pragma mark --初始视图加载后调用viewDidLoad中的安装程序
-(void) viewDidLoad {
    // 滑动视图内容自动偏移，不会被UINavigationBar与UITabBar遮挡
    self.automaticallyAdjustsScrollViewInsets = NO;
    // 第三方扩充了 UIView的方法
    self.view.dk_backgroundColorPicker = DKColorPickerWithRGB(0xf0f0f0, 0x000000,0xfafafa);// 背景色白色
    self.navigationController.navigationBar.dk_barTintColorPicker = DKColorPickerWithRGB(0xfa5054,0x444444,0xfa5054);// bar 红色
    [self setupTopContianerView];
    [self setupChildController];
    [self setupContentScrollView];
}

#pragma mark --private Method--初始化上方的新闻频道选择的View
- (void)setupTopContianerView{
    // Y轴高度
    CGFloat top = CGRectGetMaxY(self.navigationController.navigationBar.frame);
    TTTopChannelContianerView *topContainerView = [[TTTopChannelContianerView alloc] initWithFrame:CGRectMake(0, top, [UIScreen mainScreen].bounds.size.width, 30)];
    // 数据源
    topContainerView.channelNameArray = self.currentChannelsArray;
    self.topContianerView = topContainerView;
    topContainerView.delegate = self;
    [self.view addSubview:topContainerView];
}

#pragma mark --private Method--初始化子控制器
- (void) setupChildController{
    for (NSInteger i=0; i<self.currentChannelsArray.count; i++) {
        ContentTableViewController *viewController = [[ContentTableViewController alloc] init];
        viewController.title = self.arrayLists[i][@"title"];
        viewController.urlString = self.arrayLists[i][@"urlString"];
        [self addChildViewController:viewController];
        
    }
}
#pragma mark --private Method--初始化相应新闻内容的scrollView
- (void) setupContentScrollView{
    UIScrollView *contentScrollView = [[UIScrollView alloc] init];
    self.contentScrollView = contentScrollView;
    contentScrollView.frame = self.view.bounds;
    contentScrollView.contentSize = CGSizeMake(contentScrollView.frame.size.width* self.currentChannelsArray.count, 0);
    contentScrollView.pagingEnabled = YES;
    contentScrollView.delegate = self;
    [self.view insertSubview:contentScrollView atIndex:0];
    [self scrollViewDidEndScrollingAnimation:contentScrollView];
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
    if (scrollView == self.contentScrollView) {
        NSInteger index = scrollView.contentOffset.x/self.contentScrollView.frame.size.width;
        ContentTableViewController *vc = self.childViewControllers[index];
        vc.view.frame = CGRectMake(scrollView.contentOffset.x, 0, self.contentScrollView.frame.size.width, self.contentScrollView.frame.size.height);
        vc.tableView.contentInset = UIEdgeInsetsMake(CGRectGetMaxY(self.navigationController.navigationBar.frame)+self.topContianerView.scrollView.frame.size.height, 0, self.tabBarController.tabBar.frame.size.height, 0);
        [scrollView addSubview:vc.view];
        for (int i = 0; i<self.contentScrollView.subviews.count; i++) {
            NSInteger currentIndex = vc.tableView.frame.origin.x/self.contentScrollView.frame.size.width;
            if ([self.contentScrollView.subviews[i] isKindOfClass:[UITableView class]]) {
                UITableView *theTableView = self.contentScrollView.subviews[i];
                NSInteger theIndex = theTableView.frame.origin.x/self.contentScrollView.frame.size.width;
                NSInteger gap = theIndex - currentIndex;
                if (gap<=2&&gap>=-2) {
                    continue;
                } else {
                    [theTableView removeFromSuperview];
                }
            }
            
        }
        
    }
}

#pragma mark --private Method--存储更新后的currentChannelsArray到偏好设置中
-(NSMutableArray *)currentChannelsArray{
    if (!_currentChannelsArray) {
        if(!_currentChannelsArray){
            _currentChannelsArray = [NSMutableArray arrayWithObjects:@"头条",@"NBA",@"手机",@"移动互联",@"娱乐",@"时尚",@"电影",@"科技", nil];
        }
    }
    return _currentChannelsArray;
}

#pragma mark --UIScrollViewDelegate-- 滑动的减速动画结束后会调用这个方法
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    if (scrollView == self.contentScrollView) {
        [self scrollViewDidEndScrollingAnimation:scrollView];
        NSInteger index = scrollView.contentOffset.x/self.contentScrollView.frame.size.width;
        [self.topContianerView selectChannelButtonWithIndex:index];
    }
}

#pragma mark --TTTopChannelContianerViewDelegate--选择了某个新闻频道，更新scrollView的contenOffset
- (void) chooseChannelWithIndex:(NSInteger)index{
    [self.contentScrollView setContentOffset:CGPointMake(self.contentScrollView.frame.size.width*index, 0) animated:YES];
}

#pragma mark --在内存警告的情况下调用
- (void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
}

- (CGSize) collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat kDeviceWith = [UIScreen mainScreen].bounds.size.width;
    CGFloat kMargin = 10;
    return CGSizeMake((kDeviceWith - 5*kMargin)/4, 40);
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}

@end
