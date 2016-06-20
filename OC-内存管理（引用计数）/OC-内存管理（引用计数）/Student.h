//
//  Student.h
//  OC-内存管理（引用计数）
//
//  Created by qingyun on 16/4/6.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import "Person.h"

@interface Student : Person
{
    NSString *_stuID;
}
-(void)setStuID:(NSString *)ID;
@end
