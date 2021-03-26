//
//  TestClass.m
//  Demo
//
//  Created by liupenghui on 2021/3/26.
//

#import "TestClass.h"

@implementation TestClass

+(instancetype)shareTestClass{
    static TestClass * _sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (!_sharedInstance) {
            _sharedInstance = [[TestClass alloc]init];
            _sharedInstance.array = [NSMutableArray array];
        }
    });
    return  _sharedInstance;;
}

@end
