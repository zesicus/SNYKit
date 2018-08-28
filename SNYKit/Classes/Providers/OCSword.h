//
//  OCSword.h
//  NU
//
//  Created by Sunny on 15/05/2018.
//  Copyright © 2018 Juejin-Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#define COLOR_WITH_HEX(hexValue) [UIColor colorWithRed:((float)((hexValue & 0xFF0000) >> 16)) / 255.0 green:((float)((hexValue & 0xFF00) >> 8)) / 255.0 blue:((float)(hexValue & 0xFF)) / 255.0 alpha:1.0f]
#define WEAKSELF  __weak typeof(self) weakSelf = self;

typedef enum{
    CornerLeftTop = 0x1,
    CornerRightTop = 0x1 << 1,
    CornerLeftBottom = 0x1 << 2,
    CornerRightBottom = 0x1 << 3,
    CornerAll = (0x1 << 4) - 1,
}Corner;

@interface OCSword : NSObject

@property (nonatomic, assign) double latitude;
@property (nonatomic, assign) double longitude;

+ (UIImage *)imageFromColor:(UIColor *)color
                     corner:(Corner)corner
                     radius:(CGFloat)radius;

+ (NSAttributedString *)returnColorfulString:(NSString *)content which:(NSArray *)chars color:(UIColor *)color;

+ (NSAttributedString *)returnColorfulString:(NSString *)content keyword:(NSString *)str color:(UIColor *)color;

+ (void)printFontName;

+ (void)addAnimation:(CALayer *)layer Type:(NSString *)type;

+ (UIImage *)generateImageFromView:(UIView *)view size:(CGSize)size;

+ (NSString*)getWeek:(NSDate *)weekData;

- (id)initWithLatitude:(double)latitude andLongitude:(double)longitude;

/*
 坐标系：
 WGS-84：是国际标准，GPS坐标（Google Earth使用、或者GPS模块）
 GCJ-02：中国坐标偏移标准，Google Map、高德、腾讯使用
 BD-09 ：百度坐标偏移标准，Baidu Map使用
 */

#pragma mark - 从GPS坐标转化到高德坐标
- (id)transformFromGPSToGD;

#pragma mark - 从高德坐标转化到百度坐标
- (id)transformFromGDToBD;

#pragma mark - 从百度坐标到高德坐标
- (id)transformFromBDToGD;

#pragma mark - 从高德坐标到GPS坐标
- (id)transformFromGDToGPS;

#pragma mark - 从百度坐标到GPS坐标
- (id)transformFromBDToGPS;

//取得Label中文字数组
+ (NSArray *)getLinesArrayOfStringInLabel:(UILabel *)label;

+ (UIImage *)createImageWithColor:(UIColor *)color;

//跳动View
+ (void)jumpAnimationView:(UIView *)sender;
    
//检查手机号
+ (BOOL)checkTel:(NSString *)str;

@end
