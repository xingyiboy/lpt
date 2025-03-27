package com.ruoyi.system.util;

import com.alibaba.nacos.common.utils.MD5Utils;
import org.springframework.stereotype.Component;

import javax.crypto.Cipher;
import javax.crypto.spec.IvParameterSpec;
import javax.crypto.spec.SecretKeySpec;
import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.net.URLEncoder;
import java.util.*;

/**
 * 令牌通接口对接
 */
@Component
public class LptSignUtil {

    /**
     * 生成签名
     *
     * @param params 参数集合
     * @return 签名字符串
     * @throws Exception 异常
     */
    public static String generateSign(Map<String, String> params,String appSecret) throws Exception {
        // 1. 移除sign参数
        Map<String, String> filteredParams = new HashMap<>(params);
        filteredParams.remove("sign");

        // 2. 移除值为null的参数
        filteredParams.values().removeIf(value -> value==null);

        // 3. 按照字典序排序
        List<String> keys = new ArrayList<>(filteredParams.keySet());
        Collections.sort(keys);

        // 4. 拼接字符串
        StringBuilder stringA = new StringBuilder();
        for (String key : keys) {
            String value = filteredParams.get(key);
            stringA.append(key).append("=").append(value).append("&");
        }

        // 5. 添加key=AppSecret
        stringA.append("key=").append(appSecret);
        // 6. MD5加密
        String string = stringA.toString();
        String md5 = MD5Utils.md5Hex(string.getBytes());
        // 7. 转换为大写的十六进制字符串
        String upperCase = md5.toUpperCase();
        return upperCase;
    }

    /**
     * 将十六进制字符串转换为字节数组
     *
     * @param s 十六进制字符串
     * @return 字节数组
     */
    private static byte[] hexStringToByteArray(String s) {
        int len = s.length();
        if (len % 2 != 0) {
            throw new IllegalArgumentException("十六进制字符串长度必须是偶数");
        }
        byte[] data = new byte[len / 2];
        for (int i = 0; i < len; i += 2) {
            data[i / 2] = (byte) ((Character.digit(s.charAt(i), 16) << 4)
                    + Character.digit(s.charAt(i+1), 16));
        }
        return data;
    }

    // URL 编码方法
    public static String encode(String value) throws UnsupportedEncodingException {
        if (value == null) {
            return null;
        }
        // 使用 UTF-8 编码格式
        return URLEncoder.encode(value, "UTF-8");
    }

    // URL 解码方法
    public static String decode(String value) throws UnsupportedEncodingException {
        if (value == null) {
            return null;
        }
        // 使用 UTF-8 编码格式
        return URLDecoder.decode(value, "UTF-8");
    }


    /**
     * 加密
     * @param plainText
     * @param appSecret
     * @param aesIv
     * @return
     * @throws Exception
     */
    public static String encrypt(String plainText,String appSecret,String aesIv) throws Exception {
        byte[] keyBytes = appSecret.getBytes("UTF-8");
        if (keyBytes.length != 32) {
            throw new IllegalArgumentException("密钥长度必须为 32 字节 (256 位)!");
        }
        SecretKeySpec secretKey = new SecretKeySpec(keyBytes, "AES");

        byte[] ivBytes = aesIv.getBytes("UTF-8");
        if (ivBytes.length != 16) {
            throw new IllegalArgumentException("IV 长度必须为 16 字节!");
        }
        IvParameterSpec iv = new IvParameterSpec(ivBytes);

        Cipher cipher = Cipher.getInstance("AES/CBC/PKCS5Padding");
        cipher.init(Cipher.ENCRYPT_MODE, secretKey, iv);

        byte[] encrypted = cipher.doFinal(plainText.getBytes("UTF-8"));

        String base64Encoded = Base64.getEncoder().encodeToString(encrypted);
        //用URL编码
        base64Encoded = encode(base64Encoded);
        return base64Encoded;
    }

    /**
     * 解密
     * @param encryptedText
     * @param appSecret
     * @param aesIv
     * @return
     * @throws Exception
     */
    public static String decrypt(String encryptedText,String appSecret,String aesIv) throws Exception {
        //用URL解码
        encryptedText = decode(encryptedText);

        // 解码 Base64
        byte[] encryptedBytes = Base64.getDecoder().decode(encryptedText);

        // 构建密钥
        byte[] keyBytes = appSecret.getBytes("UTF-8");
        if (keyBytes.length != 32) {
            throw new IllegalArgumentException("密钥长度必须为 32 字节 (256 位)!");
        }
        SecretKeySpec secretKey = new SecretKeySpec(keyBytes, "AES");

        // 构建 IV
        byte[] ivBytes = aesIv.getBytes("UTF-8");
        if (ivBytes.length != 16) {
            throw new IllegalArgumentException("IV 长度必须为 16 字节!");
        }
        IvParameterSpec iv = new IvParameterSpec(ivBytes);

        // 创建 Cipher 对象并初始化为解密模式
        Cipher cipher = Cipher.getInstance("AES/CBC/PKCS5Padding");
        cipher.init(Cipher.DECRYPT_MODE, secretKey, iv);

        // 解密并转换回字符串
        byte[] decrypted = cipher.doFinal(encryptedBytes);
        return new String(decrypted, "UTF-8");
    }

    /**
     * 生成时间戳
     *
     * @return 时间戳
     */
    private static String generateTimestamp() {
        // 这里实现时间戳的生成逻辑
        return java.lang.String.valueOf(System.currentTimeMillis());
    }
}
