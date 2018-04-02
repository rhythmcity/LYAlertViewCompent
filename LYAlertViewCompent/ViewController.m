//
//  ViewController.m
//  LYAlertViewCompent
//
//  Created by liyan on 2018/4/2.
//  Copyright © 2018年 liyan. All rights reserved.
//

#import "ViewController.h"
#import "JRCustomAlertView.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
//    [[JRCustomAlertView alertViewWithTitle:@"请进行风险测评后购买" message:@"根据监管规定，购买理财产品前需进行风险测评。" type:AlertViewStyleTypeButtonVertical click:^(NSInteger index) {
//
//    } buttons:@"1",@"2", nil] showInView:self.view];
    
    
    UIView *contentView =  [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 100)];
    contentView.backgroundColor = [UIColor redColor];
    
    
    
//    [[JRCustomAlertView alertViewWithAttributedTitle:[[NSAttributedString alloc] initWithString:@"通知"]  contentView:contentView type:AlertViewStyleTypeButtonHorizontal click:^(NSInteger index) {
//
//    } buttons:@"1",@"2" ,nil] showInView:self.view];
    
    
    [[JRCustomAlertView alertViewWithTitle:@"通知" contentView:contentView type:AlertViewStyleTypeButtonHorizontal click:^(NSInteger index) {
        
    } buttons:@"1",@"2" , nil] showInView:self.view];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
