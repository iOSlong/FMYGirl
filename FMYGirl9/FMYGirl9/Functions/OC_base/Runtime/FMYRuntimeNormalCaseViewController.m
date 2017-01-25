//
//  FMYRuntimeNormalCaseViewController.m
//  FMYGirl9
//
//  Created by xuewu.long on 17/1/25.
//  Copyright © 2017年 fmy.long. All rights reserved.
//

#import "FMYRuntimeNormalCaseViewController.h"
#import "FMYPerson.h"
#import "FMYChinese.h"
#import "FMYMovie.h"

#import <objc/runtime.h>

@interface FMYRuntimeNormalCaseViewController ()

@property (nonatomic) FMYPerson *person;
@property (nonatomic) FMYChinese *chinese;

@end

@implementation FMYRuntimeNormalCaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.arrDataSource addObjectsFromArray:@[@"动态变量控制",
                                             @"动态添加方法",
                                             @"动态交换两个方法的实现",
                                             @"拦截并替换方法",
                                             @"在方法上增加额外功能",
                                             @"实现NSCoding的自动归档和解档",
                                             @"实现字典转模型的自动转换"
                                             ]];
    
    
    self.person = [FMYPerson new];
    self.person.name    = @"柳月星";
    self.person.sex     = @1;
    
    self.chinese = [FMYChinese new];
    self.chinese.name   = @"凝小曦";
    self.chinese.sex    = @0;
    
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.row == 0)
    {
        NSLog(@"person.name = %@",self.person.name);
        [self personName];
    }
    else if ( indexPath.row == 1)
    {
        [self personSay];
    }
    else if ( indexPath.row == 2)
    {
        [self personConfusion];
    }
    else if ( indexPath.row == 3)
    {
        [self personPlaceASubstituteBySubterfuge];
    }
    else if ( indexPath.row == 4)
    {
        [self personCombinLishangyin];
    }
    else if ( indexPath.row == 5)
    {
        [self moveModeFromDict];
    }
    else if ( indexPath.row == 6)
    {
        [self moveArchive];

    }
   
}

- (void)personName
{
    unsigned int outCout = 0;
    
    Ivar *ivar = class_copyIvarList([self.person class], &outCout);
    
    for (int i  = 0; i < outCout; i ++)
    {
        Ivar var = ivar[i];
        const char *varName = ivar_getName(var);
         //这里别忘了给属性加下划线
        if ([[NSString stringWithUTF8String:varName] isEqualToString:@"_name"]) {
            object_setIvar(self.person, var, @"梦于瑶");
            break;
        }
    }
    
    NSLog(@"changePersonName : %@",self.person.name);
}


- (void)personSay
{
    IMP imp_sayRandom = imp_implementationWithBlock(^(){
        NSLog(@"%@ say number %d",self.person.name, arc4random()%99999);
    });
    
    class_addMethod([self.person class], @selector(sayRandom), imp_sayRandom, "v@:");

    if ([self.person respondsToSelector:@selector(sayRandom)]) {
        [self.person performSelector:@selector(sayRandom)];
    }
    else
    {
        NSLog(@"Sorry,I don't know");
    }
}


- (void)personConfusion
{
    NSLog(@"person say name:");
    [self.person sayName];
    NSLog(@"person say sex:");
    [self.person saySex];
    
    
    Method sayName  = class_getInstanceMethod([self.person class], @selector(sayName));
    Method saySex   = class_getInstanceMethod([self.person class], @selector(saySex));
    
    method_exchangeImplementations(saySex, sayName);
    
    NSLog(@"after personConfused =======");
    NSLog(@"person say name:");
    [self.person sayName];
    NSLog(@"person say sex:");
    [self.person saySex];

}


- (void)personPlaceASubstituteBySubterfuge
{
    NSLog(@"befor Artifact:");
    [self.person sayName];
    //这里也可以使用 [self.person class],不过要先初始化
    Method m1 = class_getInstanceMethod([FMYPerson class], @selector(sayName));
    Method m2 = class_getInstanceMethod([FMYChinese class], @selector(learnTheArtifact));
    
    method_exchangeImplementations(m1, m2);
    
    NSLog(@"after Artifact:");
    [self.person sayName];
}


- (void)personCombinLishangyin
{
    NSString *first = [self.person shangyinLi];
    NSLog(@"%@",first);
    
    // 利用它FMYChinese+Lishangyin  调整方法shangyinLi。
    NSString *lishangyin = [self.chinese shangyinLi];
    NSLog(@"%@",lishangyin);
}



- (void)moveModeFromDict
{
    NSDictionary *user = @{ @"name":@"zhangsan",
                            @"age": @(12),
                            @"sex": @"man",
                            };
    
    NSDictionary *dict = @{ @"movieId":@"28678",
                            @"movieName": @"539fU8276",
                            @"pic_url": @"fsdfds",
                            @"user" : user
                            };
    
    
    NSArray *addarr = @[dict ,dict, dict];
    
    NSMutableDictionary *mudict = [NSMutableDictionary dictionaryWithDictionary:dict];
    
    
    [mudict setObject:user forKey:@"user"];
    
    NSMutableArray *allDataArray = [NSMutableArray array];
    
    for (NSDictionary *item in addarr) {
        //这种是系统自带的方式
        //        Movie *movie = [Movie new];
        //        [movie setValuesForKeysWithDictionary:item];
        //        [self.allDataArray addObject:movie];
        
        FMYMovie *movie = [FMYMovie objectWithDict:item];
        [allDataArray addObject:movie];
    }
    
    
    NSLog(@"----%@", allDataArray);
    
}



- (void)moveArchive
{
    FMYMovie *m = [FMYMovie new];
    m.movieName = @"aaaaaaaa";
    m.movieId = @"1222331";
    m.pic_url = @"llllllllll";
    
    NSString *document  = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).lastObject;
    NSString *filePath = [document stringByAppendingString:@"/123.txt"];
    
    //模型写入文件
    [NSKeyedArchiver archiveRootObject:m toFile:filePath];
    
    
    //读取
    FMYMovie *movie =  [NSKeyedUnarchiver unarchiveObjectWithFile:filePath];
    
    NSLog(@"----%@",movie);

}

@end
