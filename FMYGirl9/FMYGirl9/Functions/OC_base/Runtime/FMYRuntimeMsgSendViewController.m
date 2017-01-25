//
//  FMYRuntimeMsgSendViewController.m
//  FMYGirl9
//
//  Created by xuewu.long on 17/1/25.
//  Copyright © 2017年 fmy.long. All rights reserved.
//
/*
 参考文档 ：http://tech.glowing.com/cn/objective-c-runtime/
 */


#import "FMYRuntimeMsgSendViewController.h"
#import <objc/runtime.h>
#import "FMYChinese.h"


typedef NS_ENUM(NSUInteger, FMYMsgSendType) {
    FMYMsgSendTypeMethodResolution,
    FMYMsgSendTypeFastForwarding,
    FMYMsgSendTypeNormalForwarding,
    FMYMsgSendTypeDynamicProperty,
    FMYMsgSendTypeNone,
};

@interface FMYRuntimeMsgSendViewController ()
@property (nonatomic) FMYMsgSendType msgSendType;
@property (nonatomic) FMYChinese *chinese;
@end

@implementation FMYRuntimeMsgSendViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
    
    [self.arrDataSource addObject:@"Method Resolution"];
    [self.arrDataSource addObject:@"Fast forwarding"];
    [self.arrDataSource addObject:@"Normal forwarding"];
    [self.arrDataSource addObject:@"dynamic Property"];
    
    
    self.chinese = [FMYChinese new];
    
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.row == 0)
    {
        self.msgSendType = FMYMsgSendTypeMethodResolution;
        
        [self performSelector:@selector(foo:)];
    }
    else if (indexPath.row == 1)
    {
        self.msgSendType = FMYMsgSendTypeFastForwarding;
        
        [self performSelector:@selector(fastforwarding)];

    }
    else if (indexPath.row == 2)
    {
        self.msgSendType = FMYMsgSendTypeNormalForwarding;
        [self performSelector:@selector(normalforwarding)];
    }
    else if (indexPath.row == 3)
    {
        self.msgSendType = FMYMsgSendTypeDynamicProperty;
        [self performSelector:@selector(setAndGetChinese)];
    }
}

#pragma mark  - Method Resolution
/*
 首先，Objective-C 运行时会调用 +resolveInstanceMethod: 或者 +resolveClassMethod:，让你有机会提供一个函数实现。如果你添加了函数并返回 YES， 那运行时系统就会重新启动一次消息发送的过程。
 */
+ (BOOL)resolveInstanceMethod:(SEL)sel
{
    if (sel == @selector(foo:))
    {
        
        IMP foolIMP = (IMP)fooMethod;
        //如果要使用到本类中的实例方法，用block形式的替代
        foolIMP = imp_implementationWithBlock(^(){
            NSLog(@"Doing foo!");
        });
        
        class_addMethod([self class], sel, foolIMP, "v@:");
    }
    
    return [super resolveInstanceMethod:sel];
}

void fooMethod(id obj, SEL _cmd) {
    NSLog(@"Doing foo!");
}




#pragma mark  - Fast forwarding
/*
 如果目标对象实现了 -forwardingTargetForSelector:
 Runtime 这时就会调用这个方法，给你把这个消息转发给其他对象的机会。
 */
- (id)forwardingTargetForSelector:(SEL)aSelector
{
    if (aSelector == @selector(fastforwarding))
    {
        return self.chinese;
    }
    return [super forwardingTargetForSelector:aSelector];
}



#pragma mark  - Normal forwarding （TODO）崩溃
/*
 这一步是 Runtime 最后一次给你挽救的机会
 在给程序添加消息转发功能以前，必须覆盖两个方法，即methodSignatureForSelector:和forwardInvocation:。methodSignatureForSelector:的作用在于为另一个类实现的消息创建一个有效的方法签名，必须实现，并且返回不为空的methodSignature，否则会crash。
 */
- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector {
    NSString *sel = NSStringFromSelector(aSelector);
    NSLog(@"sel_IS:%@",sel);
    
    if (aSelector == @selector(normalforwarding)) {
        return [NSMethodSignature signatureWithObjCTypes:"v@@"];
    }
    return [super methodSignatureForSelector:aSelector];
}

- (void)normal {
    NSLog(@"Normal forwarding!");
}



- (void)forwardInvocation:(NSInvocation *)anInvocation
{
    SEL sel = anInvocation.selector;
    
    if ([self.chinese respondsToSelector:sel])
    {
        [anInvocation invokeWithTarget:self.chinese];
    }
    else
    {
        [self doesNotRecognizeSelector:sel];
    }
}




#pragma mark - @dynamic property set&get
- (void)setAndGetChinese {
    
    self.chinese.talent = @"many many more and more";
    
    NSLog(@"talent: %@",self.chinese.talent);
    
}




@end
