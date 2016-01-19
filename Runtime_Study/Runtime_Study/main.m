//
//  main.m
//  Runtime_Study
//
//  Created by ap2 on 16/1/15.
//  Copyright © 2016年 ap2. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <objc/runtime.h>
#import "Person.h"
#import "Card.h"

int main(int argc, const char * argv[])
{
    @autoreleasepool
    {
        //typedef struct objc_class *Class;   Class 类的类型
        //objc_method *Method 一个类的隐含的方法。
        //objc_ivar *Ivar 隐含的的实例变量
        //objc_Category 隐含的分类
        //objc_property 隐含的 OC熟悉声明
        
        //objc_copy(id obj, size_t size) OC对象拷贝，size， 尺寸大小，返回一个新的对象
        //objc_dipose(id obj) 释放obj占用的内存,返回nil值
        
#pragma mark - runtime /object
        
#pragma mark  - object_getClass(id obj) 返回对象obj的“类”
        Person *p1 = [[Person alloc] init];
        NSLog(@"object_getClass - %@\n%@", object_getClass(p1), [Person class]);
        
#pragma mark  - object_setClass(id obj, __unsafe_unretained Class cls) 设置一个对象的“类”型
        Card *card1 = [[Card alloc] init];
        object_setClass(p1, object_getClass(card1));
        NSLog(@"object_setClass - %@", object_getClass(p1));
        
#pragma mark  - object_isClass(id obj) 判断对象是不是一个类对象
        Class classObject = object_getClass(card1);
        NSLog(@"classObject - %i", object_isClass(classObject));
        NSLog(@"card1 - %i", object_isClass(card1));
        
#pragma mark  - object_getClassName(id obj) 获取一个OC对象所属的类的类名
        const char *className = object_getClassName(card1);
        NSLog(@"className = %s", className);
        
#pragma mark  - object_getIvar(id obj, Ivar ivar) 获取一个对象的实例变量的值
        Person *p2 = [[Person alloc] init];
        p2.name = @"zhangsan";
        p2.age = 10;
        
        Ivar name_var = class_getInstanceVariable([p2 class], "_name");
        id name_Value = object_getIvar(p2, name_var);
        NSLog(@"p2.name =%@", name_Value);
        
#pragma mark  - 获取私有变量的值
        Ivar _phone_var = class_getInstanceVariable([p2 class], "_phone");
        id _phone_Value = object_getIvar(p2, _phone_var);
        NSLog(@"_phone =%@", _phone_Value);
        
        //不支持ARC
         ////Ivar object_getInstanceVariable(id obj, const char *name, void **outValue)
        //NSInteger temp;
        //Ivar age_var = object_getInstanceVariable([p2 class], "_age", (void*)&temp);
        //id age = object_getIvar(p2, age_var);
        //NSLog(@"p2.age =%@", age);
        
#pragma mark  - object_setIvar(id obj, Ivar ivar, id value) 给对象的实例变量赋值
        Person *p3 = [[Person alloc] init];
        object_setIvar(p3, name_var, @"wangwu");
        NSLog(@"p3.name = %@", p3.name);
        
        object_setIvar(p3, _phone_var, @"13197552524");
        [p3 logPhoneValue];
        
#pragma mark - runtime /Class
        
#pragma mark - objc_getClass(const char *name) 根据字符串创建一个类型
        Class cardClass = objc_getClass("Card");
        Card *card3 = [[cardClass alloc] init];
        card3.name = @"BMW";
        NSLog(@"card3.name= %@", card3.name);
        
#pragma mark - objc_getClassList(Class *buffer, int bufferCount) 获取类的数量
        int numClasses;
        Class *classes = NULL;
        
        classes = NULL;
        numClasses = objc_getClassList(NULL, 0);
        NSLog(@"Number of classes: %d", numClasses);
        
        if (numClasses > 0 )
        {
            classes = (__unsafe_unretained Class *)malloc(sizeof(Class) * numClasses);
            numClasses = objc_getClassList(classes, numClasses);
            for (int i = 0; i < numClasses; i++) {
                //NSLog(@"Class name: %s", class_getName(classes[i]));
            }
            free(classes);
        }
        
#pragma mark - Ivar *class_copyIvarList(Class cls, unsigned int *outCount) 获取类的所有属性
        unsigned int varCount = 0;
        //class_copyIvarList 可以获取私有变量名
        Ivar *vars = class_copyIvarList(objc_getClass("Person"), &varCount);
        for (int i = 0; i < varCount; i++)
        {
            NSLog(@"ivar_getName - %s", ivar_getName(vars[i]));
        }
        
        unsigned int pCount = 0;
        //class_copyPropertyList 不可以获取私有变量名
        objc_property_t *propertys = class_copyPropertyList(objc_getClass("Person"), &pCount);
        for(int i = 0; i < pCount; i++)
        {
            NSLog(@"property_getName - %s", property_getName(propertys[i]));
        }
        
#pragma mark - Method class_getInstanceMethod(Class cls, SEL name)
        SEL logSEL = @selector(test:age:);
        Method logMethod = class_getInstanceMethod(objc_getClass("Person"), logSEL);
        NSLog(@"Arguments %i", method_getNumberOfArguments(logMethod));
        
    }
    return 0;
}
