//
//  ViewController.m
//  09-UIDocumentInteractionController-文件预览
//
//  Created by fyb on 2017/8/18.
//  Copyright © 2017年 fyb. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UIDocumentInteractionControllerDelegate>

@property(nonatomic,strong) UIDocumentInteractionController * documentVC;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSString *path = [[NSBundle mainBundle] pathForResource:@" 搭建React Native生态  魏晓军  2016-06-24 " ofType:@"pdf"];
    NSURL * url = [NSURL fileURLWithPath:path];
    self.documentVC = [UIDocumentInteractionController interactionControllerWithURL:url];
    self.documentVC.delegate = self;
    
    
}
//1. 直接弹出预览窗口
- (IBAction)openFile:(id)sender {
    
    BOOL b = [self.documentVC presentPreviewAnimated:YES];
}
//2. 弹出选项菜单由用户自己选择
- (IBAction)openOptionForUser:(id)sender {

    [self.documentVC presentOptionsMenuFromRect:self.view.bounds inView:self.view animated:YES];
}
//3. 通过item打开选项
- (IBAction)openOptionByItem:(id)sender {

    UIBarButtonItem * item = [[UIBarButtonItem alloc] initWithTitle:@"打开文件" style:UIBarButtonItemStylePlain target:self action:@selector(itemAction:)];
    
    self.navigationItem.leftBarButtonItem = item;
}

//4. 通过其他应用程序打开文件，如果没有应用程序可以打开，返回NO
- (IBAction)openInMenu:(id)sender {
    
    BOOL result = [self.documentVC presentOpenInMenuFromRect:self.view.frame inView:self.view animated:YES];
    if (!result) {
        NSLog(@"没有可以打开此文件的应用");
    }
}

//5. 通过item让其他应用打开文件，如果没有应用程序可以打开，返回NO
- (IBAction)openInMenuByItem:(id)sender {

    UIBarButtonItem * item = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemPlay target:self action:@selector(itemActionOpenInMenu:)];
    
    self.navigationItem.rightBarButtonItem = item;
}


- (void)itemAction:(UIBarButtonItem *)sender
{
    NSLog(@"%@",NSStringFromSelector(_cmd));
    [self.documentVC presentOptionsMenuFromBarButtonItem:sender animated:YES];
}

- (void)itemActionOpenInMenu:(UIBarButtonItem *)sender
{
    NSLog(@"%@",NSStringFromSelector(_cmd));
    BOOL result = [self.documentVC presentOpenInMenuFromRect:self.view.frame inView:self.view animated:YES];
    if (!result) {
        NSLog(@"没有可以打开此文件的应用");
    }
}

#pragma mark 代理方法
- (UIViewController*)documentInteractionControllerViewControllerForPreview:(UIDocumentInteractionController*)controller
{
    NSLog(@"%@",NSStringFromSelector(_cmd));
    return self;
}
- (UIView*)documentInteractionControllerViewForPreview:(UIDocumentInteractionController*)controller
{
    NSLog(@"%@",NSStringFromSelector(_cmd));
    return self.view;
}
- (CGRect)documentInteractionControllerRectForPreview:(UIDocumentInteractionController*)controller
{
    NSLog(@"%@",NSStringFromSelector(_cmd));
//    return self.view.frame;
    return CGRectMake(0, 0, self.view.frame.size.width, 300);
}

//点击预览窗口的“Done”(完成)按钮时调用

- (void)documentInteractionControllerDidEndPreview:(UIDocumentInteractionController*)_controller
{
    
}

@end
