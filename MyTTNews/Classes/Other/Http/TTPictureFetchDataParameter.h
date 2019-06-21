//
//  TTPictureFetchDataParameter.h
//  MyTTNews
//
//  Created by george on 2019/6/4.
//  Copyright © 2019 com.george. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TTPictureFetchDataParameter : NSObject
@property (nonatomic, copy) NSString *recentTime;//最新的picture的时间

@property (nonatomic, copy) NSString *remoteTime;//最晚的picture的时间

@property (nonatomic, copy) NSString *maxtime;

@property (nonatomic, assign) NSInteger page;

@end

NS_ASSUME_NONNULL_END
