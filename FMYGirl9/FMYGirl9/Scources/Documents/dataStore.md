
iOS 中常用的数据存储策略
1. 直接使用sqlite3  数据库
2. 使用CoreData api
3. 使用NSUserDefault
4. 使用文件存储 FileManager
5. 使用归档解档
6. other



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












参考文档：
<!--http://www.jianshu.com/p/b70e127497dc  《iOS开发－sqlite3使用》-->
