//
//  ExiuTools.m
//  ExiuCommonComponents
//
//  Created by SIMPLE PLAN on 15/9/29.
//  Copyright (c) 2015年 SIMPLE PLAN. All rights reserved.


#import "MyTools.h"
#import "sys/utsname.h"
#import <UIKit/UIKit.h>
#import <objc/runtime.h>
#import "Const.h"

@implementation MyTools

+ (NSString*)deviceString

{
    // 需要#import "sys/utsname.h"
    struct utsname systemInfo;
    
    
    uname(&systemInfo);
    
    NSString *platform = [NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding];
    
    
    if ([platform isEqualToString:@"iPhone1,1"])    return @"iPhone 2G";
    
    if ([platform isEqualToString:@"iPhone1,2"])    return @"iPhone 3G";
    
    if ([platform isEqualToString:@"iPhone2,1"])    return @"iPhone 3GS";
    
    if ([platform isEqualToString:@"iPhone3,1"])    return @"iPhone 4";
    
    if ([platform isEqualToString:@"iPhone3,2"])    return @"iPhone 4";
    
    if ([platform isEqualToString:@"iPhone3,3"])    return @"iPhone 4 (CDMA)";
    
    if ([platform isEqualToString:@"iPhone4,1"])    return @"iPhone 4S";
    
    if ([platform isEqualToString:@"iPhone5,1"])    return @"iPhone 5";
    
    if ([platform isEqualToString:@"iPhone5,2"])    return @"iPhone 5 (GSM+CDMA)";
    
    
    
    if ([platform isEqualToString:@"iPod1,1"])      return @"iPod Touch (1 Gen)";
    
    if ([platform isEqualToString:@"iPod2,1"])      return @"iPod Touch (2 Gen)";
    
    if ([platform isEqualToString:@"iPod3,1"])      return @"iPod Touch (3 Gen)";
    
    if ([platform isEqualToString:@"iPod4,1"])      return @"iPod Touch (4 Gen)";
    
    if ([platform isEqualToString:@"iPod5,1"])      return @"iPod Touch (5 Gen)";
    
    
    
    if ([platform isEqualToString:@"iPad1,1"])      return @"iPad";
    
    if ([platform isEqualToString:@"iPad1,2"])      return @"iPad 3G";
    
    if ([platform isEqualToString:@"iPad2,1"])      return @"iPad 2 (WiFi)";
    
    if ([platform isEqualToString:@"iPad2,2"])      return @"iPad 2";
    
    if ([platform isEqualToString:@"iPad2,3"])      return @"iPad 2 (CDMA)";
    
    if ([platform isEqualToString:@"iPad2,4"])      return @"iPad 2";
    
    if ([platform isEqualToString:@"iPad2,5"])      return @"iPad Mini (WiFi)";
    
    if ([platform isEqualToString:@"iPad2,6"])      return @"iPad Mini";
    
    if ([platform isEqualToString:@"iPad2,7"])      return @"iPad Mini (GSM+CDMA)";
    
    if ([platform isEqualToString:@"iPad3,1"])      return @"iPad 3 (WiFi)";
    
    if ([platform isEqualToString:@"iPad3,2"])      return @"iPad 3 (GSM+CDMA)";
    
    if ([platform isEqualToString:@"iPad3,3"])      return @"iPad 3";
    
    if ([platform isEqualToString:@"iPad3,4"])      return @"iPad 4 (WiFi)";
    
    if ([platform isEqualToString:@"iPad3,5"])      return @"iPad 4";
    
    if ([platform isEqualToString:@"iPad3,6"])      return @"iPad 4 (GSM+CDMA)";
    
    if ([platform isEqualToString:@"i386"])         return @"Simulator";
    
    if ([platform isEqualToString:@"x86_64"])       return @"Simulator";
    
    return platform;
    
}

/**
 每个云商品都会生成4张图片：
 1,原图（默认大小,如：IMG_0042.jpg）
 2,大图（宽度：960px, 高度：已宽度为准等比例缩放,图片名称：IMG_0042-big.jpg）
 3,中图（宽度：720px, 高度：已宽度为准等比例缩放,图片名称：IMG_0042-middle.jpg）
 4,小图（宽度：320px, 高度：已宽度为准等比例缩放,图片名称：IMG_0042-small.jpg）
 所有列表返回小图标，详情可以显示原图、大图、中图、小图，由手机分辨率或页面布局决定。
 */

/****
 http://test.izhangmai.com/upload/logo/150109/201501091311592000.jpg
 http://test.izhangmai.com/upload/logo/150109/201501091311592000-big
 ****/
+(NSString *)bigPictureURLFromOriginalURL:(NSString *)picurl
{
    NSMutableArray *array = [[picurl componentsSeparatedByString:@"."]mutableCopy];
    NSString *newString;
    if (array.count > 2) {
        NSInteger index = array.count - 2;
        NSString *picName = [array objectAtIndex:index];
        
        picName = [picName stringByAppendingString:@"-big"];
        [array replaceObjectAtIndex:index withObject:picName];
        for (int i = 0; i < array.count; i++) {
            
            if (i == 0) {
                newString = [array objectAtIndex:i];
            }else if(i < array.count){
                newString = [[newString stringByAppendingString:@"."]stringByAppendingString:[array objectAtIndex:i]];
            }
        }
        
        return newString;
    }
    
    return nil;
}
/**
 *  转换成中等图片的地址
 *
 *  @param url 初始地址（后台返回的）
 *
 *  @return 转换后的地址
 */
+ (NSString *)middlePictureURLFromOriginalURL:(NSString *)picurl
{
    NSMutableArray *array = [[picurl componentsSeparatedByString:@"."]mutableCopy];
    NSString *newString;
    if (array.count > 2)
    {
        NSInteger index = array.count - 2;
        NSString *picName = [array objectAtIndex:index];
        
        picName = [picName stringByAppendingString:@"-middle"];
        [array replaceObjectAtIndex:index withObject:picName];
        for (int i = 0; i < array.count; i++)
        {
            
            if (i == 0)
            {
                newString = [array objectAtIndex:i];
            }else if(i < array.count)
            {
                newString = [[newString stringByAppendingString:@"."]stringByAppendingString:[array objectAtIndex:i]];
            }
        }
        
        return newString;
    }
    
    return nil;
    
}
/**
 *  转换成小图片的地址
 *
 *  @param url 初始地址（后台返回的）
 *
 *  @return 转换后的地址
 */
+ (NSString *)smallPictureURLFromOriginalURL:(NSString *)picurl
{
    NSMutableArray *array = [[picurl componentsSeparatedByString:@"."]mutableCopy];
    NSString *newString;
    if (array.count > 2)
    {
        NSInteger index = array.count - 2;
        NSString *picName = [array objectAtIndex:index];
        
        picName = [picName stringByAppendingString:@"-small"];
        [array replaceObjectAtIndex:index withObject:picName];
        for (int i = 0; i < array.count; i++)
        {
            
            if (i == 0)
            {
                newString = [array objectAtIndex:i];
            }else if(i < array.count)
            {
                
                newString = [[newString stringByAppendingString:@"."]stringByAppendingString:[array objectAtIndex:i]];
                
            }
        }
        
        return newString;
    }
    
    return nil;
}


+ (BOOL)isPhoneNumber:(NSString *)phoneString
{
    
    NSString * MOBILE = @"^1[34578]{1}\\d{9}$";//@"^1(3[0-9]|5[0-35-9]|8[025-9])\\d{8}$";
    
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    
    if ([regextestmobile evaluateWithObject:phoneString] == YES)
    {
        return YES;
    }
    else
    {
        return NO;
    }
}


+ (BOOL)checkNotNullButString:(id)object
{
    if(![object isKindOfClass:[NSNull class]] && [object isKindOfClass:[NSString class]])
    {
        return YES;
    }
    return NO;
}


+ (BOOL)isUpdataAppWithNewVersion:(NSString *)version
{
    NSArray *newArray = [version componentsSeparatedByString:@"."];
    NSString *app_version = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    NSArray *oldArray = [app_version componentsSeparatedByString:@"."];
    
    if (newArray.count ==3 && oldArray.count > 1)
    {
        if ([newArray[0] floatValue] >[oldArray[0] floatValue] )
        {
            return YES;
        }else
        {
            if ([newArray[0] floatValue] ==[oldArray[0] floatValue])
            {
                if ([newArray[1] floatValue] >[oldArray[1] floatValue])
                {
                    return YES;
                }else
                {
                    if ([newArray[1] floatValue] ==[oldArray[1] floatValue])
                    {
                        if (oldArray.count >2)
                        {
                            if ([newArray[2] floatValue] >[oldArray[2] floatValue])
                            {
                                return YES;
                            }
                        }
                        
                    }
                    
                }
                
                
            }
            
        }
    }
    
    
    return NO;
}

/**
 *  用来判断userid是否存在，来确定是否已经登陆
 *
 *  @return YES:已经登陆，NO：未登陆
 */
+ (BOOL)checkLoginSuccessOrNot
{
 //  LoginUser *user = [LoginUser getLoginUser];
//    if(!user){
//        return NO;
//    }else
//    {
//        if (user.userId > 0) {
//            return YES;
//        }
//        return NO;
//    }
   NSString *login=[kUserDefault objectForKey:@"user_mobile"];
    if (login==nil) {
        return NO;
    }else
    return YES;
}

+(void)phoneTheNumber:(NSString *)phone WithView:(UIView *)view
{
    //   // [[UIApplication sharedApplication] openURL:[NSURL URLWithString:
    //                                                [NSString stringWithFormat:@"tel://%@", phone]]];
    UIWebView*callWebview =[[UIWebView alloc] init];
    NSString *tel = [NSString stringWithFormat:@"tel:%@",phone];
    NSURL *telURL =[NSURL URLWithString:tel];//@"tel:10010"];
    [callWebview loadRequest:[NSURLRequest requestWithURL:telURL]];
    
    //记得添加到view上
    [view addSubview:callWebview];
}

/**
 *  屏幕的宽度
 *
 *  @return 屏幕的宽度
 */
+ (float)screenWidth;
{
    if(UIInterfaceOrientationIsPortrait([UIApplication sharedApplication].statusBarOrientation))
    {
        //竖屏
        if([[UIDevice currentDevice].systemVersion floatValue] >= 8.0)
        {
            //系统版本号 >= 8.0
            return [UIScreen mainScreen].nativeBounds.size.width / [UIScreen mainScreen].nativeScale;
        }else
        {
            return [UIScreen mainScreen].bounds.size.width;
        }
    }else
    {
        //横屏
        if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0) {
            return [UIScreen mainScreen].nativeBounds.size.height/[UIScreen mainScreen].nativeScale;
        }else
        {
            return [UIScreen mainScreen].bounds.size.height;
        }
    }
}

/**
 *  屏幕的高度
 *
 *  @return 屏幕的高度
 */
+ (float)screenHeight;
{
    if (UIInterfaceOrientationIsLandscape([UIApplication sharedApplication].statusBarOrientation)) {
        if ([[UIDevice currentDevice].systemVersion floatValue]>=8.0) {
            if ([UIApplication sharedApplication].statusBarFrame.size.width>20) {
                return [UIScreen mainScreen].nativeBounds.size.width/[UIScreen mainScreen].nativeScale-20;
            }
            return [UIScreen mainScreen].nativeBounds.size.width/[UIScreen mainScreen].nativeScale;
        } else {
            if ([UIApplication sharedApplication].statusBarFrame.size.width>20) {
                return [UIScreen mainScreen].bounds.size.width-20;
            }
            return [UIScreen mainScreen].bounds.size.width;
        }
    } else {
        if ([[UIDevice currentDevice].systemVersion floatValue]>=8.0) {
            if ([UIApplication sharedApplication].statusBarFrame.size.height>20) {
                return [UIScreen mainScreen].nativeBounds.size.height/[UIScreen mainScreen].nativeScale-20;
            }
            return [UIScreen mainScreen].nativeBounds.size.height/[UIScreen mainScreen].nativeScale;
        } else {
            if ([UIApplication sharedApplication].statusBarFrame.size.height>20) {
                return [UIScreen mainScreen].bounds.size.height-20;
            }
            return [UIScreen mainScreen].bounds.size.height;
        }
    }
}
/**
 *  获得传入类实例的所有属性
 *
 *  @param model 类的实例
 *
 *  @return 类的所有属性
 */
+ (NSArray *)propertyKeysForClass:(id)className
{
    //ClassAChild *child = [ClassAChild new];
    unsigned int outCount, i;
    objc_property_t *properties = class_copyPropertyList(className, &outCount);
    NSMutableArray *keys = [[NSMutableArray alloc] initWithCapacity:outCount];
    for (i = 0; i < outCount; i++) {
        objc_property_t property = properties[i];
        NSString *propertyName = [[NSString alloc] initWithCString:property_getName(property) encoding:NSUTF8StringEncoding];
        [keys addObject:propertyName];
    }
    
    
    free(properties);
    return keys;
    
}
@end
