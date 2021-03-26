//
//  ViewController.m
//  Demo
//
//  Created by liupenghui on 2021/2/18.
//

#import "ViewController.h"

#import "PrefixHeader.pch"

#import "TestClass.h"

@interface ViewController ()

/*
 *<#Description#>
 */
@property(nonatomic, strong)TestClass * test;

@end

@implementation ViewController

-(void)demoTest{
    
    [twoTestClass twoTestPrint];
    [oneTestClass oneTestPrint];
    UIImageView * imgV = [[UIImageView alloc]initWithFrame:CGRectMake(0, 100, 100, 100)];
    imgV.backgroundColor = [UIColor orangeColor];
    [self.view addSubview:imgV];

    UIImage * img = [oneTestClass imageWithName:@"login_apple_dark@2x.png"];
    imgV.image = img;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.test = [TestClass shareTestClass];
    
    // Do any additional setup after loading the view.
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    dispatch_queue_t queue = dispatch_queue_create("test", DISPATCH_QUEUE_CONCURRENT);
    
    
    for (int i = 0; i < 10; i ++) {
        
        dispatch_async(queue, ^{
            self.test.deviceId = @"BBB";
            NSLog(@"------deviceId------%@",self.test);
        });
        
        
        dispatch_async(queue, ^{
            self.test.deviceId = @"AAAAA";
            if (i == 5) {
                self.test = nil;
            }
        });
    }
    
    
}


- (void)dispatchTest{
    
//    NSLog(@"begin");
//    dispatch_queue_t queue = dispatch_queue_create("com.passport.init.SDKBiometricLoginTokenExpiredQueue", DISPATCH_QUEUE_CONCURRENT);
//    dispatch_sync(queue, ^{
//        // 删除当前指纹登录信息
//        NSLog(@"222");
//    });
//    dispatch_sync(queue, ^{
//        dispatch_async(dispatch_get_main_queue(), ^{
//            NSLog(@"4444");
//        });
//    });
//    NSLog(@"end");
    
    
    
//    NSLog(@"begin");
//    dispatch_queue_t queue = dispatch_queue_create("com.passport.init.SDKBiometricLoginTokenExpiredQueue", DISPATCH_QUEUE_CONCURRENT);
//    dispatch_sync(queue, ^{
//        // 删除当前指纹登录信息
//        NSLog(@"222");
//
//        dispatch_async(dispatch_get_main_queue(), ^{
//            NSLog(@"4444");
//        });
//    });
//    NSLog(@"end");
}


-(void)blockTest{
    
    void(^block)(void) = ^{
        NSLog(@"CJL");
    };
    NSLog(@"全局block%@", block);
    
    int a = 10;
    void(^bblock)(void) = ^{
        NSLog(@"CJL - %d", a);
    };
    NSLog(@"堆block%@", bblock);
    
    int c = 10;
    void(^ __weak cblock)(void) = ^{
       NSLog(@"CJL - %d", c);
    };
    NSLog(@"栈block%@",cblock);
}
@end
