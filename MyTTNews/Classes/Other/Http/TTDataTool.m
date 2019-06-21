//
//  TTDataTool.m
//  MyTTNews
//
//  Created by george on 2019/6/5.
//  Copyright © 2019 com.george. All rights reserved.
//

#import "TTDataTool.h"
#import "TTPictureFetchDataParameter.h"
#import "TTNetworkManager.h"
#import "TTPicture.h"
#import "TTVideo.h"
#import "TTVideoFetchDataParameter.h"
#import <MJExtension.h>
#import <AFNetworking.h>
#import <FMDB.h>

@interface TTDataTool()
@end

@implementation TTDataTool
static FMDatabaseQueue *_queue;
static NSString * const apikey = @"8b72ce2839d6eea0869b4c2c60d2a449";

+(void)pictureWithParameters:(TTPictureFetchDataParameter *)pictureParameters success:(void (^)(NSArray *array, NSString *maxtime))success failure:(void (^)(NSError *error))failure {            NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"a"] = @"list";
    parameters[@"c"] = @"data";
    parameters[@"type"] = @(10);
    parameters[@"page"] = @(pictureParameters.page);
    if (pictureParameters.maxtime) {
        parameters[@"maxtime"] = pictureParameters.maxtime;
    }
    
    [[TTNetworkManager shareManager] Get:@"http://api.budejie.com/api/api_open.php" Parameters:parameters Success:^(NSURLSessionDataTask *task, id responseObject) {
        
        NSArray *array = [TTPicture mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        NSString *maxTime = responseObject[@"info"][@"maxtime"];
        for (TTPicture *picture in array) {
            picture.maxtime = maxTime;
        }
        success(array,maxTime);
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            [self addPictureArray:array];
        });
        
    } Failure:^(NSError *error) {
        pictureParameters.recentTime = nil;
        pictureParameters.remoteTime = nil;
        NSMutableArray *pictureArray = [self selectDataFromCacheWithPictureParameters:pictureParameters];
        if (pictureArray.count>0) {
            TTPicture *lastPicture = pictureArray.lastObject;
            NSString *maxtime = lastPicture.maxtime;
            success([pictureArray copy], maxtime);
        }
        success([pictureArray copy], @"");
    }];
}

+(void)videoWithParameters:(TTVideoFetchDataParameter *)videoParameters success:(void (^)(NSArray *array, NSString *maxtime))success failure:(void (^)(NSError *error))failure {
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"a"] = @"list";
    parameters[@"c"] = @"data";
    parameters[@"type"] = @(41);
    parameters[@"page"] = @(videoParameters.page);
    if (videoParameters.maxtime) {
        parameters[@"maxtime"] = videoParameters.maxtime;
    }
    
    [[TTNetworkManager shareManager] Get:@"http://api.budejie.com/api/api_open.php" Parameters:parameters Success:^(NSURLSessionDataTask *task, id responseObject) {
        NSArray *array = [TTVideo mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        NSString *maxTime = responseObject[@"info"][@"maxtime"];
        for (TTVideo *video in array) {
            video.maxtime = maxTime;
        }
        success(array,maxTime);
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            [self addVideoArray:array];
        });
        
    } Failure:^(NSError *error) {
        videoParameters.recentTime = nil;
        videoParameters.remoteTime = nil;
        NSMutableArray *videoArray = [self selectDataFromCacheWithVideoParameters:videoParameters];
        if (videoArray.count>0) {
            TTVideo *lastVideo = videoArray.lastObject;
            NSString *maxtime = lastVideo.maxtime;
            success(videoArray, maxtime);
        }
        success([videoArray copy], @"");
    }];
}

+ (void)addPictureArray:(NSArray *)pictureArray {
    for (TTPicture *picture in pictureArray) {
        [self addPicture:picture];
    }
}

+(void)addPicture:(TTPicture *)picture {
    [_queue inDatabase:^(FMDatabase *db) {
        NSString *idstr = picture.ID;
        FMResultSet *result = nil;
        NSString *querySql = [NSString stringWithFormat:@"SELECT * FROM table_picture WHERE idstr = '%@';",idstr];
        result = [db executeQuery:querySql];
        if (result.next==NO) {//不存在此条数据
            NSString *string = picture.created_at;
            NSInteger time = [[[string stringByReplacingOccurrencesOfString:@"-" withString:@""] stringByReplacingOccurrencesOfString:@" " withString:@""] stringByReplacingOccurrencesOfString:@":" withString:@""].integerValue;
            NSData *data = [NSKeyedArchiver archivedDataWithRootObject:picture];
            [db executeUpdate:@"insert into table_picture (idstr,time,picture) values(?,?,?);", idstr, @(time), data];
        }
        [result close];
    }];
}

+(NSMutableArray *)selectDataFromCacheWithPictureParameters:(TTPictureFetchDataParameter *)parameters {
    __block NSMutableArray *pictureArray = nil;
    
    [_queue inDatabase:^(FMDatabase *db) {
        pictureArray = [NSMutableArray array];
        FMResultSet *result = nil;
        
        if (parameters.recentTime) {//时间更大，代表消息发布越靠后，因为时间是按real来储存的
            NSInteger time = [[[parameters.recentTime stringByReplacingOccurrencesOfString:@"-" withString:@""] stringByReplacingOccurrencesOfString:@" " withString:@""] stringByReplacingOccurrencesOfString:@":" withString:@""].integerValue;
            
            result = [db executeQuery:@"select * from table_picture where time > ? order by time desc limit 0,20;", @(time)];
            
        }
        
        if(parameters.remoteTime) {
            NSInteger time = [[[parameters.remoteTime stringByReplacingOccurrencesOfString:@"-" withString:@""] stringByReplacingOccurrencesOfString:@" " withString:@""] stringByReplacingOccurrencesOfString:@":" withString:@""].integerValue;
            result = [db executeQuery:@"select * from table_picture where time < ? order by time desc limit 0,20;",@(time)];
        }
        
        if (parameters.remoteTime==nil && parameters.recentTime==nil){
            result = [db executeQuery:@"select * from table_picture order by time desc limit 0,20;"];
            
        }
        
        while (result.next) {
            NSData *data = [result dataForColumn:@"picture"];
            TTPicture *picture = [NSKeyedUnarchiver unarchiveObjectWithData:data];
            [pictureArray addObject:picture];
        }
        
    }];
    return pictureArray;
    
}

+(void)addVideoArray:(NSArray *)videoArray {
    for (TTVideo *video in videoArray) {
        [self addVideo:video];
    }
}

+(void)addVideo:(TTVideo *)video {
    [_queue inDatabase:^(FMDatabase *db) {
        NSString *idstr = video.ID;
        FMResultSet *result = nil;
        NSString *querySql = [NSString stringWithFormat:@"SELECT * FROM table_video WHERE idstr = '%@';",idstr];
        result = [db executeQuery:querySql];
        if (result.next==NO) {//不存在此条数据
            NSString *string = video.created_at;
            NSInteger time = [[[string stringByReplacingOccurrencesOfString:@"-" withString:@""] stringByReplacingOccurrencesOfString:@" " withString:@""] stringByReplacingOccurrencesOfString:@":" withString:@""].integerValue;
            NSData *data = [NSKeyedArchiver archivedDataWithRootObject:video];
            [db executeUpdate:@"insert into table_video (idstr,time,video) values(?,?,?);", idstr, @(time), data];
        }
        [result close];
        
    }];
}

+(NSMutableArray *)selectDataFromCacheWithVideoParameters:(TTVideoFetchDataParameter *)parameters {
    __block NSMutableArray *videoArray = nil;
    
    [_queue inDatabase:^(FMDatabase *db) {
        videoArray = [NSMutableArray array];
        FMResultSet *result = nil;
        
        if (parameters.recentTime) {//时间更大，代表消息发布越靠后，因为时间是按real来储存的
            NSInteger time = [[[parameters.recentTime stringByReplacingOccurrencesOfString:@"-" withString:@""] stringByReplacingOccurrencesOfString:@" " withString:@""] stringByReplacingOccurrencesOfString:@":" withString:@""].integerValue;
            
            result = [db executeQuery:@"select * from table_video where time > ? order by time desc limit 0,20;", @(time)];
            
        }
        
        if(parameters.remoteTime) {
            NSInteger time = [[[parameters.remoteTime stringByReplacingOccurrencesOfString:@"-" withString:@""] stringByReplacingOccurrencesOfString:@" " withString:@""] stringByReplacingOccurrencesOfString:@":" withString:@""].integerValue;
            result = [db executeQuery:@"select * from table_video where time < ? order by time desc limit 0,20;",@(time)];
        }
        
        if (parameters.remoteTime==nil &&parameters.recentTime==nil){
            result = [db executeQuery:@"select * from table_video order by time desc limit 0,20;"];
            
        }
        
        while (result.next) {
            NSData *data = [result dataForColumn:@"video"];
            TTVideo *video = [NSKeyedUnarchiver unarchiveObjectWithData:data];
            [videoArray addObject:video];
        }
        
    }];
    return videoArray;
}

+(void)deletePartOfCacheInSqlite {
    [_queue inDatabase:^(FMDatabase *db) {
        [db executeUpdate:@"delete from table_video where id > 20"];
        [db executeUpdate:@"delete from table_picture where id > 20"];
        [db executeUpdate:@"delete from table_normalnews where id > 20"];
        [db executeUpdate:@"delete from table_ttheadernews where id > 5"];
    }];
}

@end
