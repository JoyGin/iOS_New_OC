//
//  TTVideoFetchDataParameter.h
//  MyTTNews
//
//  Created by george on 2019/6/11.
//  Copyright © 2019 com.george. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TTVideoFetchDataParameter : NSObject

@property (nonatomic, copy) NSString *recentTime;//最新的video的时间

@property (nonatomic, copy) NSString *remoteTime;//最晚的video的时间

@property (nonatomic, copy) NSString *maxtime;

@property (nonatomic, assign) NSInteger page;

@end
