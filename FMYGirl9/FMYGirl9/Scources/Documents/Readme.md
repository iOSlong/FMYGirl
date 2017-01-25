1.创建常用基类：FMY+
2.创建PrefixHeader.pch 
    *Build Settings
    Prefix Header: ($(SRCROOT)/FMYGirl9/RootFiles/PrefixHeader.pch)


partOne runtime_about
# readAbout     :   runtime.md   
# code_review   :   NSObject+FMY.m
<!--Objective-C中的方法默认被隐藏了两个参数：self和_cmd。self指向对象本身，_cmd指向方法本身。-->



/* 在OC  文件中写 C 函数的时候， 如果在别的文件中引用到，那么也得遵循OC的策略，否则会报错：
ld: 18 duplicate symbols for architecture x86_64
clang: error: linker command failed with exit code 1 (use -v to see invocation)
OC策略: 接口API写在.h文件中，实现在.m文件中（可以推想主要的是实现的位置，如果不需要被其他文件引用，那么就可以全部写在.m文件中）
参看：UIView+NSLayout
*/

<!--/ 添加一个类别，假如里面的方法实现与.h文件的函数有重复，先寻找的是原文件的实现，找不到才会去类别拓展中寻找，如果找到了就直接使用原有的实现。-->



TODO:
# tableviewCell cell 的高度处理， 利用 indexPath 寻找 （TODO）
# dispatch_semaphore_t    GCD 中， 信号量  控制并发 （TODO）



