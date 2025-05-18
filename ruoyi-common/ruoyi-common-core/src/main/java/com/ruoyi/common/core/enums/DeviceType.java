package com.ruoyi.common.core.enums;

/**
 * 设备类型
 * 针对一套 用户体系
 *
 * @author Lion Li
 */
public enum DeviceType {
    /**
     * pc端
     */
    PC("pc"),

    /**
     * app端
     */
    APP("app"),

    /**
     * 小程序端
     */
    XCX("xcx"),

    /**
     * social第三方端
     */
    SOCIAL("social");

    private final String device;

    private DeviceType(String device) {
        this.device = device;
    }
}
