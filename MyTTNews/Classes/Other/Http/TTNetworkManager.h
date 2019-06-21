//
//  TTNetworkManager.h
//  MyTTNews
//
//  Created by george on 2019/6/5.
//  Copyright © 2019 com.george. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^Completion)(NSURLSessionDataTask *task ,NSDictionary *responseObject);
typedef void (^Failure)(NSError *error);

@interface TTNetworkManager : NSObject

+(TTNetworkManager *)shareManager;

/**
 *  有请求头的get请求
 */
-(void)Get:(NSString *)url Parameters:(NSDictionary *)parameters Success:(Completion)success Failure:(Failure)failure;

@end

