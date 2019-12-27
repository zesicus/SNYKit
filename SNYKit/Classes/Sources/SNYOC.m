//
//  SNYOC.m
//  NU
//
//  Created by Sunny on 15/05/2018.
//  Copyright © 2018 Juejin-Inc. All rights reserved.
//

#import "SNYOC.h"
#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import <CoreText/CoreText.h>

static const double a = 6378245.0;
static const double ee = 0.00669342162296594323;
static const double pi = M_PI;
static const double xPi = M_PI  * 3000.0 / 180.0;

@implementation SNYOC

+ (void)exitApplication {
    #pragma clang diagnostic push
    #pragma clang diagnostic ignored "-Wundeclared-selector"
    //运行一个不存在的方法,退出界面更加圆滑
    [self performSelector:@selector(notExistCall)];
    abort();
    #pragma clang diagnostic pop
}

// 记录日志
+ (void)recordLog:(NSString *)logStr {
    [[LogManager sharedInstance] recordLog:logStr];
}

// View深复制
+ (UIView *)copyView:(UIView *)view {
    NSData * tempArchive = [NSKeyedArchiver archivedDataWithRootObject:view];
    return [NSKeyedUnarchiver unarchiveObjectWithData:tempArchive];
}

+ (UIImage *)imageFromColor:(UIColor *)color corner:(Corner)corner radius:(CGFloat)radius {
    CGFloat width = MAX(10, radius * 2+2);
    UIImage *image = nil;
    UIGraphicsBeginImageContext(CGSizeMake(width, width));
    CGFloat height = width;
    [color setFill];
    
    // 获取CGContext，注意UIKit里用的是一个专门的函数
    CGContextRef context = UIGraphicsGetCurrentContext();
    // 移动到初始点
    if (corner&CornerLeftTop) {
        CGContextMoveToPoint(context, radius, 0);
    }else{
        CGContextMoveToPoint(context, 0, 0);
    }
    
    if (corner&CornerRightTop) {
        // 绘制第1条线和第1个1/4圆弧
        CGContextAddLineToPoint(context, width - radius, 0);
        CGContextAddArc(context, width - radius, radius, radius, -0.5 * M_PI, 0.0, 0);
    }else{
        CGContextAddLineToPoint(context, width, 0);
    }
    
    if (corner & CornerRightBottom) {
        // 绘制第2条线和第2个1/4圆弧
        CGContextAddLineToPoint(context, width, height - radius);
        CGContextAddArc(context, width - radius, height - radius, radius, 0.0, 0.5 * M_PI, 0);
    }else{
        CGContextAddLineToPoint(context, width, height);
    }
    
    if (corner&CornerLeftBottom) {
        // 绘制第3条线和第3个1/4圆弧
        CGContextAddLineToPoint(context, radius, height);
        CGContextAddArc(context, radius, height - radius, radius, 0.5 * M_PI, M_PI, 0);
    }else{
        CGContextAddLineToPoint(context, 0, height);
    }
    
    if (corner&CornerLeftTop) {
        // 绘制第4条线和第4个1/4圆弧
        CGContextAddLineToPoint(context, 0, radius);
        CGContextAddArc(context, radius, radius, radius, M_PI, 1.5 * M_PI, 0);
    }else{
        CGContextAddLineToPoint(context, 0, 0);
    }
    
    // 闭合路径
    CGContextClosePath(context);
    CGContextFillPath(context);
    
    image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return [image stretchableImageWithLeftCapWidth:width/2 topCapHeight:width/2];
}

+ (NSAttributedString *)returnColorfulString:(NSString *)content which:(NSArray *)chars color:(UIColor *)color {
    NSMutableAttributedString *attributeString  = [[NSMutableAttributedString alloc] initWithString:content];
    for (int i = 0; i < content.length; i ++) {
        //每次只截取一个字符的范围
        NSString *a = [content substringWithRange:NSMakeRange(i, 1)];
        //判断装有0-9的字符串的数字数组是否包含截取字符串出来的单个字符，从而筛选出符合要求的数字字符的范围NSMakeRange
        if ([chars containsObject:a]) {
            [attributeString setAttributes:@{NSForegroundColorAttributeName:color
//                                             ,NSFontAttributeName:[UIFont systemFontOfSize:15]
//                                             ,NSUnderlineStyleAttributeName:[NSNumber numberWithInteger:NSUnderlineStyleSingle]
                                             } range:NSMakeRange(i, 1)];
        }
    }
    return attributeString;
}

+ (NSAttributedString *)returnColorfulString:(NSString *)content keyword:(NSString *)str color:(UIColor *)color {
    NSRange range = [content rangeOfString:str];
    NSMutableAttributedString *attributeString  = [[NSMutableAttributedString alloc] initWithString:content];
    [attributeString setAttributes:@{NSForegroundColorAttributeName:color} range:range];
    return attributeString;
}

+ (NSAttributedString *)returnColorfulString:(NSString *)content which:(NSArray *)chars color:(UIColor *)color font:(UIFont *)font {
    NSMutableAttributedString *attributeString  = [[NSMutableAttributedString alloc] initWithString:content];
    for (int i = 0; i < content.length; i ++) {
        //每次只截取一个字符的范围
        NSString *a = [content substringWithRange:NSMakeRange(i, 1)];
        //判断装有0-9的字符串的数字数组是否包含截取字符串出来的单个字符，从而筛选出符合要求的数字字符的范围NSMakeRange
        if ([chars containsObject:a]) {
            [attributeString setAttributes:@{NSForegroundColorAttributeName:color
                                             ,NSFontAttributeName:font
                                             } range:NSMakeRange(i, 1)];
        }
    }
    return attributeString;
}

+ (NSAttributedString *)returnColorfulString:(NSString *)content keyword:(NSString *)str color:(UIColor *)color font:(UIFont *)font {
    NSRange range = [content rangeOfString:str];
    NSMutableAttributedString *attributeString  = [[NSMutableAttributedString alloc] initWithString:content];
    [attributeString setAttributes:@{NSForegroundColorAttributeName:color, NSFontAttributeName:font} range:range];
    return attributeString;
}

+ (NSAttributedString *)returnUnderlineColorfulString:(NSString *)content keyword:(NSString *)str color:(UIColor *)color font:(UIFont *)font {
    NSRange range = [content rangeOfString:str];
    NSMutableAttributedString *attributeString  = [[NSMutableAttributedString alloc] initWithString:content];
    [attributeString setAttributes:@{NSForegroundColorAttributeName:color, NSFontAttributeName:font, NSUnderlineStyleAttributeName: [NSNumber numberWithInteger:NSUnderlineStyleSingle]} range:range];
    return attributeString;
}

+ (void)addAnimation:(CALayer *)layer Type:(NSString *)type {
    CATransition *transition = [CATransition animation];
    transition.duration = 0.5f;
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionDefault];
    /** type
     *
     *  各种动画效果  其中除了'fade', `moveIn', `push' , `reveal' ,其他属于似有的API(我是这么认为的,可以点进去看下注释).
     *  ↑↑↑上面四个可以分别使用'kCATransitionFade', 'kCATransitionMoveIn', 'kCATransitionPush', 'kCATransitionReveal'来调用.
     *  @"cube"                     立方体翻滚效果
     *  @"moveIn"                   新视图移到旧视图上面
     *  @"reveal"                   显露效果(将旧视图移开,显示下面的新视图)
     *  @"fade"                     交叉淡化过渡(不支持过渡方向)             (默认为此效果)
     *  @"pageCurl"                 向上翻一页
     *  @"pageUnCurl"               向下翻一页
     *  @"suckEffect"               收缩效果，类似系统最小化窗口时的神奇效果(不支持过渡方向)
     *  @"rippleEffect"             滴水效果,(不支持过渡方向)
     *  @"oglFlip"                  上下左右翻转效果
     *  @"rotate"                   旋转效果
     *  @"push"
     *  @"cameraIrisHollowOpen"     相机镜头打开效果(不支持过渡方向)
     *  @"cameraIrisHollowClose"    相机镜头关上效果(不支持过渡方向)
     */
    transition.type = type;
    transition.subtype = kCATransitionFromRight;
    [layer addAnimation:transition forKey:nil];
}

+ (UIImage *)generateImageFromView:(UIView *)view size:(CGSize)size {
    UIImage* viewImage = nil;
    UITableView *scrollView = (UITableView *)view;
    UIGraphicsBeginImageContextWithOptions(scrollView.contentSize, scrollView.opaque, 0.0);
    {
        CGPoint savedContentOffset = scrollView.contentOffset;
        CGRect savedFrame = scrollView.frame;
        
        scrollView.contentOffset = CGPointZero;
        scrollView.frame = CGRectMake(0, 0, scrollView.contentSize.width, scrollView.contentSize.height);
        
        [scrollView.layer renderInContext: UIGraphicsGetCurrentContext()];
        viewImage = UIGraphicsGetImageFromCurrentImageContext();
        
        scrollView.contentOffset = savedContentOffset;
        scrollView.frame = savedFrame;
    }
    UIGraphicsEndImageContext();
    
    return viewImage;
}

- (id)initWithLatitude:(double)latitude andLongitude:(double)longitude {
    if (self = [super init]) {
        self.latitude = latitude;
        self.longitude = longitude;
    }
    return self;
}

- (SNYOC *)transformFromGPSToGD {
    CLLocationCoordinate2D coor = [SNYOC transformFromWGSToGCJ:CLLocationCoordinate2DMake(self.latitude, self.longitude)];
    return [[SNYOC alloc] initWithLatitude:coor.latitude andLongitude:coor.longitude];
}

- (SNYOC *)transformFromGDToBD {
    CLLocationCoordinate2D coor = [SNYOC transformFromGCJToBaidu:CLLocationCoordinate2DMake(self.latitude, self.longitude)];
    return [[SNYOC alloc] initWithLatitude:coor.latitude andLongitude:coor.longitude];
}

- (SNYOC *)transformFromBDToGD {
    CLLocationCoordinate2D coor = [SNYOC transformFromBaiduToGCJ:CLLocationCoordinate2DMake(self.latitude, self.longitude)];
    return [[SNYOC alloc] initWithLatitude:coor.latitude andLongitude:coor.longitude];
}

- (SNYOC *)transformFromGDToGPS {
    CLLocationCoordinate2D coor = [SNYOC transformFromGCJToWGS:CLLocationCoordinate2DMake(self.latitude, self.longitude)];
    return [[SNYOC alloc] initWithLatitude:coor.latitude andLongitude:coor.longitude];
}

- (id)transformFromBDToGPS {
    //先把百度转化为高德
    CLLocationCoordinate2D start_coor = [SNYOC transformFromBaiduToGCJ:CLLocationCoordinate2DMake(self.latitude, self.longitude)];
    CLLocationCoordinate2D end_coor = [SNYOC transformFromGCJToWGS:CLLocationCoordinate2DMake(start_coor.latitude, start_coor.longitude)];
    return [[SNYOC alloc] initWithLatitude:end_coor.latitude andLongitude:end_coor.longitude];
}

+ (CLLocationCoordinate2D)transformFromWGSToGCJ:(CLLocationCoordinate2D)wgsLoc {
    CLLocationCoordinate2D adjustLoc;
    if([self isLocationOutOfChina:wgsLoc]) {
        adjustLoc = wgsLoc;
    }
    else {
        double adjustLat = [self transformLatWithX:wgsLoc.longitude - 105.0 withY:wgsLoc.latitude - 35.0];
        double adjustLon = [self transformLonWithX:wgsLoc.longitude - 105.0 withY:wgsLoc.latitude - 35.0];
        long double radLat = wgsLoc.latitude / 180.0 * pi;
        long double magic = sin(radLat);
        magic = 1 - ee * magic * magic;
        long double sqrtMagic = sqrt(magic);
        adjustLat = (adjustLat * 180.0) / ((a * (1 - ee)) / (magic * sqrtMagic) * pi);
        adjustLon = (adjustLon * 180.0) / (a / sqrtMagic * cos(radLat) * pi);
        adjustLoc.latitude = wgsLoc.latitude + adjustLat;
        adjustLoc.longitude = wgsLoc.longitude + adjustLon;
    }
    return adjustLoc;
}

+ (double)transformLatWithX:(double)x withY:(double)y {
    double lat = -100.0 + 2.0 * x + 3.0 * y + 0.2 * y * y + 0.1 * x * y + 0.2 * sqrt(fabs(x));
    
    lat += (20.0 * sin(6.0 * x * pi) + 20.0 *sin(2.0 * x * pi)) * 2.0 / 3.0;
    lat += (20.0 * sin(y * pi) + 40.0 * sin(y / 3.0 * pi)) * 2.0 / 3.0;
    lat += (160.0 * sin(y / 12.0 * pi) + 320 * sin(y * pi / 30.0)) * 2.0 / 3.0;
    return lat;
}

+ (double)transformLonWithX:(double)x withY:(double)y {
    double lon = 300.0 + x + 2.0 * y + 0.1 * x * x + 0.1 * x * y + 0.1 * sqrt(fabs(x));
    lon += (20.0 * sin(6.0 * x * pi) + 20.0 * sin(2.0 * x * pi)) * 2.0 / 3.0;
    lon += (20.0 * sin(x * pi) + 40.0 * sin(x / 3.0 * pi)) * 2.0 / 3.0;
    lon += (150.0 * sin(x / 12.0 * pi) + 300.0 * sin(x / 30.0 * pi)) * 2.0 / 3.0;
    return lon;
}

+ (CLLocationCoordinate2D)transformFromGCJToBaidu:(CLLocationCoordinate2D)p {
    long double z = sqrt(p.longitude * p.longitude + p.latitude * p.latitude) + 0.00002 * sqrt(p.latitude * pi);
    long double theta = atan2(p.latitude, p.longitude) + 0.000003 * cos(p.longitude * pi);
    CLLocationCoordinate2D geoPoint;
    geoPoint.latitude  = (z * sin(theta) + 0.006);
    geoPoint.longitude = (z * cos(theta) + 0.0065);
    return geoPoint;
}

+ (CLLocationCoordinate2D)transformFromBaiduToGCJ:(CLLocationCoordinate2D)p {
    double x = p.longitude - 0.0065, y = p.latitude - 0.006;
    double z = sqrt(x * x + y * y) - 0.00002 * sin(y * xPi);
    double theta = atan2(y, x) - 0.000003 * cos(x * xPi);
    CLLocationCoordinate2D geoPoint;
    geoPoint.latitude  = z * sin(theta);
    geoPoint.longitude = z * cos(theta);
    return geoPoint;
}

+ (CLLocationCoordinate2D)transformFromGCJToWGS:(CLLocationCoordinate2D)p {
    double threshold = 0.00001;
    
    // The boundary
    double minLat = p.latitude - 0.5;
    double maxLat = p.latitude + 0.5;
    double minLng = p.longitude - 0.5;
    double maxLng = p.longitude + 0.5;
    
    double delta = 1;
    int maxIteration = 30;
    // Binary search
    while(true) {
        CLLocationCoordinate2D leftBottom  = [[self class] transformFromWGSToGCJ:(CLLocationCoordinate2D){.latitude = minLat,.longitude = minLng}];
        CLLocationCoordinate2D rightBottom = [[self class] transformFromWGSToGCJ:(CLLocationCoordinate2D){.latitude = minLat,.longitude = maxLng}];
        CLLocationCoordinate2D leftUp      = [[self class] transformFromWGSToGCJ:(CLLocationCoordinate2D){.latitude = maxLat,.longitude = minLng}];
        CLLocationCoordinate2D midPoint    = [[self class] transformFromWGSToGCJ:(CLLocationCoordinate2D){.latitude = ((minLat + maxLat) / 2),.longitude = ((minLng + maxLng) / 2)}];
        delta = fabs(midPoint.latitude - p.latitude) + fabs(midPoint.longitude - p.longitude);
        
        if(maxIteration-- <= 0 || delta <= threshold) {
            return (CLLocationCoordinate2D){.latitude = ((minLat + maxLat) / 2),.longitude = ((minLng + maxLng) / 2)};
        }
        
        if(isContains(p, leftBottom, midPoint)) {
            maxLat = (minLat + maxLat) / 2;
            maxLng = (minLng + maxLng) / 2;
        } else if(isContains(p, rightBottom, midPoint)) {
            maxLat = (minLat + maxLat) / 2;
            minLng = (minLng + maxLng) / 2;
        } else if(isContains(p, leftUp, midPoint)) {
            minLat = (minLat + maxLat) / 2;
            maxLng = (minLng + maxLng) / 2;
        } else {
            minLat = (minLat + maxLat) / 2;
            minLng = (minLng + maxLng) / 2;
        }
    }
    
}

#pragma mark - 判断某个点point是否在p1和p2之间
static bool isContains(CLLocationCoordinate2D point, CLLocationCoordinate2D p1, CLLocationCoordinate2D p2) {
    return (point.latitude >= MIN(p1.latitude, p2.latitude) && point.latitude <= MAX(p1.latitude, p2.latitude)) && (point.longitude >= MIN(p1.longitude,p2.longitude) && point.longitude <= MAX(p1.longitude, p2.longitude));
}

#pragma mark - 判断是不是在中国
+ (BOOL)isLocationOutOfChina:(CLLocationCoordinate2D)location {
    if (location.longitude < 72.004 || location.longitude > 137.8347 || location.latitude < 0.8293 || location.latitude > 55.8271)
    return YES;
    return NO;
}

+ (NSString*)getWeek:(NSDate *)weekDate {
    NSDateComponents *componets = [[NSCalendar autoupdatingCurrentCalendar] components:NSCalendarUnitWeekday fromDate:weekDate];
    long weekday = [componets weekday];
    NSArray * arr = @[@"星期日", @"星期一", @"星期二", @"星期三", @"星期四", @"星期五", @"星期六"];
    return [NSString stringWithFormat:@"%@", arr[weekday - 1]];
}

+ (NSArray *)getLinesArrayOfStringInLabel:(UILabel *)label {
    NSString *text = [label text];
    UIFont *font = [label font];
    CGRect rect = [label frame];
    
    CTFontRef myFont = CTFontCreateWithName(( CFStringRef)([font fontName]), [font pointSize], NULL);
    NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc] initWithString:text];
    NSMutableParagraphStyle *paraStyle = [[NSMutableParagraphStyle alloc] init];
    paraStyle.lineBreakMode = NSLineBreakByCharWrapping;
    paraStyle.lineSpacing = 10; //设置行间距
    [attStr addAttributes:@{(NSString *)kCTFontAttributeName: (__bridge  id)myFont, NSParagraphStyleAttributeName: paraStyle, NSKernAttributeName: @1.0f} range:NSMakeRange(0, attStr.length)];
    CFRelease(myFont);
    CTFramesetterRef frameSetter = CTFramesetterCreateWithAttributedString(( CFAttributedStringRef)attStr);
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathAddRect(path, NULL, CGRectMake(0,0,rect.size.width,100000));
    CTFrameRef frame = CTFramesetterCreateFrame(frameSetter, CFRangeMake(0, 0), path, NULL);
    NSArray *lines = ( NSArray *)CTFrameGetLines(frame);
    NSMutableArray *linesArray = [[NSMutableArray alloc]init];
    for (id line in lines) {
        CTLineRef lineRef = (__bridge  CTLineRef )line;
        CFRange lineRange = CTLineGetStringRange(lineRef);
        NSRange range = NSMakeRange(lineRange.location, lineRange.length);
        NSString *lineString = [text substringWithRange:range];
        CFAttributedStringSetAttribute((CFMutableAttributedStringRef)attStr, lineRange, kCTKernAttributeName, (CFTypeRef)([NSNumber numberWithFloat:0.0]));
        CFAttributedStringSetAttribute((CFMutableAttributedStringRef)attStr, lineRange, kCTKernAttributeName, (CFTypeRef)([NSNumber numberWithInt:0.0]));
        //NSLog(@"''''''''''''''''''%@",lineString);
        [linesArray addObject:lineString];
    }
    
    CGPathRelease(path);
    CFRelease( frame );
    CFRelease(frameSetter);
    return (NSArray *)linesArray;
}

+ (UIImage *)createImageWithColor:(UIColor *)color {
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}

+ (void)jumpAnimationView:(UIView *)sender {
    
    CGFloat duration = 2.f * [SNYOC getRandomNumber:1 to:3] + [SNYOC getRandomNumber:1 to:9] / 10;
    CGFloat height = 10.f;
    
    CAKeyframeAnimation * animation = [CAKeyframeAnimation animationWithKeyPath:@"transform.translation.y"];
    CGFloat currentTy = sender.transform.ty;
    animation.duration = duration;
    animation.values = @[@(currentTy), @(currentTy - height/4), @(currentTy-height/4*2), @(currentTy-height/4*3), @(currentTy - height), @(currentTy-height/4*3), @(currentTy -height/4*2), @(currentTy - height/4), @(currentTy)];
    animation.keyTimes = @[ @(0), @(0.025), @(0.085), @(0.2), @(0.5), @(0.8), @(0.915), @(0.975), @(1) ];
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    animation.repeatCount = HUGE_VALF;
    [sender.layer addAnimation:animation forKey:@"kViewShakerAnimationKey"];
}

+ (CGFloat)getRandomNumber:(int)from to:(int)to {
    return (CGFloat)(from + (arc4random() % (to - from + 1))); //+1,result is [from to]; else is [from, to)!!!!!!!
}

+ (BOOL)checkTel:(NSString *)str {
    if ([str length] == 0) {
        return NO;
    }
    NSString *regex = @"^[1][0-9][0-9]{9}$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    BOOL isMatch = [pred evaluateWithObject:str];
    if (!isMatch) {
        return NO;
    }
    return YES;
}
    
+ (int)getIntegerFromDate:(NSDate *)date {
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyyMMdd"];
    NSString *todayStr = [formatter stringFromDate:date];
    int presentDay = [todayStr intValue];
    return presentDay;
}

+ (NSString *)getDateToStr:(NSDate *)date withFormat:(NSString *)format {
    NSString *flagString = nil;
    // 当前日期
    int currentDate = [self getIntegerFromDate:[NSDate date]];
    // 目标日期
    int tar = [self getIntegerFromDate:date];
    // 时间差
    int diff = tar - currentDate;
    
    if ( diff < 3 && diff >= 0) {
        switch (diff) {
            case 0:
                flagString = @"今天";
                break;
            case 1:
                flagString = @"明天";
                break;
            case 2:
                flagString = @"后天";
                break;
            default:
                break;
        }
    }
    else if (diff == -1) {
        flagString = @"昨天";
    } else {
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setLocale:[NSLocale localeWithLocaleIdentifier:@"zh_CN"]];
        [formatter setDateFormat:format];
        flagString = [formatter stringFromDate:date];
    }
    
    return flagString ;
}

+ (NSArray *)getStringArrWith:(NSString *)str {
    NSMutableArray *arr = [NSMutableArray array];
    for (int i = 0; i < str.length; i++) {
        unichar ch = [str characterAtIndex:i];
        [arr addObject:[NSString stringWithFormat:@"%C", ch]];
    }
    return arr.copy;
}

//

+ (CGFloat)folderSize{
    CGFloat folderSize = 0.0;
    
    //获取路径
    NSString *cachePath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory,NSUserDomainMask,YES)firstObject];
    
    //获取所有文件的数组
    NSArray *files = [[NSFileManager defaultManager] subpathsAtPath:cachePath];
    
    NSLog(@"文件数：%ld",files.count);
    
    for(NSString *path in files) {
        
        NSString*filePath = [cachePath stringByAppendingString:[NSString stringWithFormat:@"/%@",path]];
        
        //累加
        folderSize += [[NSFileManager defaultManager]attributesOfItemAtPath:filePath error:nil].fileSize;
    }
    //转换为M为单位
    CGFloat sizeM = folderSize /1024.0/1024.0;
    NSLog(@"%f",sizeM);
    return sizeM;
}

+ (CGFloat)clearCache {
    
    //===============清除缓存==============
    //获取路径
    NSString*cachePath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory,NSUserDomainMask,YES)objectAtIndex:0];
    
    //返回路径中的文件数组
    NSArray*files = [[NSFileManager defaultManager]subpathsAtPath:cachePath];
    
    NSLog(@"文件数：%ld",[files count]);
    if([files count] == 0){
        return 0;
        
    }else{
        for(NSString *p in files){
            NSError*error;
            
            NSString*path = [cachePath stringByAppendingString:[NSString stringWithFormat:@"/%@",p]];
            
            if([[NSFileManager defaultManager]fileExistsAtPath:path])
            {
                BOOL isRemove = [[NSFileManager defaultManager]removeItemAtPath:path error:&error];
                if(isRemove) {
                    NSLog(@"清除成功");
                }else{
                    NSLog(@"清除失败");
                }
            }
        }
    }
    
    CGFloat size = [SNYOC folderSize];
    
    return size;
}

@end
