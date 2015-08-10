//
//  LoginController.m
//  QQ空间
//
//  Created by heew on 15/8/9.
//  Copyright (c) 2015年 adhx. All rights reserved.
//

#import "LoginController.h"
#import "mainViewController.h"

@interface LoginController ()
@property (weak, nonatomic) IBOutlet UITextField *accountTextField;
@property (weak, nonatomic) IBOutlet UITextField *pwdTextfield;
@property (weak, nonatomic) IBOutlet UIButton *loginButton;
@property (weak, nonatomic) IBOutlet UIButton *rmbPasswor;
@property (weak, nonatomic) IBOutlet UIButton *autoLogin;

- (IBAction)login:(UIButton *)sender;

@end

@implementation LoginController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)rmbButton:(UIButton *)sender {
    sender.selected = !sender.isSelected;
}

- (IBAction)autoButton:(UIButton *)sender {
    sender.selected = !sender.isSelected;
    self.rmbPasswor.selected = sender.isSelected;
}

- (IBAction)login:(UIButton *)sender {
    NSString *account = self.accountTextField.text;
    NSString *pwd = self.pwdTextfield.text;
    if (account.length == 0) {
        [self showError:@"账号不能为空"];
        return;
    }
    if (pwd.length == 0) {
        [self showError:@"密码不能为空"];
        return;
    }
    if ([account  isEqual: @"123"] && [pwd isEqual: @"123"]) {
        mainViewController *main = [[mainViewController alloc] init];
        [self presentViewController:main animated:YES completion:nil];
    } else {
        [self showError:@"账号或密码不正确"];
    }
}

- (void)showError:(NSString *)error {
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"登录失败" message:error delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [alertView show];
    CAKeyframeAnimation *anim = [CAKeyframeAnimation animationWithKeyPath:@"transform.translation.x"];
    anim.values = @[@-10, @0, @10, @0];
    anim.duration = 0.1;
    anim.repeatCount = 5;
    [self.loginButton.layer addAnimation:anim forKey:nil];
}
@end
