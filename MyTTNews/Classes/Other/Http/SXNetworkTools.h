//
//  SXNetworkTools.h
//  MyTTNews
//
//  Created by george on 2019/5/27.
//  Copyright © 2019 com.george. All rights reserved.
//

#import "AFHTTPSessionManager.h"

@interface SXNetworkTools : AFHTTPSessionManager

+ (instancetype)sharedNetworkTools;
+ (instancetype)sharedNetworkToolsWithoutBaseUrl;

@end
