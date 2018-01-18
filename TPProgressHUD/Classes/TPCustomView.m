//
//  TPCustomView.m
//  TPProgressHUDDemo
//
//  Created by tangpeng on 2017/9/14.
//  Copyright © 2017年 tangpeng. All rights reserved.
//

#import "TPCustomView.h"

#define superWidth self.superview.frame.size.width
#define superHeight self.superview.frame.size.height

@interface TPTipLabelView()

@property(nonatomic,strong) UILabel *tipLabel;

@property(nonatomic,assign) CGFloat w;
@property(nonatomic,assign) CGFloat h;

@end

@implementation TPTipLabelView

+ (instancetype)tipLabel{
    return [[self alloc] init];
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self reloadLabel];
    }
    return self;
}

- (void)reloadLabel{
    [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    self.backgroundColor = [UIColor blackColor];
    if (self.text) {
        self.tipLabel.text = self.text;
    }
    if (self.bgColor) {
        self.backgroundColor = self.bgColor;
    }
    if (self.textColor) {
        self.tipLabel.textColor = self.textColor;
    }
    
    _w = [self.tipLabel.text boundingRectWithSize:CGSizeMake(100, 0) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : self.tipLabel.font} context:nil].size.width;
    _h = [self.tipLabel.text boundingRectWithSize:CGSizeMake(100, 0) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : self.tipLabel.font} context:nil].size.height;
    
    [self addSubview:self.tipLabel];

    //NSLog(@"w: %lf,h:%lf",_w,_h);
}

- (void)layoutSubviews{
    [super layoutSubviews];

    if (self.text) {
        if (self.superview) {
            self.frame = CGRectMake(superWidth / 2 - (_w + 40) / 2, superHeight / 2 - (_h + 10) / 2, _w + 40, _h + 10);
        }
    }
    
    self.tipLabel.frame = CGRectMake(self.frame.size.width / 2 - (_w + 10) / 2, self.frame.size.height / 2 - _h / 2, _w + 10, _h);
}

- (UILabel *)tipLabel{
    if (!_tipLabel) {
        _tipLabel = [[UILabel alloc] init];
        _tipLabel.text = @"请自定义文字";
        _tipLabel.textColor = [UIColor whiteColor];
        _tipLabel.font = [UIFont systemFontOfSize:14];
        _tipLabel.textAlignment = NSTextAlignmentCenter;
        _tipLabel.numberOfLines = 0;
    }
    return _tipLabel;
}

@end


@interface TPCustomView()

@property(nonatomic,strong) UILabel *defaultLabel;

@property(nonatomic,strong) UIView *defaultView;

@property(nonatomic,strong) UIActivityIndicatorView *indicator;

@end

@implementation TPCustomView
+ (instancetype)customView{
    return [[self alloc] init];
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self reloadView];
    }
    return self;
}

- (void)reloadView{
    [self.defaultView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    self.alpha = 0.7;
    self.layer.cornerRadius = 10;
    self.layer.masksToBounds = YES;
    
    self.customLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:self.defaultView];
    if (self.customView || self.customLabel) {
        if (self.customView && !self.customLabel) {
            [self.defaultView addSubview:self.customView];
            [self.defaultView addSubview:self.defaultLabel];
        }else if (!self.customView && self.customLabel){
            [self.defaultView addSubview:self.indicator];
            [self.defaultView addSubview:self.customLabel];
        }else{
            [self.defaultView addSubview:self.customView];
            [self.defaultView addSubview:self.customLabel];
        }
    }else{
        [self.defaultView addSubview:self.defaultLabel];
        [self.defaultView addSubview:self.indicator];
    }
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    self.defaultView.frame = CGRectMake(0, 0, 100, 100);
    CGFloat labelWidth = self.customLabel.frame.size.width;
    CGFloat labelHeight = self.customLabel.frame.size.height;
    
    CGFloat viewWidth = self.customView.frame.size.width;
    CGFloat viewHeight = self.customView.frame.size.height;
    
    if (self.customView || self.customLabel) {
        
        if (self.customView && !self.customLabel) {
            self.defaultLabel.frame = CGRectMake(0, 50, 100, 30);
            self.customView.frame = CGRectMake(25, 0, viewWidth, viewHeight);
        }else if (!self.customView && self.customLabel){
            self.customLabel.frame = CGRectMake(0, 50, labelWidth, labelHeight);
            self.indicator.frame = CGRectMake(25, 0, 50, 50);
        }else{
            self.customLabel.frame = CGRectMake(0, 50, labelWidth, labelHeight);
            self.customView.frame = CGRectMake(25, 0, viewWidth, viewHeight);
        }
        
        
    }else{
        self.defaultLabel.frame = CGRectMake(0, 50, 100, 30);
        self.indicator.frame = CGRectMake(25, 0, 50, 50);
    }
    
}


#pragma mark - getter / setter

- (UIActivityIndicatorView *)indicator{
    if (!_indicator) {
        _indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
        [_indicator startAnimating];
    }
    return _indicator;
}

- (UIView *)defaultView{
    if (!_defaultView) {
        _defaultView = [[UIView alloc] init];  
    }
    return _defaultView;
}

- (UILabel *)defaultLabel{
    if (!_defaultLabel) {
        _defaultLabel = [[UILabel alloc] init];
        _defaultLabel.text = @"正在加载...";
        _defaultLabel.textColor = [UIColor whiteColor];
        _defaultLabel.font = [UIFont systemFontOfSize:14];
        _defaultLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _defaultLabel;
}

@end
