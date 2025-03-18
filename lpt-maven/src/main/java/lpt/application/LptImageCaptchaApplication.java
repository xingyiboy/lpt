package lpt.application;


import lpt.application.vo.LptCaptchaResponse;
import lpt.application.vo.LptImageCaptchaVO;
import lpt.cache.CacheStore;
import lpt.common.response.LptApiResponse;
import lpt.generator.ImageCaptchaGenerator;
import lpt.generator.common.model.dto.GenerateParam;
import lpt.interceptor.CaptchaInterceptor;
import lpt.resource.ImageCaptchaResourceManager;
import lpt.validator.ImageCaptchaValidator;
import lpt.validator.common.model.dto.LptImageCaptchaTrack;
import lpt.validator.common.model.dto.MatchParam;

/**
 * @Author: 天爱有情
 * @Date 2020/5/29 8:33
 * @Description 滑块验证码应用程序
 */
public interface LptImageCaptchaApplication {

    /**
     * 生成滑块验证码
     *
     * @return
     */
    LptCaptchaResponse<LptImageCaptchaVO> generateCaptcha();

    /**
     * 生成滑块验证码
     *
     * @param type type类型
     * @return LptCaptchaResponse<SliderCaptchaVO>
     */
    LptCaptchaResponse<LptImageCaptchaVO> generateCaptcha(String type);

    /**
     * 生成滑块验证码
     *
     * @param lptCaptchaImageType 要生成webp还是jpg类型的图片
     * @return LptCaptchaResponse<SliderCaptchaVO>
     */
    LptCaptchaResponse<LptImageCaptchaVO> generateCaptcha(LptCaptchaImageType lptCaptchaImageType);

    /**
     * 生成验证码
     *
     * @param type             type
     * @param lptCaptchaImageType LptCaptchaImageType
     * @return LptCaptchaResponse<LptImageCaptchaVO>
     */
    LptCaptchaResponse<LptImageCaptchaVO> generateCaptcha(String type, LptCaptchaImageType lptCaptchaImageType);


    /**
     * 生成滑块验证码
     *
     * @param param param
     * @return LptCaptchaResponse<SliderCaptchaVO>
     */
    LptCaptchaResponse<LptImageCaptchaVO> generateCaptcha(GenerateParam param);

    /**
     * 匹配
     *
     * @param id         验证码的ID
     * @param matchParam 匹配数据，包含鼠标轨迹，设备信息等
     * @return 匹配成功返回true， 否则返回false
     */
    LptApiResponse<?> matching(String id, MatchParam matchParam);

    /**
     * 兼容一下旧版本，新版本建议使用 {@link LptImageCaptchaApplication#matching(String, MatchParam)}
     *
     * @param id    验证码的ID
     * @param track 轨迹数据
     * @return 匹配成功返回true， 否则返回false
     */
    LptApiResponse<?> matching(String id, LptImageCaptchaTrack track);

    /**
     * 兼容一下旧版本，新版本建议使用 {@link LptImageCaptchaApplication#matching(String, MatchParam)}
     *
     * @param id         id
     * @param percentage 百分比数据
     * @return boolean
     */
    @Deprecated
    boolean matching(String id, Float percentage);

    /**
     * 查询该ID是属于哪个验证码类型
     *
     * @param id id
     * @return String
     */
    String getCaptchaTypeById(String id);

    /**
     * 获取验证码资源管理器
     *
     * @return SliderCaptchaResourceManager
     */
    ImageCaptchaResourceManager getImageCaptchaResourceManager();

    /**
     * 设置 SliderCaptchaValidator 验证码验证器
     *
     * @param imageCaptchaValidator imageCaptchaValidator
     */
    void setImageCaptchaValidator(ImageCaptchaValidator imageCaptchaValidator);

    /**
     * 设置 ImageCaptchaGenerator 验证码生成器
     *
     * @param imageCaptchaGenerator SliderCaptchaGenerator
     */
    void setImageCaptchaGenerator(ImageCaptchaGenerator imageCaptchaGenerator);

    /**
     * 获取拦截器
     *
     * @return CaptchaInterceptor
     */
    CaptchaInterceptor getCaptchaInterceptor();

    /**
     * 设置 拦截器
     *
     * @param captchaInterceptor captchaInterceptor
     */
    void setCaptchaInterceptor(CaptchaInterceptor captchaInterceptor);

    /**
     * 设置 缓存存储器
     *
     * @param cacheStore cacheStore
     */
    void setCacheStore(CacheStore cacheStore);

    /**
     * 获取验证码验证器
     *
     * @return SliderCaptchaValidator
     */
    ImageCaptchaValidator getImageCaptchaValidator();

    /**
     * 获取验证码生成器
     *
     * @return SliderCaptchaTemplate
     */
    ImageCaptchaGenerator getImageCaptchaGenerator();

    /**
     * 获取缓存存储器
     *
     * @return CacheStore
     */
    CacheStore getCacheStore();

}
