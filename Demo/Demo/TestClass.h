//
//  TestClass.h
//  Demo
//
//  Created by liupenghui on 2021/3/26.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TestClass : NSObject

/*
 *
 */
@property(nonatomic, strong)NSMutableArray * array;

/*
 *<#Description#>
 */
@property(nonatomic, strong)NSString * deviceId;

+(instancetype)shareTestClass;

@end

NS_ASSUME_NONNULL_END
