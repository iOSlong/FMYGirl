//
//  FMYChinese.m
//  FMYGirl9
//
//  Created by xuewu.long on 17/1/23.
//  Copyright © 2017年 fmy.long. All rights reserved.
//

#import "FMYChinese.h"
#import <objc/runtime.h>


@interface FMYChinese ()

@property FMYPerson *father;
@property FMYPerson *mother;
@property NSArray *children;

@end

@implementation FMYChinese {
    NSMutableDictionary *_propertiesDict;
}

@dynamic talent; // 动态绑定， 自个儿实现set 和 get 方法。


- (instancetype)init
{
    self = [super init];
    if (self) {
        _propertiesDict = [NSMutableDictionary dictionary];
    }
    return self;
}




+ (BOOL)resolveInstanceMethod:(SEL)sel
{
    if (sel == @selector(fastforwarding))
    {
        IMP foolIMP = imp_implementationWithBlock(^(){
            NSLog(@"Doing fastforwarding!");
        });
        
        class_addMethod([self class], sel, foolIMP, "v@:");
    }
    
    return [super resolveInstanceMethod:sel];
}


- (void)normalforwarding {
    NSLog(@"normalforwarding !");
}







#pragma mark - dynamic set&get method

- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector
{
    NSString *sel = NSStringFromSelector(aSelector);
    
    if ([sel rangeOfString:@"set"].location == 0)
    {
        return  [NSMethodSignature signatureWithObjCTypes:"v@:@"];
    }
    else
    {
        return [NSMethodSignature signatureWithObjCTypes:"@@:"];
    }
}

- (void)forwardInvocation:(NSInvocation *)anInvocation
{
    NSString *key = NSStringFromSelector(anInvocation.selector);
    
    if ([key rangeOfString:@"set"].location == 0)
    {
        key = [[key substringWithRange:NSMakeRange(3, [key length] - 4)] lowercaseString];
        
        NSString *obj;
        
        [anInvocation getArgument:&obj atIndex:2];
        
        [_propertiesDict setObject:obj forKey:key];
    }
    else
    {
        NSString *obj = [_propertiesDict objectForKey:key];
        
        [anInvocation setReturnValue:&obj];
    }
}


/*
 2）Objective-C中的方法默认被隐藏了两个参数：self和_cmd。self指向对象本身，_cmd指向方法本身。举两个例子来说明：
 
 例一：- (NSString *)name
 
 这个方法实际上有两个参数：self和_cmd。
 
 例二：- (void)setValue:(int)val
 
 这个方法实际上有三个参数：self, _cmd和val。
 
 被指定为动态实现的方法的参数类型有如下的要求：
 
 A.第一个参数类型必须是id（就是self的类型）
 
 B.第二个参数类型必须是SEL（就是_cmd的类型）
 
 C.从第三个参数起，可以按照原方法的参数类型定义。举两个例子来说明：
 
 例一：setHeight:(CGFloat)height中的参数height是浮点型的，所以第三个参数类型就是f。
 
 例二：再比如setName:(NSString *)name中的参数name是字符串类型的，所以第三个参数类型就是@
 
 
 
 3）在main.m中有一句代码是book.name = @"c++ primer";程序运行到这里时，会去Book.m中寻找setName:这个赋值方法。但是Book.m里并没有这个方法，于是程序进入methodSignatureForSelector:中进行消息转发。执行完之后，以"v@:@"作为方法签名类型返回。
 
 这里v@:@是什么东西呢？实际上，这里的第一个字符v代表函数的返回类型是void，后面三个字符参考上面2）中的解释就可以知道，分别是self, _cmd, name这三个参数的类型id, SEL, NSString。
 
 接着程序进入forwardInvocation方法。得到的key为方法名称setName:，然后利用[invocationgetArgument:&obj atIndex:2];获取到参数值，这里是“c++ primer”。这里的index为什么要取2呢？如前面分析，第0个参数是self，第1个参数是_cmd，第2个参数才是方法后面带的那个参数。
 
 最后利用一个可变字典来赋值。这样就完成了整个setter过程。
 
 
 
 4）在main.m中有一句代码是 NSLog(@"%@", book.name);，程序运行到这里时，会去Book.m中寻找name这个取值方法 。但是Book.m里并没有这个取值方法，于是程序进入methodSignatureForSelector:中进行消息转发。执行完之后，以"@@:"作为方法签名类型返回。这里第一字符@代表函数返回类型NSString，第二个字符@代表self的类型id，第三个字符:代表_cmd的类型SEL。
 
 接着程序进入forwardInvocation方法。得到的key为方法名称name。最后根据这个key从字典里获取相应的值，这样就完成了整个getter过程。
 
 
 
 5）注意，调试代码的过程，我们发现只有name和author的赋值和取值进入methodSignatureForSelector:和forwardInvocation:这两个方法。还有一个属性version的赋值和取值，并没有进入methodSignatureForSelector:和forwardInvocation:这两个方法。这是因为，version属性被标识为@synthesize，编译器自动会加上setVersion和version两个方法，所以就不用消息转发了。
 
 
 
 四、@dynamic在NSManagedObject的子类中的使用
 
 @dynamic最常用的使用是在NSManagedObject中，此时不需要显示编程setter和getter方法。原因是：@dynamic告诉编译器不做处理，使编译通过，其getter和setter方法会在运行时动态创建，由Core Data框架为此类属性生成存取方法。
 */

- (NSString *)learnTheArtifact;
{
    NSString *noTitle =  @"昨夜星辰昨夜风，画楼西畔桂堂东。身无彩凤双飞翼，心有灵犀一点通。隔座送钩春酒暖，分超射履蜡灯红。嗟余听鼓应官去，走马兰台类转蓬";
    NSLog(@"%@",noTitle);
    return noTitle;
}


@end
