//
//  NetWork.h
//  demo
//
//  Created by SIMPLE PLAN on 15/10/12.
//  Copyright (c) 2015年 SIMPLE PLAN. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^requestCompleteHandler)(id dic);
typedef void(^requestFailHandler)(NSDictionary *errorDic);

@interface NetWork : NSObject

@property (nonatomic, assign) BOOL isGetMethod;


+ (NetWork *)shareInstance;

/**
 *  登录接口
 *
 *  @param phone    电话号码
 *  @param password 密码
 *  @param handler  结果处理block
 */
- (void)loginWithMobile:(NSString *)phone
               password:(NSString *)password
               userflag:(NSString *)userflag
        completeHandler:(requestCompleteHandler)handler;


/**
 *  登录接口传guid
 *
 *  @param phone    电话号码
 *  @param password 密码
 *  @param handler  结果处理block
 */
- (void)loginWithMobile:(NSString *)phone
               password:(NSString *)password
                   guid:(NSString *)guid
               userflag:(NSString *)userflag
        completeHandler:(requestCompleteHandler)handler;



-(void)getRegisterCodeWithMobile:(NSString *)account
                       
                         handler:(requestCompleteHandler) handler;



/**
 *  获得手机验证码
 *
 *  @param account 	帐号（手机号码）
 */
- (void)getCodeWithMobile:(NSString*)account
                  handler:(requestCompleteHandler) handler;
/**
 *  验证码是否有效
 *
 *  @param phone   接收验证码的手机号
 *  @param code    验证码
 *  @param handler block
 */
- (void)verifyAuthcode:(NSString *)phone
              Authcode:(NSString *)code
               handler:(requestCompleteHandler)handler;

/**
 *  注册
 *
 *  @param phone    手机号
 *  @param password 密码
 *  @param gender   验证码
 */
- (void)registerToUser:(NSString *)phone
              Password:(NSString *)password
                Gender:(NSString *)gender
            session_id:(NSString *)session_id
              userflag:(NSString *)userflag
               handler:(requestCompleteHandler)handler;

/** 
 * Check version 
 */
- (void)checkVersionHandler:(void (^)(NSString *versionString))handler;


/**
 * 获取用户信息
 **/
-(void)getUserInformationid:(NSString *)Id handler:(requestCompleteHandler)handler;

/**
 * 获取用户信息
 **/
-(void)getExpressInformationid:(NSString *)Id handler:(requestCompleteHandler)handler;

/**
 * 重置密码
 */
-(void)setAgainPasswordWithPhone:(NSString *)phone
                        Password:(NSString *)password
                      session_id:(NSString *)session_id
                           vcode:(NSString *)vcode
                         handler:(requestCompleteHandler)handler;
/**
 * 获取评论详情
 */
-(void)getTheOrderCommentsWithOrderSN:(NSString *)ordersn
                              handler:(requestCompleteHandler)handler;

/**
 * 快递员已完成订单
 **/
-(void)getUserOrderHistoryDetailWithUserID:(NSString *)userID
                                      page:(NSString *)page
                                   handler:(requestCompleteHandler)handler;


/**
 * 用户订单状态
 **/
-(void)getUserOrderStatusWithOrderID:(NSString *)orderid
                           OrderType:(NSString *)orderType
                             handler:(requestCompleteHandler)handler;

/**
 * 用户钱包
 **/
-(void)getMessageForUserMoneyWithUserID:(NSString *)userId
                                handler:(requestCompleteHandler)handler;


/**
 * 提现明细
 **/
-(void)getMessageDetailForUserWithUserID:(NSString *)userId page:(NSInteger)page handler:(requestCompleteHandler)handler;

/**
 * 账户余额变更明晰
 **/
-(void)getExpressMessageForUserWithUserID:(NSString *)userID page:(NSInteger)page handler:(requestCompleteHandler)handler;

/**
 * 评论
 **/
-(void)submitCommentWithOrderSN:(NSString *)ordersn
            questionOneTextView:(NSString *)questionOne
                    questionTwo:(NSString *)questionTwo
                  questionThree:(NSString *)questionThree
                   commentScore:(NSString *)commentScore
                        handler:(requestCompleteHandler)handler;

/**
 * 修改手机号时获取验证那么
 **/
-(void)getCodeForUpdatePhoneNumberWithUserID:(NSString *)userid
                              oldPhoneNumber:(NSString *)oldPhoneNumber
                                     handler:(requestCompleteHandler)handler;

/**
 * 修改帐号
 **/
-(void)updateUserMobileWithUserId:(NSString *)userid
                        userPhone:(NSString *)userPhone
                            vcode:(NSString *)vcode
                        sessionId:(NSString *)sessionId
                          iconStr:(NSString *)iconStr
                          handler:(requestCompleteHandler)handler;

/**
 * 修改密码
 **/
-(void)updateUserPasswordWithUserID:(NSString *)userid oldPassword:(NSString *)oldPassword newPassword:(NSString *)newPassword handler:(requestCompleteHandler)handler;

/**
 * 修改昵称
 **/
-(void)updateUserNameWithUserID:(NSString *)userid realName:(NSString *)realName handler:(requestCompleteHandler)handler;

/**
 * 获取通知消息
 **/
-(void)getSystemMessageWithUserID:(NSString *)userid handler:(requestCompleteHandler)handler;


/**
 * 快递员接单
 **/
-(void)userGetOrderWithUserId:(NSString *)userid ordersn:(NSString *)ordersn ordertype:(NSString *)ordertype expressTime:(NSString *)expressTime adistance:(NSString *)adistance bdistance:(NSString *)bdistance handler:(requestCompleteHandler)handler;

/**
 * 快递员接单买保险
 **/
-(void)userBuyInsuranceGetOrderWithUserId:(NSString *)userid ordersn:(NSString *)ordersn ordertype:(NSString *)ordertype expressTime:(NSString *)expressTime adistance:(NSString *)adistance bdistance:(NSString *)bdistance handler:(requestCompleteHandler)handler;


/**
 * 快递员提现
 **/
-(void)userSubmitMoneyMessageWithUserId:(NSString *)userid accountType:(NSString *)accountType  accountInfo:(NSString *)accountInfo withdrawMoney:(NSString *)withdrawMoney realName:(NSString *)realName bankName:(NSString *)bankName handler:(requestCompleteHandler)handler;

/**
 * 快递员添加帐户
 **/
-(void)userAddAccountMessageWithUserId:(NSString *)userid bindType:(NSString *)bindType bindName:(NSString *)bindName bindCard:(NSString *)bindCard realName:(NSString *)realName vcode:(NSString *)vcode sessionId:(NSString *)sessionId handler:(requestCompleteHandler)handler;

/**
 *意见反馈
 **/
-(void)userAddOrderMessageWithUserId:(NSString *)userid message:(NSString *)message handler:(requestCompleteHandler)handler;

/**
 * 订单id获取订单详情
 **/
-(void)orderSnWithOrderDetailWithOrderSn:(NSString *)ordersn orderType:(NSString *)orderType handler:(requestCompleteHandler)handler;

/**
 * 个人中心
 **/
-(void)getPersonMessageWithPersonID:(NSString *)personID handler:(requestCompleteHandler)handler;

/**
 *冻结资金
 **/
-(void)getFreezeMoneyMesageWithUserID:(NSString *)userID handler:(requestCompleteHandler)handler;

/**
 *冻结资金明细
 **/
-(void)getFreezeDetailMoneyMesageWithUserID:(NSString *)userID withPage:(NSInteger)page handler:(requestCompleteHandler)handler;

/**
 * 计时开始
 **/
-(void)startTimeWithExpressID:(NSString *)userID handler:(requestCompleteHandler)handler;


/**
 * 计时结束
 **/
-(void)stopTimeWithExpressID:(NSString *)userID handler:(requestCompleteHandler)handler;


/**
 * 获取在线时长
 **/
-(void)getOnlineTimeWithExpressID:(NSString *)userID handler:(requestCompleteHandler)handler;

/**
 * 刷新订单页面
 **/
-(void)getOrderMessageWithExpressID:(NSString *)userID lng:(NSString *)lng lat:(NSString *)lat page:(NSInteger)page handler:(requestCompleteHandler)handler;

/**
 * 订单详情
 **/
-(void)getOrderInformationWIthExpressID:(NSString *)userID orderType:(NSString *)orderType orderID:(NSString *)orderID handler:(requestCompleteHandler)handler;

/**
 * 保险
 **/
-(void)buyInsuranceWithExpressID:(NSString *)userID handler:(requestCompleteHandler)handler;

@end
