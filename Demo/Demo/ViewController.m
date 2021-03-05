//
//  ViewController.m
//  Demo
//
//  Created by liupenghui on 2021/2/18.
//

#import "ViewController.h"

#import "PrefixHeader.pch"


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    NSLog(@"开始初始化");
    
    [twoTestClass twoTestPrint];
    [oneTestClass oneTestPrint];
    UIImageView * imgV = [[UIImageView alloc]initWithFrame:CGRectMake(0, 100, 100, 100)];
    imgV.backgroundColor = [UIColor orangeColor];
    [self.view addSubview:imgV];
    
    
//    NSBundle *bundle = [NSBundle bundleWithURL:[[NSBundle mainBundle] URLForResource:@"OneLibBundle" withExtension:@"bundle"]];
//
//
//    imgV.image = [UIImage imageNamed:@"login_apple_dark@2x.png" inBundle:bundle compatibleWithTraitCollection:nil];
    
    UIImage * img = [oneTestClass imageWithName:@"login_apple_dark@2x.png"];
    imgV.image = img;
    // Do any additional setup after loading the view.
}


@end
