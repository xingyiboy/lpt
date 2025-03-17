package lpt.application;

import lpt.application.vo.CaptchaResponse;
import lpt.application.vo.ImageCaptchaVO;
import lpt.cache.CacheStore;
import lpt.common.response.ApiResponse;
import lpt.generator.ImageCaptchaGenerator;
import lpt.generator.common.model.dto.GenerateParam;
import lpt.interceptor.CaptchaInterceptor;
import lpt.resource.ImageCaptchaResourceManager;
import lpt.validator.ImageCaptchaValidator;
import lpt.validator.common.model.dto.ImageCaptchaTrack;
import lpt.validator.common.model.dto.MatchParam;

/**
 * @Author: 天爱有情
 * @date 2022/3/2 14:22
 * @Description 用于SliderCaptchaApplication增加附属功能
 */
public class FilterImageCaptchaApplication implements ImageCaptchaApplication {


    protected ImageCaptchaApplication target;

    public FilterImageCaptchaApplication(ImageCaptchaApplication target) {
        this.target = target;
    }

    @Override
    public CaptchaResponse<ImageCaptchaVO> generateCaptcha() {
        return target.generateCaptcha();
    }

    @Override
    public CaptchaResponse<ImageCaptchaVO> generateCaptcha(String type) {
        return target.generateCaptcha(type);
    }

    @Override
    public CaptchaResponse<ImageCaptchaVO> generateCaptcha(CaptchaImageType captchaImageType) {
        return target.generateCaptcha(captchaImageType);
    }

    @Override
    public CaptchaResponse<ImageCaptchaVO> generateCaptcha(String type, CaptchaImageType captchaImageType) {
        return target.generateCaptcha(type, captchaImageType);
    }

    @Override
    public CaptchaResponse<ImageCaptchaVO> generateCaptcha(GenerateParam param) {
        return target.generateCaptcha(param);
    }

    @Override
    public ApiResponse<?> matching(String id, MatchParam matchParam) {
        return target.matching(id, matchParam);
    }

    @Override
    public ApiResponse<?> matching(String id, ImageCaptchaTrack track) {
        return target.matching(id, track);
    }

    @Override
    public boolean matching(String id, Float percentage) {
        return target.matching(id, percentage);
    }

    @Override
    public String getCaptchaTypeById(String id) {
        return target.getCaptchaTypeById(id);
    }

    @Override
    public ImageCaptchaResourceManager getImageCaptchaResourceManager() {
        return target.getImageCaptchaResourceManager();
    }

    @Override
    public void setImageCaptchaValidator(ImageCaptchaValidator sliderCaptchaValidator) {
        target.setImageCaptchaValidator(sliderCaptchaValidator);
    }

    @Override
    public void setImageCaptchaGenerator(ImageCaptchaGenerator imageCaptchaGenerator) {
        target.setImageCaptchaGenerator(imageCaptchaGenerator);
    }

    @Override
    public CaptchaInterceptor getCaptchaInterceptor() {
        return target.getCaptchaInterceptor();
    }

    @Override
    public void setCaptchaInterceptor(CaptchaInterceptor captchaInterceptor) {
        target.setCaptchaInterceptor(captchaInterceptor);
    }

    @Override
    public void setCacheStore(CacheStore cacheStore) {
        target.setCacheStore(cacheStore);
    }

    @Override
    public ImageCaptchaValidator getImageCaptchaValidator() {
        return target.getImageCaptchaValidator();
    }

    @Override
    public ImageCaptchaGenerator getImageCaptchaGenerator() {
        return target.getImageCaptchaGenerator();
    }

    @Override
    public CacheStore getCacheStore() {
        return target.getCacheStore();
    }
}
