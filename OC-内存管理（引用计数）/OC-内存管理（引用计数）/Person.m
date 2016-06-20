//
//  Person.m
//  OC-内存管理（引用计数）
//
//  Created by qingyun on 16/4/6.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import "Person.h"

@implementation Person
-(void)setName:(NSString *)name
{
    _name=name;
}
//重写dealloc方法：无需手动创建和调用  当对象的引用计数为0的时候自动调用
-(void)dealloc
{
    NSLog(@"姓名为%@的Person对象被释放了...",_name);
    [super dealloc];//调用父类的方法
}
@end
