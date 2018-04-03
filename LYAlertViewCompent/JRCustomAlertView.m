//
//  JRCustomAlertView.m
//  LYAlertViewCompent
//
//  Created by liyan on 2018/4/2.
//  Copyright © 2018年 liyan. All rights reserved.
//

#import "JRCustomAlertView.h"

@interface JRCustomAlertView ()
@property (nonatomic, copy)AlertViewClick clickBlock;
@property (nonatomic, strong) UIView *contentView;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *message;
@property (nonatomic, strong) NSAttributedString *attributedtitle;
@property (nonatomic, strong) NSAttributedString *attributedmessage;
@property (nonatomic, assign) AlertViewStyleType type;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *messageLabel;
@property (nonatomic, strong) UIView *boundingView;
@property (nonatomic, strong) UIView *backgroundView;
@end

static NSUInteger magicNumber = 2344;

@implementation JRCustomAlertView

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.backgroundView];
        [self addSubview:self.boundingView];
        
    }
    return self;
}

+ (instancetype)alertViewWithTitle:(NSString *)title
                           message:(NSString *)message
                              type:(AlertViewStyleType)type
                             click:(AlertViewClick)clickBlock
                           buttons:(NSString *)buttons,... {
    
    NSMutableArray *buttonArray = [NSMutableArray array];
    va_list args;
    va_start(args, buttons);
    for (NSString *key = buttons; key != nil; key = (__bridge NSString *)va_arg(args, void *)) {
        JRAlertViewModel *buttonModel = [[JRAlertViewModel alloc] init];
        buttonModel.title = key;
        buttonModel.titleColor = @"";
        [buttonArray addObject:buttonModel];
    }
    va_end(args);
    return [JRCustomAlertView alertViewWithTitle:title message:message type:type click:clickBlock buttonArray:buttonArray];;
}

+ (instancetype)alertViewWithTitle:(NSString *)title
                           message:(NSString *)message
                              type:(AlertViewStyleType)type
                             click:(AlertViewClick)clickBlock
                       buttonArray:(NSArray<JRAlertViewModel *> *)buttons {

    JRCustomAlertView *view  = [[JRCustomAlertView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    view.clickBlock = clickBlock;
    view.title = title;
    view.type = type;
    [view addTitleView:title];
    [view addMessageView:message];
    [view addButtons:buttons];
    return view;
}


#pragma mark - setter and getter

- (UIView *)boundingView {
    
    if (!_boundingView) {
        _boundingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width - 95, 0)];
        _boundingView.backgroundColor = [UIColor whiteColor];
    }
    return _boundingView;
}

- (UIView *)backgroundView {
    
    if (!_backgroundView) {
        _backgroundView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
        _backgroundView.backgroundColor= [UIColor colorWithRed:0 green:0 blue:0 alpha:0.6];
    }\
    return _backgroundView;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 24, self.boundingView.bounds.size.width - 48, 29)];
        _titleLabel.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1/1.0];
        _titleLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:17];
        _titleLabel.numberOfLines = 1;
         _titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _titleLabel;
}

- (UILabel *)messageLabel {
    if (!_messageLabel) {
        _messageLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.boundingView.bounds.size.width - 48, 0)];
        _messageLabel.textColor =  [UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1/1.0];
        _messageLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:14];
        _messageLabel.font = [UIFont systemFontOfSize:14];
        _messageLabel.numberOfLines = 0;
        _messageLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _messageLabel;
}

#pragma mark - action
- (void)addButtons:(NSArray *)buttonArray {
    
    CGFloat y = 0;
    
    if (!self.contentView) {
        if (!self.titleLabel.text.length && !self.messageLabel.text.length) {
            y = 24;
        } else if (self.titleLabel.text.length && !self.messageLabel.text.length) {
            
            y = CGRectGetMaxY(self.titleLabel.frame) + 24;
            
        } else {
            y = CGRectGetMaxY(self.messageLabel.frame) + 24;
        }
    } else {
          y = CGRectGetMaxY(self.contentView.frame);
    }
   
    

    switch (self.type) {
        case AlertViewStyleTypeButtonHorizontal:
        {
            
            if (!buttonArray.count ) {
                self.boundingView.frame = CGRectMake(self.boundingView.frame.origin.x, self.boundingView.frame.origin.y, self.boundingView.frame.size.width, CGRectGetMaxY(self.messageLabel.frame));
                return;
            }
            
            for (int i = 0 ; i < buttonArray.count ; i ++) {
                
                JRAlertViewModel *model = buttonArray[i];
                UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
                [button setTitle:model.title forState:UIControlStateNormal];
                [button setTitleColor:model.titleColor.length ? [UIColor blueColor] : [UIColor blackColor] forState:UIControlStateNormal];
                button.tag = magicNumber + i;
                [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
                button.frame = CGRectMake(self.boundingView.bounds.size.width / buttonArray.count * i, y, self.boundingView.bounds.size.width / buttonArray.count, 50);
                [self.boundingView addSubview:button];
                
                if (i != buttonArray.count - 1) {
                    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(button.frame) - 0.5, button.frame.origin.y, 0.5, button.frame.size.height)];
                    lineView.backgroundColor = [UIColor lightGrayColor];
                    
                    [self.boundingView addSubview:lineView];
                }
              
            
                self.boundingView.frame = CGRectMake(self.boundingView.frame.origin.x, self.boundingView.frame.origin.y, self.boundingView.frame.size.width, CGRectGetMaxY(button.frame));
            }
            
        }
            break;
        case AlertViewStyleTypeButtonVertical:{
            if (!buttonArray.count ) {
                self.boundingView.frame = CGRectMake(self.boundingView.frame.origin.x, self.boundingView.frame.origin.y, self.boundingView.frame.size.width, CGRectGetMaxY(self.messageLabel.frame));
                return;
            }
            
            for (int i = 0 ; i < buttonArray.count ; i ++) {
                
                JRAlertViewModel *model = buttonArray[i];
                UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
                [button setTitle:model.title forState:UIControlStateNormal];
                [button setTitleColor:model.titleColor.length ? [UIColor blueColor] : [UIColor blackColor] forState:UIControlStateNormal];
                button.tag = magicNumber + i;
                [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
                button.frame = CGRectMake(0, y + i * 50, self.boundingView.bounds.size.width, 50);
                [self.boundingView addSubview:button];
                
                UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0,  button.frame.origin.y , button.frame.size.width,0.5)];
                lineView.backgroundColor = [UIColor lightGrayColor];
                    
                [self.boundingView addSubview:lineView];

                self.boundingView.frame = CGRectMake(self.boundingView.frame.origin.x, self.boundingView.frame.origin.y, self.boundingView.frame.size.width, CGRectGetMaxY(button.frame));
            }
        }
            break;
        case AlertViewStyleTypeSingleButton: {
            if (!buttonArray.count ) {
                self.boundingView.frame = CGRectMake(self.boundingView.frame.origin.x, self.boundingView.frame.origin.y, self.boundingView.frame.size.width, CGRectGetMaxY(self.messageLabel.frame));
                return;
            }
           
                JRAlertViewModel *model = buttonArray[0];
                UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
                [button setTitle:model.title forState:UIControlStateNormal];
                [button setTitleColor:model.titleColor.length ? [UIColor blueColor] : [UIColor blackColor] forState:UIControlStateNormal];
                button.tag = magicNumber;
                [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
                button.frame = CGRectMake(0, y , self.boundingView.bounds.size.width, 50);
                [self.boundingView addSubview:button];
                
                UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0,  button.frame.origin.y , button.frame.size.width,0.5)];
                lineView.backgroundColor = [UIColor lightGrayColor];
                
                [self.boundingView addSubview:lineView];
                
                self.boundingView.frame = CGRectMake(self.boundingView.frame.origin.x, self.boundingView.frame.origin.y, self.boundingView.frame.size.width, CGRectGetMaxY(button.frame));
            
        }
            break;
            
        default:
        {
            
            if (!buttonArray.count ) {
                self.boundingView.frame = CGRectMake(self.boundingView.frame.origin.x, self.boundingView.frame.origin.y, self.boundingView.frame.size.width, CGRectGetMaxY(self.messageLabel.frame));
                return;
            }
            
            for (int i = 0 ; i < buttonArray.count ; i ++) {
                
                JRAlertViewModel *model = buttonArray[i];
                UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
                [button setTitle:model.title forState:UIControlStateNormal];
                [button setTitleColor:model.titleColor.length ? [UIColor blueColor] : [UIColor blackColor] forState:UIControlStateNormal];
                button.tag = magicNumber + i;
                [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
                button.frame = CGRectMake(self.boundingView.bounds.size.width / buttonArray.count * i, y, self.boundingView.bounds.size.width / buttonArray.count, 50);
                [self.boundingView addSubview:button];
                
                if (i != buttonArray.count - 1) {
                    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(button.frame) - 0.5, button.frame.origin.y, 0.5, button.frame.size.height)];
                    lineView.backgroundColor = [UIColor lightGrayColor];
                    
                    [self.boundingView addSubview:lineView];
                }
                
                
                self.boundingView.frame = CGRectMake(self.boundingView.frame.origin.x, self.boundingView.frame.origin.y, self.boundingView.frame.size.width, CGRectGetMaxY(button.frame));
            }
            
        }
            break;
    }
    
    
    self.boundingView.center = self.center;
}

- (void)addMessageView:(NSString *)message {
    
    
    if (!message.length) {
        return;
    }
    
    CGFloat height = [message boundingRectWithSize:CGSizeMake(self.boundingView.bounds.size.width - 48, 1000) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:self.messageLabel.font} context:nil].size.height;
    if (!self.titleLabel.text.length) {
        self.messageLabel.frame = CGRectMake(0, 24, self.boundingView.bounds.size.width - 48, height);
    } else {
        self.messageLabel.frame = CGRectMake(0, CGRectGetMaxY(self.titleLabel.frame) + 12, self.boundingView.bounds.size.width - 48, height);
    }
    
    [self.boundingView addSubview:self.messageLabel];
    self.messageLabel.center = CGPointMake(self.boundingView.center.x, self.messageLabel.center.y);
    self.messageLabel.text = message;
}

- (void)addTitleView:(NSString *)title {
    
    if (!title.length) {
        return;
    }
    
    self.titleLabel.center = CGPointMake(self.boundingView.center.x , self.titleLabel.center.y);
    [self.boundingView addSubview:self.titleLabel];
    self.titleLabel.text = title;
}


- (void)buttonClick:(UIButton *)sender {
    
    !self.clickBlock?:self.clickBlock(sender.tag  - magicNumber);
    
    [self dismiss];

}





- (void)showInView:(UIView *)view{
    
    if ([self superview]) {
        return;
    }
    
     [view addSubview:self];
    
     [self shakeToShow:self.boundingView];
    
}

- (void)shakeToShow:(UIView *)aView {
    CAKeyframeAnimation* animation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    animation.duration = 0.5;
    NSMutableArray *values = [NSMutableArray array];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.1, 0.1, 1.0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.2, 1.2, 1.0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.9, 0.9, 1.0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0, 1.0, 1.0)]];
    animation.values = values;
    [aView.layer addAnimation:animation forKey:nil];
}

- (void)dismiss {
    [self removeFromSuperview];
}

@end


@implementation JRCustomAlertView(AttributedString)

+ (instancetype)alertViewWithAttributedTitle:(NSAttributedString *)title
                           Attributedmessage:(NSAttributedString *)message
                                        type:(AlertViewStyleType)type
                                       click:(AlertViewClick)clickBlock
                                     buttons:(NSString *)buttons,... {
    NSMutableArray *buttonArray = [NSMutableArray array];
    va_list args;
    va_start(args, buttons);
    for (NSString *key = buttons; key != nil; key = (__bridge NSString *)va_arg(args, void *)) {
        JRAlertViewModel *buttonModel = [[JRAlertViewModel alloc] init];
        buttonModel.title = key;
        buttonModel.titleColor = @"";
        [buttonArray addObject:buttonModel];
    }
    va_end(args);
    return [JRCustomAlertView alertViewWithAttributedTitle:title Attributedmessage:message type:type click:clickBlock buttonArray:buttonArray];
}

+ (instancetype)alertViewWithAttributedTitle:(NSAttributedString *)title
                           Attributedmessage:(NSAttributedString *)message
                                        type:(AlertViewStyleType)type
                                       click:(AlertViewClick)clickBlock
                                 buttonArray:(NSArray <JRAlertViewModel *>*)buttons {
    JRCustomAlertView *view  = [[JRCustomAlertView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    view.clickBlock = clickBlock;
    view.attributedtitle = title;
    view.type = type;
    [view addAttibuteTitle:title];
    [view addAttibuteMessage:message];
    [view addButtons:buttons];
    return view;
}


- (void)addAttibuteTitle:(NSAttributedString *)title {
    
    if (!title.length) {
        return;
    }
    self.titleLabel.center = CGPointMake(self.boundingView.center.x , self.titleLabel.center.y);
    [self.boundingView addSubview:self.titleLabel];
    self.titleLabel.attributedText = title;
}

- (void)addAttibuteMessage:(NSAttributedString *)message {
    if (!message.length) {
        return;
    }

    CGFloat height = [message boundingRectWithSize:CGSizeMake(self.boundingView.bounds.size.width - 48, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading | NSStringDrawingTruncatesLastVisibleLine context:nil].size.height;
    if (!self.titleLabel.text.length) {
        self.messageLabel.frame = CGRectMake(0, 24, self.boundingView.bounds.size.width - 48, height);
    } else {
        self.messageLabel.frame = CGRectMake(0, CGRectGetMaxY(self.titleLabel.frame) + 12, self.boundingView.bounds.size.width - 48, height);
    }
    
    [self.boundingView addSubview:self.messageLabel];
    self.messageLabel.center = CGPointMake(self.boundingView.center.x, self.messageLabel.center.y);
    self.messageLabel.attributedText = message;
}
@end


@implementation JRCustomAlertView (CustomContView)
+ (instancetype)alertViewWithTitle:(NSString *)title
                       contentView:(UIView *)contentView
                              type:(AlertViewStyleType)type
                             click:(AlertViewClick)clickBlock
                           buttons:(NSString *)buttons,... {
    NSMutableArray *buttonArray = [NSMutableArray array];
    va_list args;
    va_start(args, buttons);
    for (NSString *key = buttons; key != nil; key = (__bridge NSString *)va_arg(args, void *)) {
        JRAlertViewModel *buttonModel = [[JRAlertViewModel alloc] init];
        buttonModel.title = key;
        buttonModel.titleColor = @"";
        [buttonArray addObject:buttonModel];
    }
    va_end(args);
    
    return [JRCustomAlertView alertViewWithTitle:title contentView:contentView type:type click:clickBlock buttonArray:buttonArray];
}

+ (instancetype)alertViewWithTitle:(NSString *)title
                       contentView:(UIView *)contentView
                              type:(AlertViewStyleType)type
                             click:(AlertViewClick)clickBlock
                       buttonArray:(NSArray <JRAlertViewModel *>*)buttons {
    
    JRCustomAlertView *view  = [[JRCustomAlertView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    view.clickBlock = clickBlock;
    view.title = title;
    view.contentView = contentView;
    view.type = type;
    [view addTitleView:title];
    [view addCustomContentView:contentView];
    [view addButtons:buttons];
    return view;
}


+ (instancetype)alertViewWithAttributedTitle:(NSAttributedString *)title
                                 contentView:(UIView *)contentView
                                        type:(AlertViewStyleType)type
                                       click:(AlertViewClick)clickBlock
                                     buttons:(NSString *)buttons,... {
    NSMutableArray *buttonArray = [NSMutableArray array];
    va_list args;
    va_start(args, buttons);
    for (NSString *key = buttons; key != nil; key = (__bridge NSString *)va_arg(args, void *)) {
        JRAlertViewModel *buttonModel = [[JRAlertViewModel alloc] init];
        buttonModel.title = key;
        buttonModel.titleColor = @"";
        [buttonArray addObject:buttonModel];
    }
    va_end(args);
    return [JRCustomAlertView alertViewWithAttributedTitle:title contentView:contentView type:type click:clickBlock buttonArray:buttonArray];
}


+ (instancetype)alertViewWithAttributedTitle:(NSAttributedString *)title
                                 contentView:(UIView *)contentView
                                        type:(AlertViewStyleType)type
                                       click:(AlertViewClick)clickBlock
                                 buttonArray:(NSArray <JRAlertViewModel *>*)buttons {
    
    JRCustomAlertView *view  = [[JRCustomAlertView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    view.clickBlock = clickBlock;
    view.attributedtitle = title;
    view.contentView = contentView;
    view.type = type;
    [view addAttibuteTitle:title];
    [view addCustomContentView:contentView];
    [view addButtons:buttons];
    return view;
}


- (void)addCustomContentView:(UIView *)contentView {
    
    if (!contentView) {
        return;
    }
    
    self.contentView = contentView;
    
    if (!self.titleLabel.text.length) {
        self.contentView.frame = CGRectMake(0, 24, self.boundingView.bounds.size.width, contentView.bounds.size.height);
    } else {
        self.contentView.frame = CGRectMake(0, CGRectGetMaxY(self.titleLabel.frame) + 12, self.boundingView.bounds.size.width, contentView.bounds.size.height);
    }
    
    [self.boundingView addSubview:contentView];
    
}


@end

