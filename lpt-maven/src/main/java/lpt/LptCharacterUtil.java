package lpt;

import cn.hutool.captcha.CaptchaUtil;
import cn.hutool.captcha.CircleCaptcha;
import cn.hutool.captcha.LineCaptcha;
import cn.hutool.captcha.ShearCaptcha;
import cn.hutool.captcha.generator.MathGenerator;
import cn.hutool.captcha.generator.RandomGenerator;

import java.util.HashMap;
import java.util.Map;

/**
 * @Description: 令牌通字符验证
 * @author: huangguoshan
 * @date: 2025年03月15日 21:21
 */
public class LptCharacterUtil {
    /**
     * 生成线段干扰字符验证码(纯数字)
     * @return
     */
    public static Map<String, Object> getLineNumberVerification(Integer codeCount, Integer interference,Integer length){
        LineCaptcha captcha = CaptchaUtil.createLineCaptcha(200, 100,codeCount,interference);
        RandomGenerator randomGenerator = new RandomGenerator("0123456789", length);
        captcha.setGenerator(randomGenerator);
        captcha.createCode();
        Map<String, Object> map = new HashMap<>();
        map.put("code", captcha.getCode());
        map.put("image", captcha.getImage());
        return map;
    }

    /**
     * 生成圆圈干扰字符验证码(纯数字)
     * @return
     */
    public static Map<String, Object> getCircleNumberVerification(Integer codeCount,Integer interference,Integer length){
        CircleCaptcha captcha = CaptchaUtil.createCircleCaptcha(200, 100, codeCount, interference);
        RandomGenerator randomGenerator = new RandomGenerator("0123456789", length);
        captcha.setGenerator(randomGenerator);
        captcha.createCode();
        Map<String, Object> map = new HashMap<>();
        map.put("code", captcha.getCode());
        map.put("image", captcha.getImage());
        return map;
    }

    /**
     * 生成扭曲干扰字符验证码(纯数字)
     * @return
     */
    public static Map<String, Object> getShearNumberVerification(Integer codeCount,Integer interference,Integer length){
        ShearCaptcha captcha = CaptchaUtil.createShearCaptcha(200, 100, codeCount, interference);
        RandomGenerator randomGenerator = new RandomGenerator("0123456789", length);
        captcha.setGenerator(randomGenerator);
        captcha.createCode();
        Map<String, Object> map = new HashMap<>();
        map.put("code", captcha.getCode());
        map.put("image", captcha.getImage());
        return map;
    }

    /**
     * 生成线段干扰字符验证码(纯字母)
     * @param codeCount 验证码数量
     * @param interference 干扰线数量
     * @param length 字符长度
     * @return
     */
    public static Map<String, Object> getLineLetterVerification(Integer codeCount, Integer interference, Integer length){
        LineCaptcha captcha = CaptchaUtil.createLineCaptcha(200, 100, codeCount, interference);
        RandomGenerator randomGenerator = new RandomGenerator("abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ", length);
        captcha.setGenerator(randomGenerator);
        captcha.createCode();
        Map<String, Object> map = new HashMap<>();
        map.put("code", captcha.getCode());
        map.put("image", captcha.getImage());
        return map;
    }

    /**
     * 生成线段干扰字符验证码(数字+字母)
     * @param codeCount 验证码数量
     * @param interference 干扰线数量
     * @param length 字符长度
     * @return
     */
    public static Map<String, Object> getLineMixVerification(Integer codeCount, Integer interference, Integer length){
        LineCaptcha captcha = CaptchaUtil.createLineCaptcha(200, 100, codeCount, interference);
        RandomGenerator randomGenerator = new RandomGenerator("0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ", length);
        captcha.setGenerator(randomGenerator);
        captcha.createCode();
        Map<String, Object> map = new HashMap<>();
        map.put("code", captcha.getCode());
        map.put("image", captcha.getImage());
        return map;
    }

    /**
     * 生成圆圈干扰字符验证码(纯字母)
     * @param codeCount 验证码数量
     * @param interference 干扰圆圈数量
     * @param length 字符长度
     * @return
     */
    public static Map<String, Object> getCircleLetterVerification(Integer codeCount, Integer interference, Integer length){
        CircleCaptcha captcha = CaptchaUtil.createCircleCaptcha(200, 100, codeCount, interference);
        RandomGenerator randomGenerator = new RandomGenerator("abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ", length);
        captcha.setGenerator(randomGenerator);
        captcha.createCode();
        Map<String, Object> map = new HashMap<>();
        map.put("code", captcha.getCode());
        map.put("image", captcha.getImage());
        return map;
    }

    /**
     * 生成圆圈干扰字符验证码(数字+字母)
     * @param codeCount 验证码数量
     * @param interference 干扰圆圈数量
     * @param length 字符长度
     * @return
     */
    public static Map<String, Object> getCircleMixVerification(Integer codeCount, Integer interference, Integer length){
        CircleCaptcha captcha = CaptchaUtil.createCircleCaptcha(200, 100, codeCount, interference);
        RandomGenerator randomGenerator = new RandomGenerator("0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ", length);
        captcha.setGenerator(randomGenerator);
        captcha.createCode();
        Map<String, Object> map = new HashMap<>();
        map.put("code", captcha.getCode());
        map.put("image", captcha.getImage());
        return map;
    }

    /**
     * 生成扭曲干扰字符验证码(纯字母)
     * @param codeCount 验证码数量
     * @param interference 干扰线数量
     * @param length 字符长度
     * @return
     */
    public static Map<String, Object> getShearLetterVerification(Integer codeCount, Integer interference, Integer length){
        ShearCaptcha captcha = CaptchaUtil.createShearCaptcha(200, 100, codeCount, interference);
        RandomGenerator randomGenerator = new RandomGenerator("abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ", length);
        captcha.setGenerator(randomGenerator);
        captcha.createCode();
        Map<String, Object> map = new HashMap<>();
        map.put("code", captcha.getCode());
        map.put("image", captcha.getImage());
        return map;
    }

    /**
     * 生成扭曲干扰字符验证码(数字+字母)
     * @param codeCount 验证码数量
     * @param interference 干扰线数量
     * @param length 字符长度
     * @return
     */
    public static Map<String, Object> getShearMixVerification(Integer codeCount, Integer interference, Integer length){
        ShearCaptcha captcha = CaptchaUtil.createShearCaptcha(200, 100, codeCount, interference);
        RandomGenerator randomGenerator = new RandomGenerator("0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ", length);
        captcha.setGenerator(randomGenerator);
        captcha.createCode();
        Map<String, Object> map = new HashMap<>();
        map.put("code", captcha.getCode());
        map.put("image", captcha.getImage());
        return map;
    }
}
