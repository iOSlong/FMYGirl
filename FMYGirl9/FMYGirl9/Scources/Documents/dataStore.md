
iOS 中常用的数据存储策略
1. 直接使用sqlite3  数据库
2. 使用CoreData api
3. 使用NSUserDefault
4. 使用文件存储 FileManager
5. 使用归档解档
6. other



# terminal 修改权限常用字段  chmod 777 fileName   
<!-- http://www.cnblogs.com/sipher/articles/2429772.html -->

sqlite3
# 导入系统库文件
# 在terminal中查看 如 ls  fmy.db
1. 打开数据库          $ sqlite3 fmy.db 
2. 查看库表            sqlite> .tables
3. 退出               sqlite> .q

注意一条完整的sql执行语句后面需要有‘;’分号
sqlite> select * from list;
sql语句：
create table if not exists list_data(orderID integer primary key autoincrement, desc txt, ID text, data blob)



sqlite3               *pdb, 数据库句柄，跟文件句柄FILE很类似

sqlite3_stmt      *stmt, 这个相当于ODBC的Command对象，用于保存编译好的SQL语句



sqlite3_open(),   打开数据库

sqlite3_exec(),   执行非查询的sql语句

sqlite3_prepare(), 准备sql语句，执行select语句或者要使用parameter bind时，用这个函数（封装了sqlite3_exec）.

Sqlite3_step(), 在调用sqlite3_prepare后，使用这个函数在记录集中移动。

Sqlite3_close(), 关闭数据库文件



还有一系列的函数，用于从记录集字段中获取数据，如

sqlite3_column_text(), 取text类型的数据。

sqlite3_column_blob（），取blob类型的数据

sqlite3_column_int(), 取int类型的数据


总的来说，所有存在Sqlite 3.0版本当中的数据都拥有以下之一的数据类型：
空（NULL）：该值为空
整型（INTEGEER）：有符号整数，按大小被存储成1,2,3,4,6或8字节。
实数（REAL）：浮点数，以8字节指数形式存储。
文本（TEXT）：字符串，以数据库编码方式存储（UTF-8, UTF-16BE 或者 UTF-16-LE）。
BLOB：BLOB数据不做任何转换，以输入形式存储。


$ ls
fmy.db
$ sqlite3 fmy.db 
SQLite version 3.8.10.2 2015-05-20 18:17:19
Enter ".help" for usage hints.
sqlite> .tables
list_data
sqlite> select * from sqlite_master WHERE type = "table";
table|list_data|list_data|2|CREATE TABLE list_data(orderID integer primary key autoincrement, ID text, desc txt, data blob)
table|sqlite_sequence|sqlite_sequence|3|CREATE TABLE sqlite_sequence(name,seq)
sqlite> .q

# 注意 insert into list_data(ID, desc, data)values('%@', '%@', '%@')"    这里values item 在语句中需要{''}单引号

在读取blob  Data转json数据的时候出现
po error
Error Domain=NSCocoaErrorDomain Code=3840 "JSON text did not start with array or object and option to allow fragments not set." UserInfo={NSDebugDescription=JSON text did not start with array or object and option to allow fragments not set.}
=========









参考文档：
<!--http://www.jianshu.com/p/b70e127497dc  《iOS开发－sqlite3使用》-->
<!--http://www.th7.cn/system/mac/201511/141470.shtml   《sqlite3 －－sql命令简单介绍（zt）》-->

<!--http://blog.csdn.net/chinaclock/article/details/48656277 《好东西！sqlite3中BLOB数据类型存储大对象运用示例》-->



