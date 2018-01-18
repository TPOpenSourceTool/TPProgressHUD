//
//  TPProgressHUD.h
//  TPProgressHUDDemo
//
//  Created by tangpeng on 2017/9/12.
//  Copyright © 2017年 tangpeng. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_OPTIONS(NSInteger, TPProgressHudMode) {
    TPProgressHUDDefaultMode,
    TPProgressHUDCircleProgressMode,
    TPProgressHUDLineProgressMode,
    TPProgressHUDCustomProgressMode,
    TPProgressHUDGIFProgressMode
};

@interface TPProgressHUD : NSObject
/*
 * 指示的类型,默认是default mode
 */
@property(nonatomic,assign) TPProgressHudMode mode;
/*
 * 自定义view,用于自定义hud view
 */
@property(nonatomic,strong) UIView *customView;
/*
 * 加载的lable,用于自定义显示文字
 */
@property(nonatomic,strong) UILabel *hudLabel;
/*
 * hud背景颜色
 */
@property(nonatomic,strong) UIColor *hudBgColor;
/*
 * 提示
 */
@property(nonatomic,strong) NSString *tipText;
/*
 * 文字颜色
 */
@property(nonatomic,strong) UIColor *textColor;
/*
 * gif name
 **/
@property(strong,nonatomic) NSString *gifName;

#pragma mark - methods
/*
 类方法一般提供默认的加载方式,如果需要定制,那么就使用实例方法
 */
+ (instancetype)hud;
/*
 * 指定显示view
 */
+ (void)showHudInView:(UIView *)view;

/*
 * 默认顶部导航栏可以点击
 */
+ (void)showHudNavigationEnable;
/*
 * 隐藏指示
 */
+ (void)hideHudView;

/*--------------------------分割线--------------------------*/

- (void)showHudInView:(UIView *)view;
/*
 * 显示提示语,设定时间后消失,只支持显示文字,支持自适应
 */
- (void)showTipInView:(UIView *)view hideAfterDelay:(NSTimeInterval)interval;

- (void)hideHudView;
/*
 * 显示gif图
 **/
- (UIImageView *)gifImageViewWithName:(NSString *)imageName;

@end
