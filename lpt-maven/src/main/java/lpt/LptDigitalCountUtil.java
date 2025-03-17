package lpt;

import cn.hutool.captcha.CaptchaUtil;
import cn.hutool.captcha.CircleCaptcha;
import cn.hutool.captcha.LineCaptcha;
import cn.hutool.captcha.ShearCaptcha;
import cn.hutool.captcha.generator.MathGenerator;

import java.util.HashMap;
import java.util.Map;

/**
 * @Description: 令牌通数字计算验证码 interference:干扰程度
 * @author: huangguoshan
 * @date: 2025年03月15日 19:15
 */
public class LptDigitalCountUtil {

    /**
     * 生成线段干扰数字计算验证码
     * @return
     */
    public static Map<String, Object> getLineVerification(Integer codeCount,Integer interference,Integer width,Integer height){
        LineCaptcha captcha = CaptchaUtil.createLineCaptcha(width, height,codeCount,interference);
        captcha.setGenerator(new MathGenerator());
        captcha.createCode();
        Map<String, Object> map = new HashMap<>();
        map.put("code", calculateExpression(captcha.getCode()));
        map.put("image", captcha.getImageBase64Data());
        return map;
    }

    /**
     * 生成圆圈干扰数字计算验证码
     * @return
     */
    public static Map<String, Object> getCircleVerification(Integer codeCount,Integer interference,Integer width,Integer height){
        CircleCaptcha captcha = CaptchaUtil.createCircleCaptcha(width, height, codeCount, interference);
        captcha.setGenerator(new MathGenerator());
        captcha.createCode();
        Map<String, Object> map = new HashMap<>();
        map.put("code", calculateExpression(captcha.getCode()));
        map.put("image", captcha.getImageBase64Data());
        return map;
    }

    /**
     * 生成扭曲干扰数字计算验证码
     * @return
     */
    public static Map<String, Object> getShearVerification(Integer codeCount,Integer interference,Integer width,Integer height){
        ShearCaptcha captcha = CaptchaUtil.createShearCaptcha(width, height, codeCount, interference);
        captcha.setGenerator(new MathGenerator());
        captcha.createCode();
        Map<String, Object> map = new HashMap<>();
        map.put("code", calculateExpression(captcha.getCode()));
        map.put("image", captcha.getImageBase64Data());
        return map;
    }

    /**
     * 计算表达式
     * @param expression
     * @return
     */
    private static int calculateExpression(String expression) {
        // 如果表达式包含等号，只取等号前面的部分
        if (expression.contains("=")) {
            expression = expression.split("=")[0];
        }
        // 处理加法
        if (expression.contains("+")) {
            String[] numbers = expression.split("\\+");
            return Integer.parseInt(numbers[0].trim()) + Integer.parseInt(numbers[1].trim());
        }
        // 处理减法
        else if (expression.contains("-")) {
            String[] numbers = expression.split("-");
            return Integer.parseInt(numbers[0].trim()) - Integer.parseInt(numbers[1].trim());
        }
        // 处理乘法
        else if (expression.contains("*") || expression.contains("×")) {
            String[] numbers = expression.split("[*×]");
            return Integer.parseInt(numbers[0].trim()) * Integer.parseInt(numbers[1].trim());
        }
        // 处理除法
        else if (expression.contains("/") || expression.contains("÷")) {
            String[] numbers = expression.split("[/÷]");
            return Integer.parseInt(numbers[0].trim()) / Integer.parseInt(numbers[1].trim());
        }
        throw new IllegalArgumentException("不支持的运算符");
    }

}
