//
//  TTDataTool.h
//  MyTTNews
//
//  Created by george on 2019/6/5.
//  Copyright © 2019 com.george. All rights reserved.
//


#import <Foundation/Foundation.h>

@class TTPictureFetchDataParameter;//以类名引入防止冲突
@class TTVideoFetchDataParameter;

@interface TTDataTool : NSObject

+(void)videoWithParameters:(TTVideoFetchDataParameter *)videoParameters success:(void (^)(NSArray *array, NSString *maxtime))success failure:(void (^)(NSError *error))failure;

+(void)pictureWithParameters:(TTPictureFetchDataParameter *)pictureParameters success:(void (^)(NSArray *array, NSString *maxtime))success failure:(void (^)(NSError *error))failure;

+(void)deletePartOfCacheInSqlite;

@end
