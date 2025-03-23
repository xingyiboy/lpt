package com.ruoyi.framework.web.Util;

import cn.hutool.json.JSONObject;
import cn.hutool.json.JSONUtil;
import com.alibaba.druid.support.json.JSONUtils;
import com.ruoyi.common.core.domain.entity.SysUser;
import com.ruoyi.common.core.redis.RedisCache;
import com.ruoyi.common.utils.sign.Md5Utils;
import jakarta.servlet.http.HttpSession;
import lpt.faceDTO.LptFaceCompareRepVo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.*;
import org.springframework.stereotype.Component;
import org.springframework.web.client.RestTemplate;
import com.fasterxml.jackson.databind.ObjectMapper;

import javax.crypto.Cipher;
import javax.crypto.spec.IvParameterSpec;
import javax.crypto.spec.SecretKeySpec;
import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.io.UnsupportedEncodingException;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLDecoder;
import java.net.URLEncoder;
import java.util.*;
import java.util.stream.Collectors;

import static cn.hutool.http.cookie.GlobalCookieManager.getCookies;

/**
 * 令牌通接口对接
 */
@Component
public class LptSignUtil {

    private static final RestTemplate restTemplate = new RestTemplate();
    private static final ObjectMapper objectMapper = new ObjectMapper();

    @Autowired
    private RedisCache redisCache;

    public static void sendAdd(Object newUesr) {
        try {
            URL url = new URL("http://localhost:8080/system/member/addHttp");
            // 打开连接
            HttpURLConnection connection = (HttpURLConnection) url.openConnection();
            connection.setRequestMethod("POST");
            connection.setDoOutput(true);  // 允许输出内容
            connection.setRequestProperty("Content-Type", "application/json");  // 设置请求类型
            connection.setRequestProperty("Authorization", "Bearer <your-token>");  // 替换为实际的令牌
            // 要发送的数据（JSON格式）
            String jsonInputString = JSONUtil.toJsonStr(newUesr);

            // 发送请求数据
            try (OutputStream os = connection.getOutputStream()) {
                byte[] input = jsonInputString.getBytes("utf-8");
                os.write(input, 0, input.length);
            }

            // 获取响应代码
            int responseCode = connection.getResponseCode();
            System.out.println("Response Code: " + responseCode);
            Map<String, String> responseMap = new HashMap<>();
            // 读取响应内容并提取 cookies
            try (BufferedReader in = new BufferedReader(new InputStreamReader(connection.getInputStream(), "utf-8"))) {
                String inputLine;
                StringBuilder response = new StringBuilder();
                while ((inputLine = in.readLine()) != null) {
                    response.append(inputLine);
                }

                // 提取 Set-Cookie 响应头
                Map<String, List<String>> headers = connection.getHeaderFields();
                List<String> cookiesHeader = headers.get("Set-Cookie");
                if (cookiesHeader != null) {
                    for (String setCookie : cookiesHeader) {
                        responseMap.put("cookie",setCookie);
                    }
                }
                responseMap.put("response",response.toString());
            }

        } catch (Exception e) {
        }
    }

    public static void sendUpdate(Object newUesr) {
        try {
            URL url = new URL("http://localhost:8080/system/member/editHttp");
            // 打开连接
            HttpURLConnection connection = (HttpURLConnection) url.openConnection();
            connection.setRequestMethod("PUT");
            connection.setDoOutput(true);  // 允许输出内容
            connection.setRequestProperty("Content-Type", "application/json");  // 设置请求类型
            connection.setRequestProperty("Authorization", "Bearer <your-token>");  // 替换为实际的令牌
            // 要发送的数据（JSON格式）
            String jsonInputString = JSONUtil.toJsonStr(newUesr);

            // 发送请求数据
            try (OutputStream os = connection.getOutputStream()) {
                byte[] input = jsonInputString.getBytes("utf-8");
                os.write(input, 0, input.length);
            }

            // 获取响应代码
            int responseCode = connection.getResponseCode();
            System.out.println("Response Code: " + responseCode);
            Map<String, String> responseMap = new HashMap<>();
            // 读取响应内容并提取 cookies
            try (BufferedReader in = new BufferedReader(new InputStreamReader(connection.getInputStream(), "utf-8"))) {
                String inputLine;
                StringBuilder response = new StringBuilder();
                while ((inputLine = in.readLine()) != null) {
                    response.append(inputLine);
                }

                // 提取 Set-Cookie 响应头
                Map<String, List<String>> headers = connection.getHeaderFields();
                List<String> cookiesHeader = headers.get("Set-Cookie");
                if (cookiesHeader != null) {
                    for (String setCookie : cookiesHeader) {
                        responseMap.put("cookie",setCookie);
                    }
                }
                responseMap.put("response",response.toString());
            }

        } catch (Exception e) {
        }
    }

//    /**
//     * 常用属性注入
//     */
//    private final String appSecret;
//    private final String aesIv;
//
//    public LptSignUtil(
//            @Value("${signature.appSecret}") String appSecret,
//            @Value("${signature.aesIv}") String aesIv
//    ) {
//        this.appSecret = appSecret;
//        this.aesIv = aesIv;
//    }

    /**
     * 生成签名
     *
     * @param params 参数集合
     * @return 签名字符串
     * @throws Exception 异常
     */
    public String generateSign(Map<String, String> params,String appSecret) throws Exception {
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
        String md5 = Md5Utils.hash(string);
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

    public  String encrypt(String plainText,String appSecret,String aesIv) throws Exception {
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

    public String decrypt(String encryptedText,String appSecret,String aesIv) throws Exception {
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
     * 发送API请求
     *
     * @param dataMap    请求数据
     * @param url        请求URL
     * @return 响应结果
     */
    public  String sendApiRequest(Map<String, String> dataMap, String url, String appSecret, String aesIv)  {
        try {
            // 1. 准备公共请求参数
            String timestamp = generateTimestamp();

            // 2. 转换请求数据为JSON字符串
            String jsonString = JSONUtils.toJSONString(dataMap);

            // 3. 构建请求参数Map
            Map<String, String> params = new HashMap<>();
            params.put("timestamp", timestamp);
            params.put("data", jsonString);

            // 4. 生成签名
            String sign = generateSign(params, appSecret);
            params.put("sign", sign);

            // 5. AES加密数据
            String encryptedData = encrypt(jsonString, appSecret, aesIv);
            params.put("data", encryptedData);

            // 6. 构建HTTP请求体
            HttpHeaders headers = new HttpHeaders();
            headers.setContentType(MediaType.APPLICATION_JSON);
            HttpEntity<Map<String, String>> entity = new HttpEntity<>(params, headers);

            // 7. 发送POST请求
            ResponseEntity<String> response = restTemplate.postForEntity(url, entity, String.class);

            // 8. 处理响应
            if (response.getStatusCode() == HttpStatus.OK) {
                String responseBody = response.getBody();
                Map<String, Object> responseMap = objectMapper.readValue(responseBody, Map.class);
                return processResponse(responseMap, appSecret, aesIv);
            } else {
                return null;
            }
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }

    public static Map<String, String> sendLogin(Object data, String cookie){
        try {
            URL url = new URL("http://localhost:8080/system/member/login");
            // 打开连接
            HttpURLConnection connection = (HttpURLConnection) url.openConnection();
            connection.setRequestMethod("POST");
            connection.setDoOutput(true);  // 允许输出内容
            connection.setRequestProperty("Content-Type", "application/json");  // 设置请求类型
            connection.setRequestProperty("Authorization", "Bearer <your-token>");  // 替换为实际的令牌
            if (cookie != null) {
                connection.setRequestProperty("Cookie", cookie);
            }
            // 要发送的数据（JSON格式）
            String jsonInputString = JSONUtil.toJsonStr(data);

            // 发送请求数据
            try (OutputStream os = connection.getOutputStream()) {
                byte[] input = jsonInputString.getBytes("utf-8");
                os.write(input, 0, input.length);
            }

            // 获取响应代码
            int responseCode = connection.getResponseCode();
            System.out.println("Response Code: " + responseCode);
            Map<String, String> responseMap = new HashMap<>();
            // 读取响应内容并提取 cookies
            try (BufferedReader in = new BufferedReader(new InputStreamReader(connection.getInputStream(), "utf-8"))) {
                String inputLine;
                StringBuilder response = new StringBuilder();
                while ((inputLine = in.readLine()) != null) {
                    response.append(inputLine);
                }

                // 提取 Set-Cookie 响应头
                Map<String, List<String>> headers = connection.getHeaderFields();
                List<String> cookiesHeader = headers.get("Set-Cookie");
                if (cookiesHeader != null) {
                    for (String setCookie : cookiesHeader) {
                        responseMap.put("cookie",setCookie);
                    }
                }
                responseMap.put("response",response.toString());
                return responseMap;
            }

        } catch (Exception e) {
            return null;
        }
    }

    /**
     * 处理响应结果
     *
     * @param responseMap 响应结果
     * @return 处理后的数据
     */
    private String processResponse(Map<String, Object> responseMap ,String appSecret, String aesIv) {
        String resultCode = (String) responseMap.get("resultcode");
        String msg = (String) responseMap.get("msg");
        Object data = responseMap.get("data");

        System.out.println("结果代码: " + resultCode);
        System.out.println("信息: " + msg);

        if (data != null) {
            try {
                String decryptedData = decrypt(data.toString(),appSecret,aesIv);
                return decryptedData;
            } catch (Exception e) {
                System.out.println("解密失败");
                return null;
            }
        }
        return null;
    }

    /**
     * 生成时间戳
     *
     * @return 时间戳
     */
    private static String generateTimestamp() {
        // 这里实现时间戳的生成逻辑
        return String.valueOf(System.currentTimeMillis());
    }
}
