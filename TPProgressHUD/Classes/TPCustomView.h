//
//  TPCustomView.h
//  TPProgressHUDDemo
//
//  Created by tangpeng on 2017/9/14.
//  Copyright © 2017年 tangpeng. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface TPTipLabelView : UIView

@property(nonatomic,strong) NSString *text;
@property(nonatomic,strong) UIColor *bgColor;
@property(nonatomic,strong) UIColor *textColor;
+ (instancetype)tipLabel;
- (void)reloadLabel;
@end

@interface TPCustomView : UIView
@property(nonatomic,strong) UIView *customView;
@property(nonatomic,strong) UILabel *customLabel;

+ (instancetype)customView;

- (void)reloadView;
@end
