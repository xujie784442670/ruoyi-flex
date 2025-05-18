package com.ruoyi;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.autoconfigure.data.web.SpringDataWebAutoConfiguration;
import org.springframework.boot.context.metrics.buffering.BufferingApplicationStartup;

/**
 * 启动程序
 *
 * @author ruoyi
 */
@SpringBootApplication(exclude = SpringDataWebAutoConfiguration.class)
public class RuoYiApplication
{
    public static void main(String[] args)
    {
        SpringApplication application = new SpringApplication(RuoYiApplication.class);
        application.setApplicationStartup(new BufferingApplicationStartup(2048));
        application.run(args);
        System.out.println("(♥◠‿◠)ﾉﾞ  RuoYi-Flex-Boot启动成功   ლ(´ڡ`ლ)ﾞ  \n" +
                " ███████                    ██    ██ ██       ████████  ██                \n" +
                "░██░░░░██                  ░░██  ██ ░░       ░██░░░░░  ░██                \n" +
                "░██   ░██  ██   ██  ██████  ░░████   ██      ░██       ░██  █████  ██   ██\n" +
                "░███████  ░██  ░██ ██░░░░██  ░░██   ░██ █████░███████  ░██ ██░░░██░░██ ██ \n" +
                "░██░░░██  ░██  ░██░██   ░██   ░██   ░██░░░░░ ░██░░░░   ░██░███████ ░░███  \n" +
                "░██  ░░██ ░██  ░██░██   ░██   ░██   ░██      ░██       ░██░██░░░░   ██░██ \n" +
                "░██   ░░██░░██████░░██████    ░██   ░██      ░██       ███░░██████ ██ ░░██\n" +
                "░░     ░░  ░░░░░░  ░░░░░░     ░░    ░░       ░░       ░░░  ░░░░░░ ░░   ░░ \n" +
                "\n");
    }
}
