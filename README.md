<p align="center">
	<img alt="logo" src="https://gitee.com/dataprince/ruoyi-flex/raw/master/image/ruoyi-flex-logo.png">
</p>
<h1 align="center" style="margin: 30px 0 30px; font-weight: bold;">Ruoyi-Flex V5.2.0-SNAPSHOT</h1>
<h4 align="center">Ruoyi-Flex是基于JDK21、Spring Boot V3.2.X+平台 前后端分离的未来8年更快的Java开发框架</h4>


## 1、平台简介

Ruoyi-Flex是一套全部开源的快速开发平台，针对”分布式集群与多租户“场景全方位升级，使用MIT开源许可协议，毫无保留给个人及企业免费使用。基于RuoYi-Vue、RuoYi-Vue-Plus，集成MyBatis-Flex、JDK21、SpringBootV3.2.X+、Lombok、Sa-Token、SpringDoc、Hutool、SpringBoot Admin、EasyRetry、PowerJob、Vue3、Element-Plus、AntDesign-Vben、MinIO、Flowable等优秀开源软件，支持PostgreSQL、MySQL开源数据库及其衍生分布式数据库。

## 2、系统特色
Ruoyi-Flex秉承“写的更少、性能更好、出错更低、交流通畅、快速入门” 的理念，为您带来全方位的赋能与提升：

### （1）写的更少
借助MyBatis-Flex，Ruoyi-Flex显著降低了代码输入工作量，最高降低了25.85%，参考“演示模块”中的同一功能演示程序源码对比分析（排除相同代码量的控制器、前端代码）：
<p align="center">
	<img alt="工作量" src="https://gitee.com/dataprince/ruoyi-flex/raw/master/image/workload.JPG">
</p>
除了那些复杂的遗留项目中的统计报表，在绝大部分情况下 Ruoyi-Flex 不需要手写 SQL 语句。

### （2）性能更好
除了集成的JDK21、SpringBootV3.2、MyBatis-Flex的性能提升，系统“代码生成”模块生成的代码，凡是涉及到后台数据库的多表查询，没有采用数据库的LeftJoin、InnerJoin等SQL方式，而是使用WithRelation编程装配来取代数据库LeftJoin SQL关联查询，数据库不用维护表间外键关系，将多表关联SQL语句拆分为对各个单表的主键查询，关联无 SQL，性能提高10倍。

### （3）出错更低
原来用mybatis开发需要手写SQL语句，开发后期需要增加字段，修改xml文件是一种灾难，一不留神就犯错了；而Ruoyi-Flex借助MyBatis-Flex则很好地规避了此问题，如果字段输入错误，开发环境IDEA就会自动标红报警，避免犯错。

### （4）交流通畅
“非我族类，其心必异”。Ruoyi-Flex集成了一大波国产开源软件：MyBatis-Flex、Sa-Token、Hutool、PowerJob、Element-Plus等，同根同源，交流自然顺畅，开发中遇到问题可联系作者快速得到解决。例如，同一个领域的安全框架，一个中国人只需半天就可学会Sa-Token干活，如果是学Spring Security的话，七天也不一定能学会。

### （5）多端同步
Ruoyi-Flex提供“1+3”端，1个后台端、3个前台端，熟悉js的可使用flex-elementplus-ui前端，熟悉ts的可使用ruoyiflex-elementplus-ts前端，既熟悉ts又熟悉antdesign的请使用ruoyiflex-antdesign-vben前端，总有一款适合您的前端供您选择！

### （6）入门快速
Ruoyi-Flex已集成各种开源开发框架，扫平了技术障碍，可直接上手干活。使用者只需要设计好数据库表结构，系统能可视化生成前后端本地代码，单表、树表、主子表任你选，10分钟就能开发一个模块，快速入门，开发高效。

## 3、前端项目
Ruoyi-Flex实行前后端分离仓库，本项目是java后端部分，目前有3个前端项目：

### （1）ruoyiflex-elementplus-ts
使用elementplus、typescript构建，项目地址: [ruoyiflex-elementplus-ts](https://gitee.com/dataprince/ruoyiflex-elementplus-ts)

### （2）ruoyiflex-antdesign-vben
使用antdesign、vben、typescript构建，项目地址: [ruoyiflex-antdesign-vben](https://gitee.com/dataprince/ruoyiflex-antdesign-vben)

### （3）flex-elementplus-ui
使用elementplus、js构建，项目地址: [flex-elementplus-ui](https://gitee.com/dataprince/flex-elementplus-ui)

## 4、内置功能

1.  租户管理：系统内租户的管理 如:租户套餐、过期时间、用户数量、企业信息等。
2.  租户套餐管理：系统内租户所能使用的套餐管理 如:套餐内所包含的菜单等。
3.  客户端管理：系统内对接的所有客户端管理 如: pc端、小程序端等支持动态授权登录方式 如: 短信登录、密码登录等 支持动态控制token时效。
4.  用户管理：用户是系统操作者，该功能主要完成系统用户配置。
5.  部门管理：配置系统组织机构（公司、部门、小组），树结构展现支持数据权限。
6.  岗位管理：配置系统用户所属担任职务。
7.  菜单管理：配置系统菜单，操作权限，按钮权限标识等。
8.  角色管理：角色菜单权限分配、设置角色按机构进行数据范围权限划分。
9.  字典管理：对系统中经常使用的一些较为固定的数据进行维护。
10.  参数管理：对系统动态配置常用参数。
11.  通知公告：系统通知公告信息发布维护。
12.  操作日志：系统正常操作日志记录和查询；系统异常信息日志记录和查询。
13.  登录日志：系统登录日志记录查询包含登录异常。
14.  文件管理：引入云存储服务，将文件存储到MinIO、七牛、阿里、腾讯等OSS服务器上，支持上传、下载。
15.  在线用户：当前系统中活跃用户状态监控。
16.  调度中心：集成PowerJob全新一代分布式任务调度与计算框架。
17.  代码生成：前后端代码的生成（java、html、vue、js），支持单表、树表、主子表，减少70%以上的开发工作量。
18.  系统接口：集成springdoc，根据文档注释自动生成相关的api接口文档。
19.  监控中心：集成Spring Boot Admin，监视集群系统CPU、内存、磁盘、堆栈、在线日志、Spring相关配置等。
20.  缓存监控：对系统的缓存信息查询，命令统计等。 
21.  后台数据库：支持PostgreSQL、MySQL开源数据库及其衍生分布式数据库。
22.  演示模块：mybatis、mybatis-flex两种格式代码的单表、树表、主子表三种类型的演示程序。
23.  实现多租户功能。
24.  实现乐观锁功能。
25.  实现逻辑删除功能。
26.  启用JAVA21虚拟线程、分代ZGC功能。
27.  实现API接口加密功能，密码使用密文传输。

## 5、演示图

<table>
    <tr>
        <td><img src="https://gitee.com/dataprince/ruoyi-flex/raw/master/image/main.JPG"/></td>
        <td><img src="https://gitee.com/dataprince/ruoyi-flex/raw/master/image/manul.JPG"/></td>
    </tr>
    <tr>
        <td><img src="https://gitee.com/dataprince/ruoyi-flex/raw/master/image/user.JPG"/></td>
        <td><img src="https://gitee.com/dataprince/ruoyi-flex/raw/master/image/role.JPG"/></td>
    </tr>
    <tr>
        <td><img src="https://gitee.com/dataprince/ruoyi-flex/raw/master/image/powerjob.JPG"/></td>
        <td><img src="https://gitee.com/dataprince/ruoyi-flex/raw/master/image/springbootadmin.JPG"/></td>
    </tr>
	<tr>
        <td><img src="https://gitee.com/dataprince/ruoyi-flex/raw/master/image/oss.JPG"/></td>
        <td><img src="https://gitee.com/dataprince/ruoyi-flex/raw/master/image/gen.JPG"/></td>
    </tr>	 
    <tr>
        <td><img src="https://gitee.com/dataprince/ruoyi-flex/raw/master/image/master.JPG"/></td>
        <td><img src="https://gitee.com/dataprince/ruoyi-flex/raw/master/image/preview.JPG"/></td>
    </tr>	
</table>

## 6、开发文档

本项目提供保姆级开发文档，零基础手把手入门教程，位于/doc文件夹下面，
入门必读，请下载到本地查看:《[Ruoyi-Flex开发编译手册.docx](https://gitee.com/dataprince/ruoyi-flex/raw/master/doc/Ruoyi-Flex-Guide.docx)》。

## 7、Ruoyi-Flex交流群

本软件完全开源，作者很忙，如果您在使用过程中遇到问题，请入群相互交流：
<table>
    <tr>
        <td>1、免费QQ交流群：</td>
        <td>762217712[交流1群]</td>
    </tr>   
</table>

## 8、开源协议

**为什么推荐使用本项目？**

① 本项目采用比 Apache 2.0 更宽松的 [MIT License](https://gitee.com/dataprince/ruoyi-flex/blob/master/LICENSE) 开源协议，个人与企业可 100% 免费使用，不用保留类作者、Copyright 信息。

② 代码全部开源，不会像其它项目一样，只开源部分代码，让你无法了解整个项目的架构设计。

如果这个项目让您有所收获，记得 Star 关注哦，这对我是非常不错的鼓励与支持。



## 9、参与贡献

1.  Fork 本仓库
2.  新建 Feat_xxx 分支
3.  提交代码
4.  新建 Pull Request


## 10、特别鸣谢
- [RuoYi-Vue](https://gitee.com/y_project/RuoYi-Vue)
- [RuoYi-Vue-Plus](https://gitee.com/dromara/RuoYi-Vue-Plus)
- [MyBatis-Flex](https://gitee.com/mybatis-flex/mybatis-flex)

