//
//  TTVideoComment.m
//  MyTTNews
//
//  Created by george on 2019/6/12.
//  Copyright © 2019 com.george. All rights reserved.
//

#import "TTVideoComment.h"
#import <MJExtension.h>

@implementation TTVideoComment

+(NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{@"ID":@"id"};
}


-(void)encodeWithCoder:(NSCoder *)aCoder {
    [self mj_encode:aCoder];
}

-(instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self= [super init]) {
        [self mj_decode:aDecoder];
    }
    return self;
}

@end
