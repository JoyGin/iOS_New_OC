//
//  TTPictureUser.h
//  MyTTNews
//
//  Created by george on 2019/6/5.
//  Copyright © 2019 com.george. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TTPictureUser : NSObject<NSCoding>
@property (nonatomic, copy) NSString *username;
@property (nonatomic, copy) NSString *profile_image;
@property (nonatomic, copy) NSString *sex;
@end

NS_ASSUME_NONNULL_END
