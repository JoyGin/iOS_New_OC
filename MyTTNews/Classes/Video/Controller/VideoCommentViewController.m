//
//  VideoCommentViewController.m
//  MyTTNews
//
//  Created by george on 2019/6/12.
//  Copyright © 2019 com.george. All rights reserved.
//

#import "VideoCommentViewController.h"
#import "VideoTableViewCell.h"
#import "TTVideoComment.h"
#import "FullViewController.h"
#import "TTVideo.h"
#import "VideoCommentCell.h"
#import "TTConst.h"
#import "UIView+Extension.h"
#import <DKNightVersion.h>
#import <MJExtension.h>
#import <MJRefresh.h>
#import <DKNightVersion.h>

static NSString * const VideoCommentCellID = @"VideoCommentCell";

@interface VideoCommentViewController () <UITableViewDelegate, UITableViewDataSource,VideoTableViewCellDelegate,VideoPlayViewDelegate>

/** 工具条底部间距 */
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomSapce;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

/** 最热评论 */
@property (nonatomic, strong) NSArray *hotComments;
/** 最新评论 */
@property (nonatomic, strong) NSMutableArray *latestComments;

/** 保存帖子的top_cmt */
@property (nonatomic, strong) TTVideoComment *saved_top_cmt;

/** 保存当前的页码 */
@property (nonatomic, assign) NSInteger page;

/** 当前皮肤模式*/
@property (nonatomic, copy) NSString *currentSkinModel;

@property(nonatomic, weak) VideoTableViewCell *headerVideoCell;
@property (weak, nonatomic) IBOutlet UIView *bottomContianerView;
@property (weak, nonatomic) IBOutlet UITextField *commentTextField;
@property (nonatomic, assign) NSInteger total;

@property (nonatomic, strong) FullViewController *fullVc;
@property (nonatomic, weak) VideoPlayView *playView;
@property (nonatomic, assign) BOOL isFullScreenPlaying;

@end

@implementation VideoCommentViewController

#pragma mark 懒加载
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupBasic];
    [self setupHeader];
    [self setupRefresh];
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
}

-(void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    if (self.isFullScreenPlaying == NO) {//将要呈现的画面不是全屏播放页面
        [self.playView resetPlayView];
    }
    if (self.saved_top_cmt) {
        self.video.top_cmt = self.saved_top_cmt;
        [self.video setValue:@0 forKeyPath:@"cellHeight"];
    }
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark 基本设置
- (void)setupBasic
{
    self.tableView.dk_backgroundColorPicker = DKColorPickerWithRGB(0xf0f0f0, 0x000000, 0xfafafa);
    self.bottomContianerView.dk_backgroundColorPicker = DKColorPickerWithRGB(0xf0f0f0, 0x000000, 0xfafafa);
    
    self.title = @"评论";
    self.page = 1;
    // cell的高度设置
    self.tableView.estimatedRowHeight = 44;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    
    // 背景色
    
    // 注册
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([VideoCommentCell class]) bundle:nil] forCellReuseIdentifier:VideoCommentCellID];
    
    // 去掉分割线
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    // 内边距s
    CGFloat top = CGRectGetMaxY(self.navigationController.navigationBar.frame);
    self.tableView.contentInset = UIEdgeInsetsMake(top, 0, cellMargin, 0);
    self.automaticallyAdjustsScrollViewInsets = NO;
}

#pragma mark 初始化刷新控件
- (void)setupRefresh
{
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewComments)];
    self.tableView.mj_header.automaticallyChangeAlpha = YES;
    [self.tableView.mj_header beginRefreshing];
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreComments)];
    self.tableView.mj_footer.hidden = YES;
}

#pragma mark 初始化TableView的headerView
- (void)setupHeader
{
    // 清空top_cmt
    if (self.video.top_cmt) {
        self.saved_top_cmt = self.video.top_cmt;
        self.video.top_cmt = nil;
        self.video.cellHeight = 0;
    }
    
    // 创建header
    UIView *header = [[UIView alloc] init];
    //     添加cell
    VideoTableViewCell *cell = [VideoTableViewCell cell];
    self.headerVideoCell = cell;
    cell.delegate = self;
    cell.video = self.video;
    cell.frame = CGRectMake(0, cellMargin, [UIScreen mainScreen].bounds.size.width, self.video.cellHeight);
    cell.contentView.frame = cell.bounds;
    
    // header的高度
    header.height =  self.video.cellHeight + cellMargin;
    [header addSubview:cell];
    
    // 设置header
    self.tableView.tableHeaderView = header;
}

@end
