package com.ruoyi.monitor.admin;

import de.codecentric.boot.admin.server.config.EnableAdminServer;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

/**
 * SpringBoot Admin 监控启动程序
 *
 * @author dataprince数据小王子
 */
@EnableAdminServer
@SpringBootApplication
public class RuoYiMonitorAdminApplication {

    public static void main(String[] args) {
        SpringApplication.run(RuoYiMonitorAdminApplication.class, args);
        System.out.println("SpringBoot Admin 监控程序启动成功！");
    }

}
