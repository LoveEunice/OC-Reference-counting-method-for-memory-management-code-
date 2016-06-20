//
//  main.m
//  OC-内存管理（引用计数）
//
//  Created by qingyun on 16/4/6.
//  Copyright © 2016年 qingyun. All rights reserved.
//
//MRC手动管理内存  ARC自动管理内存
#import <Foundation/Foundation.h>
#import "Student.h"

int main(int argc, const char * argv[]) {
    {
        //注意：在ARC中无法使用release,retain,retainCount,因为他是自动释放
        //NSString的引用计数
        NSString *str1=@"hello";
        NSLog(@"str1%ld",str1.retainCount);//因为str1指向的是常量区，它的引用计数例外,retain和release对他都不起作用
        //        [str1 retain];//+1
        //        NSLog(@"str1==%ld",str1.retainCount);
        NSString *str2=[NSString stringWithFormat:@"%@",@"test"];
        NSLog(@"str:%ld",[str2 retainCount]);
        NSString *str3=[NSString stringWithString:[NSString stringWithFormat:@"test %d",12]];
        NSLog(@"str3:%ld",str3.retainCount);
        NSString *str4=[[NSString alloc] initWithCString:"hello" encoding:NSUTF8StringEncoding];
        NSLog(@"str4==%ld",str4.retainCount);
        NSString *str5=[[NSString alloc] initWithFormat:@"test %d %s",23,"qingyun"];
        NSLog(@"str5=%ld",str5.retainCount);//1
        NSString *str6=[[NSString alloc] initWithString:@"hello"];
        NSLog(@"str6=%ld",str6.retainCount);
       
        [str4 release];//0
        [str6 release];//0
        //为了彻底释放
        str4=nil;
        str6=nil;
        NSLog(@"str==%ld,%ld,%ld",str4.retainCount,str5.retainCount,str6.retainCount);//MRC中引用计数为0的时候最好不要在使用
        [str5 retain];//2
        NSLog(@"str5==%ld",str5.retainCount);
        [str5 release];//对应开始的alloc
        [str5 release];//对应retain的一次
        str5=nil;
        NSLog(@"str5=%ld",str5.retainCount);
        
        //NSValue,NSNumber
        NSValue *pValue=[NSValue valueWithPoint:NSMakePoint(12, 12)];
        NSLog(@"%ld",pValue.retainCount);
        NSNumber *iNUm=[[NSNumber alloc] initWithFloat:23.3];
        NSLog(@"%ld",iNUm.retainCount);
        [iNUm release];
        
        NSMutableArray *arr1=[[NSMutableArray alloc] initWithObjects:@"hello",@"qingyun", nil];
        NSLog(@"arr1==%ld",arr1.retainCount);//1
        [arr1 addObject:@"ios"];
        NSLog(@"arr1==%ld",arr1.retainCount);//1  add只是增加的元素而个数！
        [arr1 release];
        
        NSMutableDictionary *dic=[NSMutableDictionary dictionaryWithObjectsAndKeys:@"qingyun",@"name",@"河南",@"address", nil];
        NSLog(@"dic==%ld",dic.retainCount);//1
        [dic setObject:@"53号" forKey:@"hourse"];
        NSLog(@"dic=%ld",dic.retainCount);//1
        //[dic release];//dic是类创建的对象，不用手动释放！
        for (int i=0; i<10; i++)
        {
            NSLog(@"%ld,%d",dic.retainCount,i);
        }
        NSSet *set1=[NSSet new];//2
        NSLog(@"set=%ld",set1.retainCount);
        [set1 release];//1
//        [set1 release];
        for (int i=0; i<10; i++)
        {
            NSLog(@"set=%ld,%d",set1.retainCount,i);
        }
        Person *p1=[Person new];//1
        NSLog(@"p1==%ld",p1.retainCount);
        [p1 setName:@"小明"];
        NSLog(@"%ld",p1.retainCount);
        [p1 release];//0--->会自动调用本类的dealloc方法
        p1=nil; //彻底释放
//        for (int i=0; i<10; i++)
//        {
//            NSLog(@"p1==%ld,%d",p1.retainCount,i);
//        }
        Student *s1=[Student new];
        [s1 setName:@"小李"];
        [s1 setStuID:@"1603101"];
        [s1 release];
        s1=nil;
        
        NSString *myStr=[str1 copy];
        NSLog(@"myStr=%ld",myStr.retainCount);//1
        [myStr release];//0
        //总结
         //1.当alloc,copy,new创建的对象，需要手动释放
        //2.retainCount有时候会欺骗你的眼睛（NSString）,但是Analyze绝对不会出错(但new例外)
        //3.retain和release应该成对
        //4.类方法创建的对象是系统自动管理的
        
    }
    return 0;
}
