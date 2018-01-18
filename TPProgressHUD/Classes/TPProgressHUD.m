//
//  TPProgressHUD.m
//  TPProgressHUDDemo
//
//  Created by tangpeng on 2017/9/12.
//  Copyright © 2017年 tangpeng. All rights reserved.
//

#import "TPProgressHUD.h"
#import "TPCustomView.h"

#define TPViewHeight [UIScreen mainScreen].bounds.size.height
#define TPViewWidth [UIScreen mainScreen].bounds.size.width
#define TPKeyWindow [UIApplication sharedApplication].keyWindow

static NSInteger const TopEnableViewTag = 100000;
static NSInteger const HudViewTag = 99999;
static NSInteger const FullIndicatorViewTag = 10001;
static NSInteger const TopIndicatorViewTag = 10002;

@interface TPProgressHUD()
@property(nonatomic,strong) UIImageView *GIFImageView;
@end

@implementation TPProgressHUD
#pragma mark - class methods
+ (instancetype)hud{
    return [[self alloc] init];
}

+ (void)showHudInView:(UIView *)view{
    dispatch_async(dispatch_get_main_queue(), ^{
        [self showView:view indicator:[self indicatorView:view] tag:HudViewTag mode:TPProgressHUDDefaultMode];
    });
}

+ (void)showHudNavigationEnable{
    dispatch_async(dispatch_get_main_queue(), ^{

        [self showView:[self topEnableView] indicator:[self indicatorView] tag:TopEnableViewTag mode:TPProgressHUDDefaultMode];
    });
}

+ (void)showView:(UIView *)view indicator:(UIActivityIndicatorView *)indicator tag:(NSInteger)tag mode:(TPProgressHudMode)mode{

    UIView *hudView = [[UIView alloc] init];
    hudView.frame = view.frame;
    hudView.tag = tag;
    [indicator startAnimating];
    [hudView addSubview:indicator];
    [TPKeyWindow addSubview:hudView];
    
}

+ (void)hideHudView{
    for (UIView *view in TPKeyWindow.subviews) {
        if (view.tag == HudViewTag) {
            for (UIView *indicator in view.subviews) {
                
                UIActivityIndicatorView *indi = nil;
                if ([indicator isKindOfClass:[UIActivityIndicatorView class]] && indicator.tag == FullIndicatorViewTag) {
                    indi = (UIActivityIndicatorView *)indicator;
                    [indi stopAnimating];
                    [indi removeFromSuperview];
                    [view removeFromSuperview];
                }else if (indicator.tag == FullIndicatorViewTag) {
                    [indicator removeFromSuperview];
                    [view removeFromSuperview];
              
                }
                break;
            }
        }else if (view.tag == TopEnableViewTag) {
            for (UIActivityIndicatorView *indicator in view.subviews) {
                if (indicator.tag == TopIndicatorViewTag) {
                    [indicator stopAnimating];
                    [indicator removeFromSuperview];
                    [view removeFromSuperview];
                }
                break;
            }
        }
        
    }
}


#pragma mark - instance methods
- (void)showGifHud{
    
}

- (void)showTipInView:(UIView *)view hideAfterDelay:(NSTimeInterval)interval{
    TPTipLabelView *view1 = [TPTipLabelView tipLabel];
    view1.layer.cornerRadius = 5;
    view1.layer.masksToBounds = YES;
    view1.alpha = 0.8;
    view1.frame = CGRectMake(TPViewWidth/2 - 50, TPViewHeight/2 - 30, 100, 60);
    view1.text = self.tipText;
    view1.textColor = self.textColor;
    view1.bgColor = self.hudBgColor;
    [view addSubview:view1];
    [view1 reloadLabel];
    [TPKeyWindow addSubview:view];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(interval * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [view1 removeFromSuperview];
    });
}

- (void)showHudInView:(UIView *)view{
    dispatch_async(dispatch_get_main_queue(), ^{
        
        [self showView:view indicator:[self indicatorView:view] tag:HudViewTag mode:self.mode];
        
    });
}
- (void)showView:(UIView *)view indicator:(UIActivityIndicatorView *)indicator tag:(NSInteger)tag mode:(TPProgressHudMode)mode{

    UIColor *bgColor = self.hudBgColor;
    if (!bgColor) {
        bgColor = [UIColor blackColor];
    }
    
    UIView *hudView = [[UIView alloc] init];
    hudView.frame = view.frame;
    hudView.tag = tag;
    switch (mode) {
        case TPProgressHUDDefaultMode:
        {
            indicator.layer.cornerRadius = 5;
            indicator.layer.masksToBounds = YES;
            
            UIBlurEffect *effect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
            UIVisualEffectView *effectView = [[UIVisualEffectView alloc] initWithEffect:effect];
            effectView.frame = indicator.frame;
            [indicator addSubview:effectView];
            
            [indicator startAnimating];
            [hudView addSubview:indicator];
            [TPKeyWindow addSubview:hudView];
        }
            break;
        case TPProgressHUDCircleProgressMode:
        {
            UIView *bgView = [[UIView alloc] init];
            bgView.frame = CGRectMake(TPViewWidth/2 - 50, TPViewHeight/2 - 50, 100, 100);
            bgView.backgroundColor = bgColor;
            bgView.layer.cornerRadius = 10;
            bgView.layer.masksToBounds = YES;
            bgView.alpha = 0.8;
            
            UIBlurEffect *effect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
            UIVisualEffectView *effectView = [[UIVisualEffectView alloc] initWithEffect:effect];
            effectView.frame = bgView.bounds;
            [bgView addSubview:effectView];
            
            UIView *perView = [[UIView alloc] init];
            perView.backgroundColor = [UIColor orangeColor];
            perView.frame = CGRectMake(100 / 2 - 5, 100 / 2 - 5, 10, 10);
            perView.tag = FullIndicatorViewTag;
            perView.layer.cornerRadius = 5;
            perView.layer.masksToBounds = YES;
            
            bgView.tag = FullIndicatorViewTag;
            
            [self animation:perView withRect:CGRectMake(100/2 - 40, 100/2 - 40, 80, 80)];
            
            [bgView addSubview:perView];
            
            [hudView addSubview:bgView];
            [TPKeyWindow addSubview:hudView];
            
            NSLog(@"转圈圈");
        }
            break;
        case TPProgressHUDLineProgressMode:
        {
            NSLog(@"走直线");
            UIView *lineView = [[UIView alloc] init];
            lineView.backgroundColor = bgColor;
            lineView.frame = CGRectMake(TPViewWidth/2 - 75, TPViewHeight/2 - 15, 150, 30);
            lineView.layer.cornerRadius = 3;
            lineView.layer.masksToBounds = YES;
            [hudView addSubview:lineView];
            
            UIBlurEffect *effect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
            UIVisualEffectView *effectView = [[UIVisualEffectView alloc] initWithEffect:effect];
            effectView.frame = lineView.bounds;
            [lineView addSubview:effectView];
            
            UIView *progressView = [[UIView alloc] init];
            progressView.backgroundColor = [UIColor orangeColor];
            progressView.frame = CGRectMake(0, 0, 30, 30);
            [lineView addSubview:progressView];
            
            [self animationLine:progressView];
            
            lineView.tag = FullIndicatorViewTag;
            
            [TPKeyWindow addSubview:hudView];
        }
            break;
        case TPProgressHUDCustomProgressMode:
        {
            TPCustomView *view = [TPCustomView customView];
            view.frame = CGRectMake(TPViewWidth/2 - 50, TPViewHeight/2 - 50, 100, 100);
            [hudView addSubview:view];
            view.tag = FullIndicatorViewTag;
            view.backgroundColor = bgColor;
            
            if (self.customView || self.hudLabel) {
                view.customView = self.customView;
                view.customLabel = self.hudLabel;
                [view reloadView];
            }
            
            [TPKeyWindow addSubview:hudView];
        }
            break;
        case TPProgressHUDGIFProgressMode:
        {
            TPCustomView *view = [TPCustomView customView];
            view.frame = CGRectMake(TPViewWidth/2 - 50, TPViewHeight/2 - 50, 100, 100);
            [hudView addSubview:view];
            view.tag = FullIndicatorViewTag;
            view.backgroundColor = bgColor;
            
            if (self.customView || self.hudLabel) {
                view.customView = [self gifImageViewWithName:self.gifName];
                view.customLabel = self.hudLabel;
                [view reloadView];
            }
            
            [TPKeyWindow addSubview:hudView];
        }
            break;
    }
}

- (void)animationLine:(UIView *)view{
    //1.创建核心动画
    CAKeyframeAnimation *keyAnima = [CAKeyframeAnimation animation];
    //平移
    keyAnima.keyPath = @"position";
    //设置路径
    NSValue *v1 = [NSValue valueWithCGPoint:CGPointMake(0, 15)];
    NSValue *v2 = [NSValue valueWithCGPoint:CGPointMake(150, 15)];
    keyAnima.values = @[v1,v2];

    //1.2设置动画执行完毕后，不删除动画
    keyAnima.removedOnCompletion = NO;
    //1.3设置保存动画的最新状态
    keyAnima.fillMode = kCAFillModeForwards;
    //1.4设置动画执行的时间
    keyAnima.repeatCount = MAXFLOAT;
    keyAnima.speed = 0.2;
    //1.5设置动画的节奏
    keyAnima.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    
    keyAnima.calculationMode = @"cubicPaced";
    
    //2.添加核心动画
    [view.layer addAnimation:keyAnima forKey:nil];
    
}

- (void)animation:(UIView *)view withRect:(CGRect)rect{
    //1.创建核心动画
    CAKeyframeAnimation *keyAnima = [CAKeyframeAnimation animation];
    //平移
    keyAnima.keyPath = @"position";
    //1.1告诉系统要执行什么动画
    //创建一条路径
    CGMutablePathRef path = CGPathCreateMutable();
    //设置一个圆的路径
    CGPathAddEllipseInRect(path, NULL, rect);
    
    keyAnima.path = path;
    
    //有create就一定要有release
    CGPathRelease(path);
    //1.2设置动画执行完毕后，不删除动画
    keyAnima.removedOnCompletion = NO;
    //1.3设置保存动画的最新状态
    keyAnima.fillMode = kCAFillModeForwards;
    //1.4设置动画执行的时间
    keyAnima.repeatCount = MAXFLOAT;
    keyAnima.speed = 0.2;
    //1.5设置动画的节奏
    keyAnima.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    
    keyAnima.calculationMode = @"cubicPaced";
    
    //keyAnima.rotationMode = @"autoReverse";
    
    //2.添加核心动画
    [view.layer addAnimation:keyAnima forKey:nil];
}

- (void)hideHudView{
    for (UIView *view in TPKeyWindow.subviews) {
        if (view.tag == HudViewTag) {
            for (UIView *indicator in view.subviews) {
                
                UIActivityIndicatorView *indi = nil;
                if ([indicator isKindOfClass:[UIActivityIndicatorView class]] && indicator.tag == FullIndicatorViewTag) {
                    indi = (UIActivityIndicatorView *)indicator;
                    [indi stopAnimating];
                    [indi removeFromSuperview];
                    [view removeFromSuperview];
                }else if (indicator.tag == FullIndicatorViewTag) {
                    [indicator removeFromSuperview];
                    [view removeFromSuperview];
                    
                }
                break;
            }
        }
    }
}

#pragma mark - private
- (UIImageView *)gifImageViewWithName:(NSString *)imageName{
    UIImageView *imageView = [self GIFImageView:imageName];
    if (self.customView) {
        imageView.frame = self.customView.frame;
    }
    return imageView;
}
- (UIImageView *)GIFImageView:(NSString *)imageName{
    if (!_GIFImageView) {
        _GIFImageView = [[UIImageView alloc] init];
        _GIFImageView.backgroundColor = [UIColor clearColor];
        
        _GIFImageView.animationImages = [self gifImagesWithImage:imageName];
        _GIFImageView.animationDuration = 2;
        
        _GIFImageView.animationRepeatCount = 0;
        
        [_GIFImageView startAnimating];
    }
    return _GIFImageView;
}
- (NSArray *)gifImagesWithImage:(NSString *)imageName{
    NSURL *gifImageUrl = [[NSBundle mainBundle] URLForResource:imageName withExtension:@"gif"];
    //获取Gif图的原数据
    CGImageSourceRef gifSource = CGImageSourceCreateWithURL((CFURLRef)gifImageUrl, NULL);
    //获取Gif图有多少帧
    
    size_t gifcount = CGImageSourceGetCount(gifSource);
    
    NSMutableArray *imageS = [[NSMutableArray alloc] init];
    
    for (NSInteger i = 0; i < gifcount; i++) {
        
        //由数据源gifSource生成一张CGImageRef类型的图片
        
        CGImageRef imageRef = CGImageSourceCreateImageAtIndex(gifSource, i, NULL);
        
        UIImage *image = [UIImage imageWithCGImage:imageRef];
        
        [imageS addObject:image];
        
        CGImageRelease(imageRef);
        
    }
    CFRelease(gifSource);
    //得到图片数组
    return imageS;
}
#pragma mark - getter / setter
- (void)setGifName:(NSString *)gifName{
    _gifName = gifName;
}
- (void)setHudBgColor:(UIColor *)hudBgColor{
    _hudBgColor = hudBgColor;
}

- (void)setCustomView:(UIView *)customView{
    _customView = customView;
}

- (void)setHudLabel:(UILabel *)hudLabel{
    _hudLabel = hudLabel;
}

- (void)setMode:(TPProgressHudMode)mode{

    _mode = mode;
    
}

- (UIActivityIndicatorView *)indicatorView:(UIView *)view{
    
    CGFloat width = view.frame.size.width;
    CGFloat height = view.frame.size.height;
    UIActivityIndicatorView *indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    indicator.frame = CGRectMake(width / 2 - 25, height / 2 - 25, 50, 50);
    indicator.tag = FullIndicatorViewTag;
    indicator.backgroundColor = [UIColor blackColor];
    return indicator;
}

+ (UIActivityIndicatorView *)indicatorView:(UIView *)view{
    
    CGFloat width = view.frame.size.width;
    CGFloat height = view.frame.size.height;
    UIActivityIndicatorView *indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    indicator.frame = CGRectMake(width / 2 - 25, height / 2 - 25, 50, 50);
    indicator.tag = FullIndicatorViewTag;
    indicator.backgroundColor = [UIColor blackColor];
    return indicator;
}

+ (UIActivityIndicatorView *)indicatorView{
    UIActivityIndicatorView *indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    indicator.frame = CGRectMake(TPViewWidth / 2 - 25, TPViewHeight / 2 - 25, 50, 50);
    indicator.tag = TopIndicatorViewTag;
    indicator.backgroundColor = [UIColor blackColor];
    return indicator;
}

+ (UIView *)topEnableView{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 64, TPViewWidth, TPViewHeight- 64)];
    view.userInteractionEnabled = YES;
    view.tag = HudViewTag;
    return view;
}

@end
