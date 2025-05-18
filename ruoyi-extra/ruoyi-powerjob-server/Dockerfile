# 使用官方的 Java 运行时作为父镜像
FROM registry.cn-qingdao.aliyuncs.com/yuzl1/jdk:21

# 将本地文件复制到容器中
COPY target/ruoyi-powerjob-server.jar /ruoyi-powerjob-server.jar

# 运行应用
ENTRYPOINT ["java","-jar","/ruoyi-powerjob-server.jar"]
