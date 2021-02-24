//
//  ThreeTestClass.m
//  ThreeLib
//
//  Created by liupenghui on 2021/2/18.
//


#import "oneTestClass.h"

@implementation oneTestClass

+(void)oneTestPrint{
    NSLog(@"类打印：%s",__func__);
}

+(UIImage *)imageWithName:(NSString *)imageName{
//
//    NSBundle *bundle = [NSBundle bundleWithURL:[[NSBundle mainBundle] URLForResource:@"OneLibBundle" withExtension:@"bundle"]];
//    return  [UIImage imageNamed:imageName inBundle:bundle compatibleWithTraitCollection:nil];
    UIImage * img = [UIImage imageNamed:[NSString stringWithFormat:@"OneLibBundle.bundle/%@",imageName]];
    return img;
}
#pragma mark - 正则表达式搞一搞

@end
