# 使用官方的 Java 运行时作为父镜像
FROM registry.cn-qingdao.aliyuncs.com/yuzl1/jdk:21

MAINTAINER Lion Li

RUN mkdir -p /ruoyi/easyretry/logs

WORKDIR /ruoyi/easyretry

ENV LANG=C.UTF-8 LC_ALL=C.UTF-8 JAVA_OPTS="-Xms512m -Xmx1024m"

EXPOSE 8800
EXPOSE 1788

ADD ./target/ruoyi-easyretry-server.jar ./app.jar

ENTRYPOINT java -Djava.security.egd=file:/dev/./urandom -jar app.jar \
           -XX:+HeapDumpOnOutOfMemoryError -Xlog:gc*,:time,tags,level -XX:+UseZGC ${JAVA_OPTS}
