package lpt.interceptor;

import lpt.application.vo.CaptchaResponse;
import lpt.application.vo.ImageCaptchaVO;
import lpt.common.AnyMap;
import lpt.common.response.ApiResponse;
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

    default CaptchaResponse<ImageCaptchaVO> beforeGenerateCaptcha(Context context, String type, GenerateParam param) {
        return null;
    }

    default CaptchaResponse<ImageCaptchaVO> beforeGenerateImageCaptchaValidData(Context context, String type, ImageCaptchaInfo imageCaptchaInfo) {
        return null;
    }

    default void afterGenerateImageCaptchaValidData(Context context, String type, ImageCaptchaInfo imageCaptchaInfo, AnyMap validData) {
    }

    default void afterGenerateCaptcha(Context context, String type, ImageCaptchaInfo imageCaptchaInfo, CaptchaResponse<ImageCaptchaVO> captchaResponse) {
    }

    default ApiResponse<?> beforeValid(Context context, String type, MatchParam matchParam, AnyMap validData) {
        Object preReturn = context.getPreReturnData();
        if (preReturn != null) {
            return (ApiResponse<?>) preReturn;
        }
        return ApiResponse.ofSuccess();
    }

    default ApiResponse<?> afterValid(Context context, String type, MatchParam matchParam, AnyMap validData, ApiResponse<?> basicValid) {
        Object preReturn = context.getPreReturnData();
        if (preReturn != null) {
            return (ApiResponse<?>) preReturn;
        }
        return ApiResponse.ofSuccess();
    }

    default ImageCaptchaInfo beforeGenerateCaptchaImage(Context context, CaptchaExchange captchaExchange, AbstractImageCaptchaGenerator generator) {
        return null;
    }

    default void beforeWrapImageCaptchaInfo(Context context, CaptchaExchange captchaExchange, AbstractImageCaptchaGenerator generator) {

    }

    default void afterGenerateCaptchaImage(Context context, CaptchaExchange captchaExchange, ImageCaptchaInfo imageCaptchaInfo, AbstractImageCaptchaGenerator generator) {

    }
}
