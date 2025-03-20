package lpt;

import cn.hutool.core.lang.Console;
import cn.hutool.http.Header;
import cn.hutool.http.HttpRequest;
import cn.hutool.json.JSONObject;
import cn.hutool.json.JSONUtil;
import lpt.faceDTO.FaceCompareRepVo;
import lpt.faceDTO.FaceCompareReqVo;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.Map;

/**
 * @Description: 1v1人脸比对工具类
 * @author: huangguoshan
 * @date: 2025年03月20日 15:20
 */
public class LptFaceComparison {
    public static final String POST_URL = "http://113.45.31.128:18071/visual/compare/do";


    /**
     * 1v1比对
     * @return
     */
    public static FaceCompareRepVo compareFace(FaceCompareReqVo faceCompareReqVo){
        try {
            URL url = new URL(POST_URL);
            // 打开连接
            HttpURLConnection connection = (HttpURLConnection) url.openConnection();
            connection.setRequestMethod("POST");
            connection.setDoOutput(true);  // 允许输出内容
            connection.setRequestProperty("Content-Type", "application/json");  // 设置请求类型
            connection.setRequestProperty("Authorization", "Bearer <your-token>");  // 替换为实际的令牌

            // 要发送的数据（JSON格式）
            String jsonInputString = JSONUtil.toJsonStr(faceCompareReqVo);

            // 发送请求数据
            try (OutputStream os = connection.getOutputStream()) {
                byte[] input = jsonInputString.getBytes("utf-8");
                os.write(input, 0, input.length);
            }

            // 获取响应代码
            int responseCode = connection.getResponseCode();
            System.out.println("Response Code: " + responseCode);

            // 读取响应内容
            try (BufferedReader in = new BufferedReader(new InputStreamReader(connection.getInputStream(), "utf-8"))) {
                String inputLine;
                StringBuilder response = new StringBuilder();
                while ((inputLine = in.readLine()) != null) {
                    response.append(inputLine);
                }
                // 解析 JSON 数据
                JSONObject jsonObject = JSONUtil.parseObj(response);
                String message = (String) jsonObject.get("message");
                FaceCompareRepVo data = jsonObject.get("data", FaceCompareRepVo.class);
                if(message.equals("success")){
                    return data;
                }
            }

        } catch (Exception e) {
            return null;
        }
        return null;
    }
}
