fmy.long

<!--https://developer.apple.com/library/content/documentation/Cocoa/Conceptual/ObjCRuntimeGuide/Introduction/Introduction.html#//apple_ref/doc/uid/TP40008048-CH1-SW1  -->

The Objective-C language defers as many decisions as it can from compile time and link time to runtime. Whenever possible, it does things dynamically. This means that the language requires not just a compiler, but also a runtime system to execute the compiled code. The runtime system acts as a kind of operating system for the Objective-C language; it’s what makes the language work.





#import <objc/runtime.h>    //需要引入库

 
1. 运行时简介：
#Objective-C语言是一门动态语言，它将很多静态语言在编译和链接时期做的事放到了运行时来处理。


2. 类与对象基础数据结构
Objective-C类是由Class类型来表示的，它实际上是一个指向objc_class结构体的指针。《查看objc/runtime.h》
#typedef struct object_class *Class
struct object_class{
    Class isa OBJC_ISA_AVAILABILITY;
    #if !__OBJC2__
    Class super_class                        OBJC2_UNAVAILABLE;  // 父类
    const char *name                         OBJC2_UNAVAILABLE;  // 类名
    long version                             OBJC2_UNAVAILABLE;  // 类的版本信息，默认为0
    long info                                OBJC2_UNAVAILABLE;  // 类信息，供运行期使用的一些位标识
    long instance_size                       OBJC2_UNAVAILABLE;  // 该类的实例变量大小
    struct objc_ivar_list *ivars             OBJC2_UNAVAILABLE;  // 该类的成员变量链表
    struct objc_method_list *methodLists     OBJC2_UNAVAILABLE;  // 方法定义的链表
    struct objc_cache *cache                 OBJC2_UNAVAILABLE;  // 方法缓存
    struct objc_protocol_list *protocols     OBJC2_UNAVAILABLE;  // 协议链表
    #endif
}OBJC2_UNAVAILABLE;


# objc_object 是表示一个实例的结构体《查看objc/objc.h》
struct objc_object{
    Class isa OBJC_ISA_AVAILABILITY;
};
typedef struct objc_object *id;


# 元类（Meta Class） 《iOS运行时(Runtime)详解+Demo》


# Category  是表示一个指向分类的结构体的指针，其定义如下：
typedef struct objc_category *Category
struct objc_category{
    char *category_name                         OBJC2_UNAVAILABLE; // 分类名
    char *class_name                            OBJC2_UNAVAILABLE;  // 分类所属的类名
    struct objc_method_list *instance_methods   OBJC2_UNAVAILABLE;  // 实例方法列表
    struct objc_method_list *class_methods      OBJC2_UNAVAILABLE; // 类方法列表
    struct objc_protocol_list *protocols        OBJC2_UNAVAILABLE; // 分类所实现的协议列表
}
这个结构体主要包含了分类定义的实例方法与类方法，其中instance_methods列表是objc_class中方法列表的一个子集，而class_methods列表是元类方法列表的一个子集。
可发现，类别中没有ivar成员变量指针，也就意味着：类别中不能够添加实例变量和属性
struct objc_ivar_list *ivars             OBJC2_UNAVAILABLE;  // 该类的成员变量链表



3. runtime 关联对象 （TODO，类别添加属性 | 关联使用）
 我们先看看关联API，只有这三个API，使用也是非常简单的：

# 3.1 设置关联值 
<!--参数说明：-->
<!--object：与谁关联，通常是传self-->
<!--key：唯一键，在获取值时通过该键获取，通常是使用static-->
<!--const void *来声明-->
<!--value：关联所设置的值-->
<!--policy：内存管理策略，比如使用copy-->
void objc_setAssociatedObject(id object, const void *key, id value, objc _AssociationPolicy policy)

# 3.2 获取关联值
<!--参数说明：-->
<!--object：与谁关联，通常是传self，在设置关联时所指定的与哪个对象关联的那个对象-->
<!--key：唯一键，在设置关联时所指定的键-->
id objc_getAssociatedObject(id object, const void *key)

# 3.3 取消关联
void objc_removeAssociatedObjects(id object)

# 关联策略 
<!--使用场景：-->
<!--可以在类别中添加属性-->
<!--typedef OBJC_ENUM(uintptr_t, objc_AssociationPolicy){-->
<!--    OBJC_ASSOCIATION_ASSIGN = 0,             // 表示弱引用关联，通常是基本数据类型-->
<!--    OBJC_ASSOCIATION_RETAIN_NONATOMIC = 1,   // 表示强引用关联对象，是线程安全的-->
<!--    OBJC_ASSOCIATION_COPY_NONATOMIC = 3,     // 表示关联对象copy，是线程安全的-->
<!--    OBJC_ASSOCIATION_RETAIN = 01401,         // 表示强引用关联对象，不是线程安全的-->
<!--    OBJC_ASSOCIATION_COPY = 01403            // 表示关联对象copy，不是线程安全的-->
<!--};-->



4. 方法与消息 messages aren’t bound to method implementations until Runtime。
# 4.1 SEL  又叫选择器，是表示一个方法的selector的指针，其定义如下：
typedef struct objc_selector *SEL；
方法的selector用于表示运行时方法的名字。Objective-C在编译时，会依据每一个方法的名字、参数序列，生成一个唯一的整型标识(Int类型的地址)，这个标识就是SEL。
两个类之间，只要方法名相同，那么方法的SEL就是一样的，每一个方法都对应着一个SEL。所以在Objective-C同一个类(及类的继承体系)中，不能存在2个同名的方法，即使参数类型不同也不行
当然，不同的类可以拥有相同的selector，这个没有问题。不同类的实例对象执行相同的selector时，会在各自的方法列表中去根据selector去寻找自己对应的IMP。
工程中的所有的SEL组成一个Set集合，如果我们想到这个方法集合中查找某个方法时，只需要去找到这个方法对应的SEL就行了，SEL实际上就是根据方法名hash化了的一个字符串，而对于字符串的比较仅仅需要比较他们的地址就可以了，可以说速度上无语伦比！
本质上，SEL只是一个指向方法的指针（准确的说，只是一个根据方法名hash化了的KEY值，能唯一代表一个方法），它的存在只是为了加快方法的查询速度。
通过下面三种方法可以获取SEL:
a、sel_registerName函数
b、Objective-C编译器提供的@selector()
c、NSSelectorFromString()方法

# 4.2 IMP   IMP实际上是一个函数指针，指向方法实现的地址。其定义如下：
id (*IMP)(id, SEL,...)
第一个参数：是指向self的指针(如果是实例方法，则是类实例的内存地址；如果是类方法，则是指向元类的指针)
第二个参数：是方法选择器(selector)
接下来的参数：方法的参数列表。
前面介绍过的SEL就是为了查找方法的最终实现IMP的。由于每个方法对应唯一的SEL，因此我们可以通过SEL方便快速准确地获得它所对应的IMP，查找过程将在下面讨论。取得IMP后，我们就获得了执行这个方法代码的入口点，此时，我们就可以像调用普通的C语言函数一样来使用这个函数指针了。

# 4.3 Method   Method用于表示类定义中的方法，则定义如下：
typedef struct objc_method *Method
struct objc_method{
    SEL method_name      OBJC2_UNAVAILABLE; // 方法名
    char *method_types   OBJC2_UNAVAILABLE;
    IMP method_imp       OBJC2_UNAVAILABLE; // 方法实现
}
我们可以看到该结构体中包含一个SEL和IMP，实际上相当于在SEL和IMP之间作了一个映射。有了SEL，我们便可以找到对应的IMP，从而调用方法的实现代码。

# 4.4 方法调用流程
在Objective-C中，消息直到运行时才绑定到方法实现上。编译器会将消息表达式[receiver message]转化为一个消息函数的调用，即objc_msgSend。这个函数将消息接收者和方法名作为其基础参数，如以下所示：
objc_msgSend(receiver, selector)
如果消息中还有其它参数，则该方法的形式如下所示：
objc_msgSend(receiver, selector, arg1, arg2,...)
这个函数完成了动态绑定的所有事情：

a、首先它找到selector对应的方法实现。因为同一个方法可
能在不同的类中有不同的实现，所以我们需要依赖于接收者的类
来找到的确切的实现。
b、调用方法实现，并将接收者对象及方法的所有参数传给它。
c、最后，它将实现返回的值作为它自己的返回值。

消息的关键在于我们前面章节讨论过的结构体objc_class，这个结构体有两个字段是我们在分发消息的关注的：
-> 指向父类的指针
-> 个类的方法分发表，即methodLists。
当我们创建一个新对象时，先为其分配内存，并初始化其成员变量。其中isa指针也会被初始化，让对象可以访问类及类的继承体系。

下图演示了这样一个消息的基本框架：
当消息发送给一个对象时首先从运行时系统缓存使用过的方法中寻找。
如果找到，执行该方法,如未找到继续执行下面的步骤

objc_msgSend通过对象的isa指针获取到类的结构体，然后在方法分发表里面查找方法的selector。
如果没有找到selector，objc_msgSend结构体中的指向父类的指针找到其父类，并在父类的分发表里面查找方法的selector。
依此，会一直沿着类的继承体系到达NSObject类。一旦定位到selector，函数会就获取到了实现的入口点，并传入相应的参数来执行方法的具体实现,并将该方法添加进入缓存中如果最后没有定位到selector，则会走消息转发流程，这个我们在后面讨论。

# 4.5 消息转发 《iOS运行时(Runtime)详解+Demo》
当一个对象能接收一个消息时，就会走正常的方法调用流程。但如果一个对象无法接收指定消息时，又会发生什么事呢？默认情况下，如果是以[object message]的方式调用方法，如果object无法响应message消息时，编译器会报错。但如果是以perform…的形式来调用，则需要等到运行时才能确定object是否能接收message消息。如果不能，则程序崩溃。
通常，当我们不能确定一个对象是否能接收某个消息时，会先调用respondsToSelector:来判断一下。如下代码所示：
if([self respondsToSelector:@selector(method)]){
    [self performSelector:@selector(method)];
}
不过，我们这边想讨论下不使用respondsToSelector:判断的情况。这才是我们这一节的重点。

当一个对象无法接收某一消息时，就会启动所谓“消息转发(message forwarding)”机制，通过这一机制，我们可以告诉对象如何处理未知的消息。默认情况下，对象接收到未知的消息，会导致程序崩溃，通过控制台，我们可以看到以下异常信息：

这段异常信息实际上是由NSObject的“doesNotRecognizeSelector”方法抛出的。不过，我们可以采取一些措施，让我们的程序执行特定的逻辑，而避免程序的崩溃。

消息转发机制基本上分为三个步骤：

1>、动态方法解析
2>、备用接收者
3>、完整转发


# 4.6 动态方法解析 （TODO）
对象在接收到未知的消息时，首先会调用所属类的类方法
+resolveInstanceMethod:(实例方法)或者
+resolveClassMethod:(类方法)。

在这个方法中，我们有机会为该未知消息新增一个“处理方法”，通过运行时class_addMethod函数动态添加到类里面就可以了。

这种方案更多的是为了实现@dynamic属性。


# 4.7 备用接受者
- (id)forwardingTargetForSelector:(SEL)aSelector
如果在上一步无法处理消息，则Runtime会继续调以下方法：
如果一个对象实现了这个方法，并返回一个非nil的结果，则这个对象会作为消息的新接收者，且消息会被分发到这个对象。当然这个对象不能是self自身，否则就是出现无限循环。当然，如果我们没有指定相应的对象来处理aSelector，则应该调用父类的实现来返回结果。

这一步合适于我们只想将消息转发到另一个能处理该消息的对象上。但这一步无法对消息进行处理，如操作消息的参数和返回值。


# 4.8 完整的消息转发
如果在上一步还不能处理未知消息，则唯一能做的就是启用完整的消息转发机制了。
我们首先要通过,指定方法签名，若返回nil，则表示不处理。
如下代码：
- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector
{
    if ([NSStringFromSelector(aSelector) isEqualToString:@"testInstanceMethod"]){
    return [NSMethodSignature signatureWithObjcTypes:"v@:"];
}  
    return [super methodSignatureForSelector: aSelector];
}

若返回方法签名，则会进入下一步调用以下方法，对象会创建一个表示消息的NSInvocation对象，把与尚未处理的消息有关的全部细节都封装在anInvocation中，包括selector，目标(target)和参数。
我们可以在forwardInvocation方法中选择将消息转发给其它对象。我们可以通过anInvocation对象做很多处理，比如修改实现方法，修改响应对象等.
如下所示：
- (void)forwardInvovation:(NSInvocation)anInvocation
{
    [anInvocation invokeWithTarget:_helper];
    [anInvocation setSelector:@selector(run)];
    [anInvocation invokeWithTarget:self];
}



5. Method Swizzling
# 5.1 Swizzling 原理
在Objective-C中调用一个方法，其实是向一个对象发送消息，而查找消息的唯一依据是selector的名字。所以，我们可以利用Objective-C的runtime机制，实现在运行时交换selector对应的方法实现以达到我们的目的。

每个类都有一个方法列表，存放着selector的名字和方法实现的映射关系。IMP有点类似函数指针，指向具体的Method实现

我们先看看SEL与IMP之间的关系图：

<!--selectorA  ——>   IMPa-->
<!--selectorB  ——>   IMPb-->
<!--selectorC  ——>   IMPc-->

从上图可以看出来，每一个SEL与一个IMP一一对应，正常情况下通过SEL可以查找到对应消息的IMP实现。
但是，现在我们要做的就是把链接线解开，然后连到我们自定义的函数的IMP上。当然，交换了两个SEL的IMP，还是可以再次交换回来了。交换后变成这样的，如下图

<!--selectorA  ——>   IMPa-->
<!--selectorB  ——>   IMPb-->
<!--selectorC  ——>   IMPn-->
<!--selectorN  ——>   IMPc-->

从图中可以看出，我们通过swizzling特性，将selectorC的方法实现IMPc与selectorN的方法实现IMPn交换了，当我们调用selectorC，也就是给对象发送selectorC消息时，所查找到的对应的方法实现就是IMPn而不是IMPc了。









# 消息传递
Objective-C 中给一个对象发送消息会经过以下几个步骤：

1. 在对象类的 dispatch table 中尝试找到该消息。如果找到了，跳到相应的函数IMP去执行实现代码；

2. 如果没有找到，Runtime 会发送 +resolveInstanceMethod: 或者 +resolveClassMethod: 尝试去 resolve 这个消息；

3. 如果 resolve 方法返回 NO，Runtime 就发送 -forwardingTargetForSelector: 允许你把这个消息转发给另一个对象；

4. 如果没有新的目标对象返回， Runtime 就会发送 -methodSignatureForSelector: 和 -forwardInvocation: 消息。你可以发送 -invokeWithTarget: 消息来手动转发消息或者发送 -doesNotRecognizeSelector: 抛出异常。










# 可参考文档


<!--http://www.jianshu.com/p/1e06bfee99d0   《详解Runtime运行时机制》-->


<!--http://www.jianshu.com/p/adf0d566c887  《iOS运行时(Runtime)详解+Demo》-->


<!--http://tech.meituan.com/DiveIntoCategory.html   《深入理解Objective-C：Category》-->


<!--http://tech.glowing.com/cn/objective-c-runtime/  《消息传递（Messaging）》-->


<!--http://blog.sina.com.cn/s/blog_8c87ba3b0102v006.html |  http://blog.csdn.net/haishu_zheng/article/details/12873151 《使用methodSignatureForSelector与forwardInvocation实现消息转发 》《Objective-C中的@dynamic》-->

<!--http://blog.sunnyxx.com  《唐巧个人博客》-->


<!--http://tech.meituan.com/?l=80&pos=6409  《美团技术团队技术博客》-->



<!--https://developer.apple.com/library/content/documentation/Cocoa/Conceptual/ObjCRuntimeGuide/Articles/ocrtTypeEncodings.html-->
 
 
<!-- http://mp.weixin.qq.com/s/GFt7uqrKw7m3R3KrV43zIQ  《网易iOS App运行时Crash自动防护实践》-->





