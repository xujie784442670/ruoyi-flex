package com.ruoyi.common.orm.decipher;

import com.mybatisflex.core.datasource.DataSourceDecipher;
import com.mybatisflex.core.datasource.DataSourceProperty;

/**
 * 数据源解密
 *
 * @author dataprince数据小王子
 */
public class Decipher implements DataSourceDecipher {
    @Override
    public String decrypt(DataSourceProperty property, String value) {
        //解密数据源URL、用户名、密码，通过编码支持任意加密方式的解密
        //为了减轻入门用户负担，默认返回原字符，用户可以定制加解密算法

        String result = "";

        switch (property) {
            case URL -> result = value;
            case USERNAME -> result = value;
            case PASSWORD -> result = value;
        }
        return result;
    }
}
