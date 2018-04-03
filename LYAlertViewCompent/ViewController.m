//
//  ViewController.m
//  LYAlertViewCompent
//
//  Created by liyan on 2018/4/2.
//  Copyright © 2018年 liyan. All rights reserved.
//

#import "ViewController.h"
#import "JRCustomAlertView.h"
#import "JRAlertViewModel.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    NSMutableArray *array = [NSMutableArray array];
    for (int i = 0; i< 2; i++) {
        JRAlertViewModel *model = [[JRAlertViewModel alloc] init];
        
        model.title = [NSString stringWithFormat:@"%d",i];
        model.titleColor = @"1111";
        
        [array addObject:model];
    }
    
    
    [[JRCustomAlertView alertViewWithTitle:@"请进行风险测评后购买" message:@"根据监管规定，购买理财产品前需进行风险测评。" type:AlertViewStyleTypeButtonVertical click:^(NSInteger index) {
        NSLog(@"%ld",(long)index);

    } buttons:@"1",@"2", nil] showInView:self.view];
    
    
    UIView *contentView =  [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 100)];
    contentView.backgroundColor = [UIColor redColor];
    
    
    
//    [[JRCustomAlertView alertViewWithAttributedTitle:[[NSAttributedString alloc] initWithString:@"通知"]  contentView:contentView type:AlertViewStyleTypeButtonHorizontal click:^(NSInteger index) {
//
//    } buttons:@"1",@"2" ,nil] showInView:self.view];
    
    
//    [[JRCustomAlertView alertViewWithTitle:@"通知" contentView:contentView type:AlertViewStyleTypeButtonHorizontal click:^(NSInteger index) {
//
//    } buttons:@"1",@"2" , nil] showInView:self.view];

    
    
  
    
    UITextField *text = [[UITextField alloc] initWithFrame:CGRectMake(0, 100, 200, 60)];
    text.keyboardType = UIKeyboardTypeNumberPad;
    text.keyboardAppearance = UIKeyboardAppearanceLight;
    [self.view addSubview:text];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
