//
//  HHHtttpTool.h
//  嗨微博
//
//  Created by 胡明正 on 2017/4/21.
//  Copyright © 2017年 huhuge. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"


@interface HHHtttpTool : NSObject

+ (void)get:(NSString *)url params:(NSDictionary *)params success:(void(^)(id json))success failure:(void(^)(NSError *error))failure;

+ (void)post:(NSString *)url params:(NSDictionary *)params success:(void(^)(id json))success failure:(void(^)(NSError *error))failure;


@end
