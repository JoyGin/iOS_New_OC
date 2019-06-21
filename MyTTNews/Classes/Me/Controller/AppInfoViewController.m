//
//  AppInfoViewController.m
//  MyTTNews
//
//  Created by george on 2019/6/14.
//  Copyright © 2019 com.george. All rights reserved.
//

#import "AppInfoViewController.h"
#import "TTConst.h"

@interface AppInfoViewController ()
@property (weak, nonatomic) IBOutlet UILabel *appNameLabel;

@end

@implementation AppInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"关于";
    // Do any additional setup after loading the view from its nib.
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
}

-(void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}

@end
