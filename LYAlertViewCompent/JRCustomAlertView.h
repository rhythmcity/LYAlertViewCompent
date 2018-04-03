//
//  JRCustomAlertView.h
//  LYAlertViewCompent
//
//  Created by liyan on 2018/4/2.
//  Copyright © 2018年 liyan. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "JRAlertViewModel.h"
typedef void(^AlertViewClick)(NSInteger index);


typedef NS_ENUM(NSUInteger, AlertViewStyleType) {
    AlertViewStyleTypeButtonHorizontal = 0,  // default   按钮横向排列， 标题  内容
    AlertViewStyleTypeButtonVertical = 1,   // 按钮纵向排列  按钮纵向排列， 标题  内容
    AlertViewStyleTypeSingleButton = 2,    // 只有一个按钮   标题  内容
};

@interface JRCustomAlertView : UIView

@property (nonatomic, strong, readonly) UIView *contentView; // 自定义样式的内容View


/**
  默认初始化

 @param title 标题
 @param message 内容
 @param type 按钮类型
 @param clickBlock 回调
 @param buttons 按钮的可变参数
 @return 实例
 */
+ (instancetype)alertViewWithTitle:(NSString *)title
                           message:(NSString *)message
                              type:(AlertViewStyleType)type
                             click:(AlertViewClick)clickBlock
                           buttons:(NSString *)buttons,... NS_REQUIRES_NIL_TERMINATION; 


/**
 默认初始化

 @param title 标题
 @param message 内容
 @param type 按钮类型
 @param clickBlock 回调
 @param buttons 按钮数组
 @return 实例
 */
+ (instancetype)alertViewWithTitle:(NSString *)title
                           message:(NSString *)message
                              type:(AlertViewStyleType)type
                             click:(AlertViewClick)clickBlock
                       buttonArray:(NSArray<JRAlertViewModel *> *)buttons;


- (void)showInView:(UIView *)view;

@end







#pragma mark - 标题 内容 可传 属性字符串
@interface JRCustomAlertView (AttributedString)

/**
 默认初始化
 
 @param title 标题属性字符串
 @param message 内容实行字符串
 @param type 按钮类型
 @param clickBlock 回调
 @param buttons 按钮的可变参数
 @return 实例
 */
+ (instancetype)alertViewWithAttributedTitle:(NSAttributedString *)title
                           Attributedmessage:(NSAttributedString *)message
                                        type:(AlertViewStyleType)type
                                       click:(AlertViewClick)clickBlock
                                     buttons:(NSString *)buttons,... NS_REQUIRES_NIL_TERMINATION;


/**
 默认初始化

 @param title 标题属性字符串
 @param message 内容实行字符串
 @param type 按钮类型
 @param clickBlock 回调
 @param buttons 按钮数组
 @return 实例
 */
+ (instancetype)alertViewWithAttributedTitle:(NSAttributedString *)title
                           Attributedmessage:(NSAttributedString *)message
                                        type:(AlertViewStyleType)type
                                       click:(AlertViewClick)clickBlock
                                 buttonArray:(NSArray <JRAlertViewModel *>*)buttons;



@end

#pragma mark - 可以自定义中间部分的View
@interface JRCustomAlertView (CustomContView)
/**
 默认初始化
 
 @param title 标题
 @param contentView 自定义View
 @param type 按钮类型
 @param clickBlock 回调
 @param buttons 按钮的可变参数
 @return 实例
 */
+ (instancetype)alertViewWithTitle:(NSString *)title
                       contentView:(UIView *)contentView
                              type:(AlertViewStyleType)type
                             click:(AlertViewClick)clickBlock
                           buttons:(NSString *)buttons,... NS_REQUIRES_NIL_TERMINATION;

/**
 默认初始化
 
 @param title 标题属性字符串
 @param contentView 自定义View
 @param type 按钮类型
 @param clickBlock 回调
 @param buttons 按钮的可变参数
 @return 实例
 */
+ (instancetype)alertViewWithAttributedTitle:(NSAttributedString *)title
                                 contentView:(UIView *)contentView
                                        type:(AlertViewStyleType)type
                                       click:(AlertViewClick)clickBlock
                                     buttons:(NSString *)buttons,... NS_REQUIRES_NIL_TERMINATION;


/**
 默认初始化
 
 @param title 标题
 @param contentView 自定义View
 @param type 按钮类型
 @param clickBlock 回调
 @param buttons 按钮数组
 @return 实例
 */
+ (instancetype)alertViewWithTitle:(NSString *)title
                       contentView:(UIView *)contentView
                              type:(AlertViewStyleType)type
                             click:(AlertViewClick)clickBlock
                       buttonArray:(NSArray <JRAlertViewModel *>*)buttons;



/**
 默认初始化
 
 @param title 标题属性字符串
 @param contentView 自定义View
 @param type 按钮类型
 @param clickBlock 回调
 @param buttons 按钮数组
 @return 实例
 */
+ (instancetype)alertViewWithAttributedTitle:(NSAttributedString *)title
                                 contentView:(UIView *)contentView
                                        type:(AlertViewStyleType)type
                                       click:(AlertViewClick)clickBlock
                                 buttonArray:(NSArray <JRAlertViewModel *>*)buttons;


@end

