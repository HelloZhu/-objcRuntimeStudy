//
//  Person.m
//  Runtime_Study
//
//  Created by ap2 on 16/1/15.
//  Copyright © 2016年 ap2. All rights reserved.
//

#import "Person.h"

@implementation Person
{
    NSString *_phone;
}

- (instancetype)init
{
    if (self = [super init])
    {
        _phone = @"18923785110";
    }
    return self;
}

- (void)logPhoneValue
{
    NSLog(@"_phone = %@", _phone);
}

- (void)test:(NSString *)name age:(NSInteger)age
{
    
}

+ (void)classMethod
{
    
}

@end
