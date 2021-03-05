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
    UIImage * img = [UIImage imageNamed:[NSString stringWithFormat:@"OneLibBundle.bundle/%@",imageName]];
    return img;
}


@end
