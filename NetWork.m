//
//  NetWork.m
//  demo
//
//  Created by SIMPLE PLAN on 15/10/12.
//  Copyright (c) 2015年 SIMPLE PLAN. All rights reserved.
//

#import "NetWork.h"
#import "AFNetworking.h"
#import "Const.h"
#import "NSString+Hashing.h"
#import "APService.h"
static AFHTTPRequestOperationManager *manager = nil;

@implementation NetWork


-(instancetype)init
{
    if (self = [super init]) {
        manager = [AFHTTPRequestOperationManager manager];
        manager.responseSerializer = [AFHTTPResponseSerializer serializer];
//        _isGetMethod = NO;
    }
    return self;
}

+(NetWork *)shareInstance
{
    __strong static NetWork *netWork = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        netWork = [[NetWork alloc] init];
    });
    return netWork;

}

- (void)requestData:(NSString *)path params:(NSDictionary *)params completion:(void (^)(id JSONObject))completion {
    if (_isGetMethod) {
        [manager GET:path parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
            if (operation.response.statusCode != 500) {
                NSData *data = [NSJSONSerialization dataWithJSONObject:responseObject options:NSJSONWritingPrettyPrinted error:nil];
                id result = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
                if (completion) {
                    completion(result);
                }
            }
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            if (completion) {
                completion(@{@"errorMsg":error.localizedDescription});
            }
        }];
    } else {
        [manager POST:path parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
            if (operation.response.statusCode != 500) {
                
                NSDictionary *result = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
                NSLog(@"result:%@",result);
                if (completion) {
                    completion(result);
                }
            }
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            if (completion) {
                completion(@{@"errorMsg":error.localizedDescription});
            }
        }];
    }
}

/**
 *  本地存放的没有guid，登陆
 */
- (void)loginWithMobile:(NSString *)phone
               password:(NSString *)password
               userflag:(NSString *)userflag
        completeHandler:(requestCompleteHandler)handler
{
 
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
//    NSString *sttt = [user stringForKey:@"regID"];
    NSString *jgid = [user stringForKey:@"jgid"];
    NSDictionary *parameters = @{@"user_mobile":phone,@"user_pwd":password,@"user_flag":userflag,@"jgid":jgid};
    

    
    [self requestData:kLogin params:parameters
           completion:^(id JSONObject) {
               handler(JSONObject);
           }];
}

/**
 *  本地存放的有guid，登录接口传guid
 *
 *  @param phone    电话号码
 *  @param password 密码
 *  @param handler  结果处理block
 */
- (void)loginWithMobile:(NSString *)phone
               password:(NSString *)password
                   guid:(NSString *)guid
               userflag:(NSString *)userflag
        completeHandler:(requestCompleteHandler)handler
{
    
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSString *jgid = [user stringForKey:@"jgid"];
    NSDictionary *parameters = @{@"user_mobile":phone,@"user_pwd":password,@"user_flag":userflag,@"jgid":jgid,@"guid":guid};
    
    
    
    [self requestData:kLogin params:parameters
           completion:^(id JSONObject) {
               handler(JSONObject);
           }];



}





/**
 *  获得手机验证码
 *
 *  @param account 	帐号（手机号码）
 */
- (void)getCodeWithMobile:(NSString*)account
                  handler:(requestCompleteHandler) handler;
{
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSString *sttt = [user stringForKey:@"regID"];
    //FIXME: 这里参数有问题，接口有问题，需要重新修改
    NSDictionary *parameter = @{@"user_mobile":account,@"token":sttt,@"user_flag":[NSString stringWithFormat:@"%d",3]};
    [self requestData:kGetMobileCode params:parameter completion:handler];
}

/**
 *  验证码是否有效
 *
 *  @param phone   接收验证码的手机号
 *  @param code    验证码
 *  @param handler block
 */
- (void)verifyAuthcode:(NSString *)phone
              Authcode:(NSString *)code
               handler:(requestCompleteHandler)handler
{
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSString *sttt = [user stringForKey:@"regID"];
    NSDictionary *parameter = @{@"user_mobile":phone,
                                @"vcode":code,@"token":sttt};
    [self requestData:kGetMobileCodeIsCorrect params:parameter completion:handler];
}

/**
 * 注册获取验证码
 */
-(void)getRegisterCodeWithMobile:(NSString *)account
                       
                         handler:(requestCompleteHandler) handler
{
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSString *sttt = [user stringForKey:@"regID"];
    //FIXME: 这里参数有问题，接口有问题，需要重新修改
    NSDictionary *parameter = @{@"user_mobile":account,@"token":sttt,@"user_flag":[NSString stringWithFormat:@"%d",3]};
    [self requestData:kRegisterGetCode params:parameter completion:handler];
}


/**
 *  注册
 *
 *  @param phone    手机号
 *  @param password 密码
 *  @param gender   验证码
 */
-(void)registerToUser:(NSString *)phone Password:(NSString *)password Gender:(NSString *)gender session_id:(NSString *)session_id userflag:(NSString *)userflag handler:(requestCompleteHandler)handler
{
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSString *sttt = [user stringForKey:@"regID"];
    NSDictionary *parameter = @{@"user_mobile":phone,
                                @"user_pwd":password,
                                @"vcode":gender,
                                @"session_id":session_id,
                                @"token":sttt,
                                @"user_flag":userflag,
                                @"jgid":sttt};
    [self requestData:kRegister params:parameter completion:handler];



}

/**
 * check version
 */
-(void)checkVersionHandler:(void (^)(NSString *))handler
{
//    NSString *MD5Str = @"simpleplan";
//    NSString *str = [NSString stringWithFormat:@"%d",2];
//    NSDictionary *parameter = @{@"version_id":str,@"token":[MD5Str MD5Hash]};
//
//    [self requestData:kCheckVersion params:parameter completion:handler];

}
/**
 *  获取用户信息
 */
-(void)getUserInformationid:(NSString *)Id handler:(requestCompleteHandler)handler
{
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSString *sttt = [user stringForKey:@"regID"];
    NSDictionary *parameter = @{@"token":sttt,@"user_id":Id};
    [self requestData:kGetUserMessage params:parameter completion:handler];

}

/**
 *  获取用户信息
 */
-(void)getExpressInformationid:(NSString *)Id handler:(requestCompleteHandler)handler
{
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSString *sttt = [user stringForKey:@"regID"];
    NSDictionary *parameter = @{@"token":sttt,@"express_id":Id};
    [self requestData:kGetExpressMessage params:parameter completion:handler];
    
}

/**
 *  重置密码
 */
-(void)setAgainPasswordWithPhone:(NSString *)phone Password:(NSString *)password session_id:(NSString *)session_id vcode:(NSString *)vcode handler:(requestCompleteHandler)handler
{
   
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSString *sttt = [user stringForKey:@"regID"];
    NSDictionary *parameter=@{@"user_mobile":phone,@"user_pwd":password,@"session_id":session_id,@"vcode":vcode,@"token":sttt,@"user_flag":[NSString stringWithFormat:@"%d",3]};
    [self requestData:kSetPasswordAgain params:parameter completion:handler];

}

/**
 * 获取评论详情
 */
-(void)getTheOrderCommentsWithOrderSN:(NSString *)ordersn handler:(requestCompleteHandler)handler
{
//    NSString *MD5Str = @"simpleplan";
//    NSDictionary *parameter = @{@"token":[MD5Str MD5Hash],@"order_sn":ordersn};
//    [self requestData:kGetCommentData params:parameter completion:handler];
}

/**
 * 获取快递员已完成订单
 **/
-(void)getUserOrderHistoryDetailWithUserID:(NSString *)userID page:(NSString *)page  handler:(requestCompleteHandler)handler
{
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSString *sttt = [user stringForKey:@"regID"];
    NSDictionary *parameter = @{@"token":sttt,@"user_id":userID,@"page":page};
    [self requestData:kGetUserFinshList params:parameter completion:handler];

}

/**
 * 获取用户订单状态
 **/
-(void)getUserOrderStatusWithOrderID:(NSString *)orderid OrderType:(NSString *)orderType handler:(requestCompleteHandler)handler
{
//    NSString *MD5Str = @"simpleplan";
//    NSDictionary *parameter = @{@"token":[MD5Str MD5Hash],@"id":orderid,@"order_type":orderType};
//    [self requestData:kOrderDetailOfStatus params:parameter completion:handler];

}

/**
 * 用户钱包
 **/
-(void)getMessageForUserMoneyWithUserID:(NSString *)userId handler:(requestCompleteHandler)handler
{
//    NSString *MD5Str = @"simpleplan";
//    NSDictionary *parameter = @{@"token":[MD5Str MD5Hash],@"user_id":userId};
//    [self requestData:kGetMessageForMoney params:parameter completion:handler];

}

/**
 * 提现明细
 **/
-(void)getMessageDetailForUserWithUserID:(NSString *)userId page:(NSInteger)page handler:(requestCompleteHandler)handler
{
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSString *sttt = [user stringForKey:@"regID"];
    NSDictionary *parameter = @{@"token":sttt,@"user_id":userId,@"page":[NSString stringWithFormat:@"%ld",page]};
    [self requestData:kGetWithdrawalRecord params:parameter completion:handler];
}

/**
 * 账户变更明细
 **/
-(void)getExpressMessageForUserWithUserID:(NSString *)userID page:(NSInteger)page handler:(requestCompleteHandler)handler
{
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSString *sttt = [user stringForKey:@"regID"];
    NSDictionary *parameter = @{@"token":sttt,@"user_id":userID,@"page":[NSString stringWithFormat:@"%ld",page],@"user_flag":[NSString stringWithFormat:@"%d",3],@"device":[NSString stringWithFormat:@"%d",2]};
    [self requestData:kGetMoneyDetail params:parameter completion:handler];
}

/**
 * 评论
 **/
-(void)submitCommentWithOrderSN:(NSString *)ordersn questionOneTextView:(NSString *)questionOne questionTwo:(NSString *)questionTwo questionThree:(NSString *)questionThree commentScore:(NSString *)commentScore handler:(requestCompleteHandler)handler
{
//    NSString *str = @"simpleplan";
//    
//    NSDictionary *parameter = @{@"token":[str MD5Hash],@"order_sn":ordersn,@"answer_ret_1":questionOne,@"answer_ret_2":questionTwo,@"answer_ret_3":questionThree,@"comment_score":commentScore};
//    [self requestData:kAddComment params:parameter completion:handler];
}

/**
 * 修改手机号时获取验证那么
 **/
-(void)getCodeForUpdatePhoneNumberWithUserID:(NSString *)userid
                              oldPhoneNumber:(NSString *)oldPhoneNumber
                                     handler:(requestCompleteHandler)handler
{
    
   
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSString *sttt = [user stringForKey:@"regID"];
    NSDictionary *parameter = @{@"token":sttt,@"user_id":userid,@"oldname":oldPhoneNumber,@"user_flag":[NSString stringWithFormat:@"%d",3]};
    [self requestData:kGetCodeForUpdateNumber params:parameter completion:handler];
    
}
/**
 * 修改帐号
 **/
-(void)updateUserMobileWithUserId:(NSString *)userid
                        userPhone:(NSString *)userPhone
                            vcode:(NSString *)vcode
                        sessionId:(NSString *)sessionId
                          iconStr:(NSString *)iconStr
                          handler:(requestCompleteHandler)handler
{
    
  
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSString *sttt = [user stringForKey:@"regID"];
    NSDictionary *parameter = @{@"token":sttt,@"user_id":userid,@"user_name":userPhone,@"vcode":vcode,@"session_id":sessionId,@"user_avatar":iconStr};
    [self requestData:kUpdatePhoneNumber params:parameter completion:handler];
    
    
}

/**
 * 修改密码
 **/
-(void)updateUserPasswordWithUserID:(NSString *)userid oldPassword:(NSString *)oldPassword newPassword:(NSString *)newPassword handler:(requestCompleteHandler)handler
{
   
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSString *sttt = [user stringForKey:@"regID"];
    NSDictionary *parameter = @{@"token":sttt,@"user_id":userid,@"user_pwd":newPassword,@"oldpasswd":oldPassword};
    [self requestData:kUpdateUserPassword params:parameter completion:handler];
    
    
}


/**
 * 修改昵称
 **/
-(void)updateUserNameWithUserID:(NSString *)userid realName:(NSString *)realName handler:(requestCompleteHandler)handler
{
    
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSString *sttt = [user stringForKey:@"regID"];
    NSDictionary *parameter = @{@"token":sttt,@"user_id":userid,@"nick_name":realName};
    [self requestData:kUpdateuserName params:parameter completion:handler];
    
    
}

/**
 * 获取通知消息
 **/
-(void)getSystemMessageWithUserID:(NSString *)userid handler:(requestCompleteHandler)handler
{
   
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSString *sttt = [user stringForKey:@"regID"];
    NSDictionary *parameter = @{@"token":sttt,@"user_id":userid};
    [self requestData:kPath params:parameter completion:handler];

}

/**
 * 快递员接单
 **/
-(void)userGetOrderWithUserId:(NSString *)userid ordersn:(NSString *)ordersn ordertype:(NSString *)ordertype  expressTime:(NSString *)expressTime adistance:(NSString *)adistance bdistance:(NSString *)bdistance  handler:(requestCompleteHandler)handler
{
    
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSString *sttt = [user stringForKey:@"regID"];
   
       NSDictionary *parameter = @{@"token":sttt,@"express_id":userid,@"order_sn":ordersn,@"order_type":ordertype,@"express_time":expressTime,@"adistance":adistance,@"bdistance":bdistance};
    
    
    [self requestData:kGetOrder params:parameter completion:handler];

}

/**
 * 快递员接单买保险
 **/
-(void)userBuyInsuranceGetOrderWithUserId:(NSString *)userid ordersn:(NSString *)ordersn ordertype:(NSString *)ordertype  expressTime:(NSString *)expressTime adistance:(NSString *)adistance bdistance:(NSString *)bdistance  handler:(requestCompleteHandler)handler
{
    
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSString *sttt = [user stringForKey:@"regID"];
    
    NSDictionary *parameter = @{@"token":sttt,@"express_id":userid,@"order_sn":ordersn,@"order_type":ordertype,@"express_time":expressTime,@"adistance":adistance,@"bdistance":bdistance,@"isbao":[NSString stringWithFormat:@"%d",1]};
    
    
    [self requestData:kGetOrder params:parameter completion:handler];
    
}



/**
 * 快递员提现
 **/
-(void)userSubmitMoneyMessageWithUserId:(NSString *)userid accountType:(NSString *)accountType accountInfo:(NSString *)accountInfo withdrawMoney:(NSString *)withdrawMoney realName:(NSString *)realName bankName:(NSString *)bankName handler:(requestCompleteHandler)handler
{
    
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSString *sttt = [user stringForKey:@"regID"];
    
    NSDictionary *parameter = @{@"token":sttt,@"user_id":userid,@"account_type":accountType,@"account_info":accountInfo,@"withdraw_money":withdrawMoney,@"real_name":realName,@"bank_name":bankName};
    
    [self requestData:kSubmitMessageForMoney params:parameter completion:handler];
}

/**
 * 快递员添加帐户
 **/
-(void)userAddAccountMessageWithUserId:(NSString *)userid bindType:(NSString *)bindType bindName:(NSString *)bindName bindCard:(NSString *)bindCard realName:(NSString *)realName vcode:(NSString *)vcode sessionId:(NSString *)sessionId  handler:(requestCompleteHandler)handler
{
   
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSString *sttt = [user stringForKey:@"regID"];
    NSDictionary *parameter = @{@"token":sttt,@"user_id":userid,@"bind_type":bindType,@"real_name":realName,@"bind_card":bindCard,@"bind_name":bindName,@"vcode":vcode,@"session_id":sessionId};
    [self requestData:kUserAddAccountMessage params:parameter completion:handler];


}

/**
 * 意见反馈
 **/
-(void)userAddOrderMessageWithUserId:(NSString *)userid message:(NSString *)message handler:(requestCompleteHandler)handler
{
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSString *sttt = [user stringForKey:@"regID"];
    NSDictionary *parameter = @{@"user_id":userid,@"message":message,@"token":sttt};
    [self requestData:kAddOrderMessage params:parameter completion:handler];
}

/**
 * 订单id获取订单详情
 **/
-(void)orderSnWithOrderDetailWithOrderSn:(NSString *)ordersn orderType:(NSString *)orderType handler:(requestCompleteHandler)handler
{
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSString *sttt = [user stringForKey:@"regID"];
    NSString *userID = [user stringForKey:@"id"];
    NSDictionary *parameter = @{@"id":ordersn,@"order_type":orderType,@"token":sttt,@"user_id":userID};
    [self requestData:kOrderDetail params:parameter completion:handler];
}

/**
 * 个人中心
 **/
-(void)getPersonMessageWithPersonID:(NSString *)personID handler:(requestCompleteHandler)handler
{
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSString *sttt = [user stringForKey:@"regID"];
    NSDictionary *parameter = @{@"user_id":personID,@"token":sttt};
    [self requestData:kPerson params:parameter completion:handler];

}

/**
 *冻结资金
 **/
-(void)getFreezeMoneyMesageWithUserID:(NSString *)userID handler:(requestCompleteHandler)handler
{
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSString *sttt = [user stringForKey:@"regID"];
    NSDictionary *parameter = @{@"user_id":userID,@"token":sttt};
    [self requestData:kFreezeMoney params:parameter completion:handler];

}

/**
 *冻结资金明细
 **/
-(void)getFreezeDetailMoneyMesageWithUserID:(NSString *)userID withPage:(NSInteger)page handler:(requestCompleteHandler)handler
{
    
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSString *sttt = [user stringForKey:@"regID"];
    NSDictionary *parameter = @{@"user_id":userID,@"token":sttt};
    [self requestData:kFreezeDetailMoney params:parameter completion:handler];

}

/**
 * 计时开始
 **/
-(void)startTimeWithExpressID:(NSString *)userID handler:(requestCompleteHandler)handler
{
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSString *sttt = [user stringForKey:@"regID"];
    NSDictionary *parameter = @{@"user_id":userID,@"token":sttt};
    [self requestData:kStartTime params:parameter completion:handler];
}

/**
 * 计时结束
 **/
-(void)stopTimeWithExpressID:(NSString *)userID handler:(requestCompleteHandler)handler
{
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSString *sttt = [user stringForKey:@"regID"];
    NSDictionary *parameter = @{@"user_id":userID,@"token":sttt};
    [self requestData:kStopTime params:parameter completion:handler];

}

/**
 * 获取在线时长
 **/
-(void)getOnlineTimeWithExpressID:(NSString *)userID handler:(requestCompleteHandler)handler
{
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSString *sttt = [user stringForKey:@"regID"];
    NSDictionary *parameter = @{@"user_id":userID,@"token":sttt};
    [self requestData:kgetOnlineTime params:parameter completion:handler];

}

/**
 * 刷新订单页面
 **/
-(void)getOrderMessageWithExpressID:(NSString *)userID lng:(NSString *)lng lat:(NSString *)lat page:(NSInteger)page handler:(requestCompleteHandler)handler
{
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSString *sttt = [user stringForKey:@"regID"];
   NSDictionary *parameter = @{@"lng":lng,@"lat":lat,@"page":[NSString stringWithFormat:@"%ld",page],@"token":sttt,@"user_id":userID};
    [self requestData:kGetOrderListMessage params:parameter completion:handler];
}

/**
 * 订单详情
 **/
-(void)getOrderInformationWIthExpressID:(NSString *)userID orderType:(NSString *)orderType orderID:(NSString *)orderID handler:(requestCompleteHandler)handler
{
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSString *sttt = [user stringForKey:@"regID"];
    NSDictionary *parameter = @{@"user_id":userID,@"id":orderID,@"order_type":orderType,@"token":sttt};

    [self requestData:kOrderDetail params:parameter completion:handler];
}

/**
 * 保险
 **/
-(void)buyInsuranceWithExpressID:(NSString *)userID handler:(requestCompleteHandler)handler
{
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSString *sttt = [user stringForKey:@"regID"];
    NSDictionary *parameter = @{@"user_id":userID,@"token":sttt};
    [self requestData:kInsurance params:parameter completion:handler];

}

@end
