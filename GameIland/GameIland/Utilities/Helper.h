//
//  Helper.h
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface Helper : NSObject

// 计算缓存
+ (NSString *)calculateCacheSize;
//字符串文字的长度
+(CGFloat)widthOfString:(NSString *)string font:(UIFont*)font height:(CGFloat)height;

//字符串文字的高度
+(CGFloat)heightOfString:(NSString *)string font:(UIFont*)font width:(CGFloat)width;

//获取今天的日期：年月日
+(NSDictionary *)getTodayDate;

//邮箱
+ (BOOL) justEmail:(NSString *)email;

//手机号码验证
+ (BOOL) justMobile:(NSString *)mobile;

//车牌号验证
+ (BOOL) justCarNo:(NSString *)carNo;

//车型
+ (BOOL) justCarType:(NSString *)CarType;

//用户名
+ (BOOL) justUserName:(NSString *)name;

//密码
+ (BOOL) justPassword:(NSString *)passWord;

//昵称
+ (BOOL) justNickname:(NSString *)nickname;

//身份证号
+ (BOOL) justIdentityCard: (NSString *)identityCard;

// NSUserDefaults 存值
+ (void)setObject:(id)obj forKey:(NSString *)key;
+ (void)setBool:(BOOL)b forKey:(NSString *)key;

// NSUserDefaults 取值
+ (id)objectForKey:(NSString *)key;
+ (BOOL)boolForKey:(NSString *)key;

//缓冲视图
+ (void)showHudToView:(UIView *)view text:(NSString *)text;
+ (void)hideHudFromView:(UIView *)view;

//创建导航栏控件
+(UIButton *)addNavBtnWithFrame:(CGRect)frame withTitle:(NSString *)title withIconName:(NSString *)iconName;
@end


