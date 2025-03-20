package com.ruoyi.system.util;

import lpt.DigitalCountUtil;
import lpt.EmailUtil;

import java.util.Map;

/**
 * @Description: TODO
 * @author: huangguoshan
 * @date: 2025年03月15日 20:42
 */
public class Test {
    public static void main(String[] args) {
        EmailUtil.send("smtp.qq.com",465,true,"2832914238@qq.com","zedgqaxuwhnldgab","2416820386@qq.com","测试","测试内容");
    }
}
