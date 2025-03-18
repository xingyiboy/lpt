package lpt.interceptor;

import lpt.application.vo.LptCaptchaResponse;
import lpt.application.vo.LptImageCaptchaVO;
import lpt.common.AnyMap;
import lpt.common.response.LptApiResponse;
import lpt.generator.AbstractImageCaptchaGenerator;
import lpt.generator.common.model.dto.CaptchaExchange;
import lpt.generator.common.model.dto.GenerateParam;
import lpt.generator.common.model.dto.ImageCaptchaInfo;
import lpt.validator.common.model.dto.MatchParam;

// ============================ 拦截器执行顺序 ============================

//  =================== 生成验证码 ===================
//          beforeGenerateCaptcha(...) ↓
//          beforeGenerateCaptchaImage(...) ↓
//          beforeWrapImageCaptchaInfo(...) ↓
//          afterGenerateCaptchaImage(...) ↓
//          beforeGenerateImageCaptchaValidData(...) ↓
//          afterGenerateImageCaptchaValidData(...) ↓
//          afterGenerateCaptcha(...) ↓
//  =================== 验证码校验 ===================
//          beforeValid(...) ↓
//          afterValid(...) ↓

// ============================ 拦截器执行顺序 ============================

/**
 * @Author: 天爱有情
 * @date 2024/7/11 18:05
 * @Description 验证码拦截器
 */
public interface CaptchaInterceptor {

    default String getName() {
        return "interceptor";
    }

    default Context createContext() {
        return new Context(getName(), null, -1, 1, EmptyCaptchaInterceptor.INSTANCE);
    }

    default LptCaptchaResponse<LptImageCaptchaVO> beforeGenerateCaptcha(Context context, String type, GenerateParam param) {
        return null;
    }

    default LptCaptchaResponse<LptImageCaptchaVO> beforeGenerateImageCaptchaValidData(Context context, String type, ImageCaptchaInfo imageCaptchaInfo) {
        return null;
    }

    default void afterGenerateImageCaptchaValidData(Context context, String type, ImageCaptchaInfo imageCaptchaInfo, AnyMap validData) {
    }

    default void afterGenerateCaptcha(Context context, String type, ImageCaptchaInfo imageCaptchaInfo, LptCaptchaResponse<LptImageCaptchaVO> lptCaptchaResponse) {
    }

    default LptApiResponse<?> beforeValid(Context context, String type, MatchParam matchParam, AnyMap validData) {
        Object preReturn = context.getPreReturnData();
        if (preReturn != null) {
            return (LptApiResponse<?>) preReturn;
        }
        return LptApiResponse.ofSuccess();
    }

    default LptApiResponse<?> afterValid(Context context, String type, MatchParam matchParam, AnyMap validData, LptApiResponse<?> basicValid) {
        Object preReturn = context.getPreReturnData();
        if (preReturn != null) {
            return (LptApiResponse<?>) preReturn;
        }
        return LptApiResponse.ofSuccess();
    }

    default ImageCaptchaInfo beforeGenerateCaptchaImage(Context context, CaptchaExchange captchaExchange, AbstractImageCaptchaGenerator generator) {
        return null;
    }

    default void beforeWrapImageCaptchaInfo(Context context, CaptchaExchange captchaExchange, AbstractImageCaptchaGenerator generator) {

    }

    default void afterGenerateCaptchaImage(Context context, CaptchaExchange captchaExchange, ImageCaptchaInfo imageCaptchaInfo, AbstractImageCaptchaGenerator generator) {

    }
}
