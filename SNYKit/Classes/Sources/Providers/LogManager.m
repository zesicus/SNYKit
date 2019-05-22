//
//  LogManager.m
//  Kingfisher
//
//  Created by Sunny Lee on 2019/5/22.
//

#import "LogManager.h"

// 日志保留最大天数
static const int LogMaxSaveDay = 7;
// 日志文件保存目录
static const NSString* LogFilePath = @"/Documents/SNYLog/";


@interface LogManager()

// 日期格式化
@property (nonatomic,retain) NSDateFormatter* dateFormatter;
// 时间格式化
@property (nonatomic,retain) NSDateFormatter* timeFormatter;
// 日志的目录路径
@property (nonatomic,copy) NSString* basePath;

@end


@implementation LogManager

+ (instancetype) sharedInstance {
    static LogManager* instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (!instance) {
            instance = [[LogManager alloc]init];
            //自动清理过期日志
            [instance clearExpiredLog];
        }
    });
    return instance;
}

// 获取当前时间
+ (NSDate*)getCurrDate {
    NSDate *date = [NSDate date];
    NSTimeZone *zone = [NSTimeZone systemTimeZone];
    NSInteger interval = [zone secondsFromGMTForDate: date];
    NSDate *localeDate = [date dateByAddingTimeInterval: interval];
    return localeDate;
}

#pragma mark - Init

- (instancetype)init {
    self = [super init];
    if (self) {
        // 创建日期格式化
        NSDateFormatter* dateFormatter = [[NSDateFormatter alloc]init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd"];
        // 设置时区，解决8小时
        [dateFormatter setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"UTC"]];
        self.dateFormatter = dateFormatter;
        
        // 创建时间格式化
        NSDateFormatter* timeFormatter = [[NSDateFormatter alloc]init];
        [timeFormatter setDateFormat:@"HH:mm:ss"];
        [timeFormatter setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"UTC"]];
        self.timeFormatter = timeFormatter;
        
        // 日志的目录路径
        self.basePath = [NSString stringWithFormat:@"%@%@",NSHomeDirectory(),LogFilePath];
    }
    return self;
}

#pragma mark - Method

- (void)recordLog:(NSString *)oneLine {
    [self logInfo:oneLine logStr:nil];
}

/**
 *  写入日志
 *
 *  @param module 模块名称
 *  @param logStr 日志信息,动态参数
 */
- (void)logInfo:(NSString*)module logStr:(NSString*)logStr, ... {
    
// 获取参数
    
    NSMutableString* parmaStr = [NSMutableString string];
    // 声明一个参数指针
    va_list paramList;
    // 获取参数地址，将paramList指向logStr
    va_start(paramList, logStr);
    id arg = logStr;
    
    @try {
        // 遍历参数列表
        while (arg) {
            [parmaStr appendString:arg];
            // 指向下一个参数，后面是参数类似
            arg = va_arg(paramList, NSString*);
        }
        
    } @catch (NSException *exception) {
        
        [parmaStr appendString:@"【记录日志异常】"];
    } @finally {
        
        // 将参数列表指针置空
        va_end(paramList);
    }
    
// 写入日志
    
    // 异步执行
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
        
        // 获取当前日期做为文件名
        NSString* fileName = [self.dateFormatter stringFromDate:[NSDate date]];
        NSString* filePath = [NSString stringWithFormat:@"%@%@",self.basePath,fileName];
        
        // [时间]-[模块]-日志内容
        NSString* timeStr = [self.timeFormatter stringFromDate:[LogManager getCurrDate]];
        NSString* writeStr = [NSString stringWithFormat:@"[%@]-[%@]-%@\n",timeStr,module,parmaStr];
        
        // 写入数据
        [self writeFile:filePath stringData:writeStr];
        
        NSLog(@"写入日志:%@",filePath);
    });
}

/**
 *  写入字符串到指定文件，默认追加内容
 *
 *  @param filePath   文件路径
 *  @param stringData 待写入的字符串
 */
- (void)writeFile:(NSString*)filePath stringData:(NSString*)stringData{
    
    // 待写入的数据
    NSData* writeData = [stringData dataUsingEncoding:NSUTF8StringEncoding];
    
    // NSFileManager 用于处理文件
    BOOL createPathOk = YES;
    if (![[NSFileManager defaultManager] fileExistsAtPath:[filePath stringByDeletingLastPathComponent] isDirectory:&createPathOk]) {
        // 目录不存先创建
        [[NSFileManager defaultManager] createDirectoryAtPath:[filePath stringByDeletingLastPathComponent] withIntermediateDirectories:YES attributes:nil error:nil];
    }
    if(![[NSFileManager defaultManager] fileExistsAtPath:filePath]){
        // 文件不存在，直接创建文件并写入
        [writeData writeToFile:filePath atomically:NO];
    }else{
        
        // NSFileHandle 用于处理文件内容
        // 读取文件到上下文，并且是更新模式
        NSFileHandle* fileHandler = [NSFileHandle fileHandleForUpdatingAtPath:filePath];
        
        // 跳到文件末尾
        [fileHandler seekToEndOfFile];
        
        // 追加数据
        [fileHandler writeData:writeData];
        
        // 关闭文件
        [fileHandler closeFile];
    }
}

/**
 *  清空过期的日志
 */
- (void)clearExpiredLog {
    // 获取日志目录下的所有文件
    NSArray* files = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:self.basePath error:nil];
    for (NSString* file in files) {
        
        NSDate* date = [self.dateFormatter dateFromString:file];
        if (date) {
            NSTimeInterval oldTime = [date timeIntervalSince1970];
            NSTimeInterval currTime = [[LogManager getCurrDate] timeIntervalSince1970];
            
            NSTimeInterval second = currTime - oldTime;
            int day = (int)second / (24 * 3600);
            if (day >= LogMaxSaveDay) {
                // 删除该文件
                [[NSFileManager defaultManager] removeItemAtPath:[NSString stringWithFormat:@"%@/%@",self.basePath,file] error:nil];
                NSLog(@"[%@]日志文件已被删除！",file);
            }
        }
    }
}



@end
