//
//  LogManager.h
//  Kingfisher
//
//  Created by Sunny Lee on 2019/5/22.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LogManager : NSObject

+ (instancetype)sharedInstance;

/**
 写入日志
 
 @param oneLine 日志信息（自动分行）
 */
- (void)recordLog:(NSString *)oneLine;

@end

NS_ASSUME_NONNULL_END
