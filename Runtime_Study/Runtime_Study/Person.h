//
//  Person.h
//  Runtime_Study
//
//  Created by ap2 on 16/1/15.
//  Copyright © 2016年 ap2. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Person : NSObject

@property (nonatomic, copy) NSString *name;
@property (nonatomic, assign) NSInteger age;

- (void)logPhoneValue;

+ (void)classMethod;
- (void)test:(NSString *)name age:(NSInteger)age;
@end
