//
//  MyTools.h
//  Sppl
//
//  Created by SIMPLE PLAN on 15/9/29.
//  Copyright © 2015年 SIMPLE PLAN. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MyTools : NSObject

/**
 *  获取设备型号
 *
 *  @return 手机机型，比如：iPhone5s，iPad等
 */
+ (NSString*)deviceString;
/**
 *  转换成大图片的地址
 *
 *  @param url 初始地址（后台返回的）
 *
 *  @return 转换后的地址
 */
+(NSString *)bigPictureURLFromOriginalURL:(NSString *)url;
/**
 *  转换成中等图片的地址
 *
 *  @param url 初始地址（后台返回的）
 *
 *  @return 转换后的地址
 */
+(NSString *)middlePictureURLFromOriginalURL:(NSString *)url;
/**
 *  转换成小图片的地址
 *
 *  @param url 初始地址（后台返回的）
 *
 *  @return 转换后的地址
 */
+(NSString *)smallPictureURLFromOriginalURL:(NSString *)url;

/**
 *  验证手机号是否正确
 *
 *  @param phoneString 手机号码
 *
 *  @return yes：手机号码正确  NO：手机号码不正确
 */
+(BOOL)isPhoneNumber:(NSString *)phoneString;

/**
 *  检测是否为字符串
 *
 *  @param object
 *
 *  @return  yes：是    NO：否
 */
+ (BOOL)checkNotNullButString:(id)object;

/**
 *  验证版本号
 *
 *  @param version 服务器传回来版本号
 *
 *  @return yes 更新  no:不跟新
 */
+(BOOL)isUpdataAppWithNewVersion:(NSString *)version;

/**
 *  检测是否登陆
 *
 *  @return yes:登陆成功   NO：还没有登陆
 */
+(BOOL)checkLoginSuccessOrNot;

/**
 *  屏幕的宽度
 *
 *  @return 屏幕的宽度
 */
+ (float)screenWidth;

/**
 *  屏幕的高度
 *
 *  @return 屏幕的高度
 */
+ (float)screenHeight;

/**
 *  获得传入类实例的所有属性
 *
 *  @param model 类的实例
 *
 *  @return 类的所有属性
 */
+ (NSArray *)propertyKeysForClass:(id)className;


@end
