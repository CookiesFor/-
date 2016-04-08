//
//  Const.h
//  Sppl
//
//  Created by SIMPLE PLAN on 15/9/23.
//  Copyright (c) 2015年 SIMPLE PLAN. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MBProgressHUD.h"

static const NSInteger  kTopViewBackGroundColor = 0x484774;
static const NSInteger  kTableViewBackGoundColor = 0xF6F6F6;


static NSInteger const kRequestTimeOutSecond = 15;

static NSString *const kRequestHeaderTokenKey = @"exiu-token";

static NSString *const kUserUid = @"userUid";
static NSString *const kTestPhone = @"18236910180";
static NSString *const kTestPassword = @"123456";

static NSString *const kSettingModelSavedName = @"setttingModel";

static NSString *const kGiftUid = @"36dcc5b44ef3f37d014efc62a61e002a";//玫瑰花礼物主键

#define kDeviceToken  @"DeviceToken"
#define kUserDefault   [NSUserDefaults standardUserDefaults]
#define kApplication   [UIApplication sharedApplication]

//获取屏幕 宽度、高度
#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)


//在线支付方式
typedef NS_ENUM(NSUInteger, PayStyle) {
    kPayStyle_ZhiFuBao = 0,
    kPayStyle_WeiXin,
    kPayStyle_YinHangKa,
};


//单例的宏
#define SYNTHESIZE_SINGLETON_FOR_CLASS(classname) \
\
static classname *shared##classname = nil; \
\
+ (classname *)shared##classname \
{ \
@synchronized(self) \
{ \
if (shared##classname == nil) \
{ \
shared##classname = [[self alloc] init]; \
} \
} \
\
return shared##classname; \
} \
\
+ (id)allocWithZone:(NSZone *)zone \
{ \
@synchronized(self) \
{ \
if (shared##classname == nil) \
{ \
shared##classname = [super allocWithZone:zone]; \
return shared##classname; \
} \
} \
\
return nil; \
} \
\
- (id)copyWithZone:(NSZone *)zone \
{ \
return self; \
}

#define kUserDefault   [NSUserDefaults standardUserDefaults]
#define kApplication   [UIApplication sharedApplication]

#define ShowHud(str)           do {  \
MBProgressHUD *hud1 = [MBProgressHUD showHUDAddedTo:self.view animated:YES];\
hud1.mode = MBProgressHUDModeText;\
hud1.removeFromSuperViewOnHide = YES;\
hud1.labelText = str;\
hud1.yOffset = -50;\
[hud1 hide:YES afterDelay:1.5];\
} while(0)


#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]


@interface Constant : NSObject

/**
 *  判断一段数字是否是手机号码
 *
 *  @param mobileNum 手机号码
 *
 *  @return 是否是手机号码
 */
+ (BOOL)isMobileNumber:(NSString *)mobileNum;

/**
 *  字典转Json
 *
 *  @param dic 字典
 *
 *  @return json string
 */
+ (NSString*)dictionaryToJson:(NSDictionary *)dic;

@end

