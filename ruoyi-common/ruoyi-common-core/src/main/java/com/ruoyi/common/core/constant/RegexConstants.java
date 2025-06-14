package com.ruoyi.common.core.constant;

import cn.hutool.core.lang.RegexPool;

/**
 * 常用正则表达式字符串
 * <p>
 * 常用正则表达式集合，更多正则见: https://any86.github.io/any-rule/
 *
 * @author Feng
 */
public interface RegexConstants extends RegexPool {

    /**
     * 字典类型必须以字母开头，且只能为（小写字母，数字，下滑线）
     */
    public static final String DICTIONARY_TYPE = "^[a-z][a-z0-9_]*$";

    /**
     * 身份证号码（后6位）
     */
    public static final String ID_CARD_LAST_6 = "^(([0-2][1-9])|10|20|30|31)\\d{3}[0-9Xx]$";

    /**
     * QQ号码
     */
    public static final String QQ_NUMBER = "^[1-9][0-9]\\d{4,9}$";

    /**
     * 邮政编码
     */
    public static final String POSTAL_CODE = "^[1-9]\\d{5}$";

    /**
     * 注册账号
     */
    public static final String ACCOUNT = "^[a-zA-Z][a-zA-Z0-9_]{4,15}$";

    /**
     * 密码：包含至少8个字符，包括大写字母、小写字母、数字和特殊字符
     */
    public static final String PASSWORD = "^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)(?=.*[@$!%*?&])[A-Za-z\\d@$!%*?&]{8,}$";

    /**
     * 通用状态（0表示正常，1表示停用）
     */
    public static final String STATUS = "^[01]$";

}
