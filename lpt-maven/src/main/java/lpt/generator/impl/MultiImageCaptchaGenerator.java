package lpt.generator.impl;

import lombok.Getter;
import lombok.Setter;
import lpt.common.constant.CaptchaTypeConstant;
import lpt.common.util.ObjectUtils;
import lpt.generator.AbstractImageCaptchaGenerator;
import lpt.generator.ImageCaptchaGenerator;
import lpt.generator.ImageCaptchaGeneratorProvider;
import lpt.generator.ImageTransform;
import lpt.generator.common.FontWrapper;
import lpt.generator.common.model.dto.CaptchaExchange;
import lpt.generator.common.model.dto.GenerateParam;
import lpt.generator.common.model.dto.ImageCaptchaInfo;
import lpt.generator.impl.provider.CommonImageCaptchaGeneratorProvider;
import lpt.resource.ImageCaptchaResourceManager;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;

/**
 * @Author: 天爱有情
 * @date 2022/4/24 9:27
 * @Description 根据type 匹配对应的验证码生成器
 */
public class MultiImageCaptchaGenerator extends AbstractImageCaptchaGenerator {

    protected Map<String, ImageCaptchaGenerator> imageCaptchaGeneratorMap = new ConcurrentHashMap<>(4);
    protected Map<String, ImageCaptchaGeneratorProvider> imageCaptchaGeneratorProviderMap = new HashMap<>(4);
    // 点选类验证码字体
    @Setter
    @Getter
    protected List<FontWrapper> fontWrappers;
    @Setter
    @Getter
    private String defaultCaptcha = CaptchaTypeConstant.SLIDER;

    public MultiImageCaptchaGenerator(ImageCaptchaResourceManager imageCaptchaResourceManager) {
        super(imageCaptchaResourceManager);
    }

    public MultiImageCaptchaGenerator(ImageCaptchaResourceManager imageCaptchaResourceManager, ImageTransform imageTransform) {
        super(imageCaptchaResourceManager);
        setImageTransform(imageTransform);
    }

    @Override
    protected void doInit() {
        // 滑块验证码
        addImageCaptchaGeneratorProvider(new CommonImageCaptchaGeneratorProvider(CaptchaTypeConstant.SLIDER, StandardSliderImageCaptchaGenerator::new));
        // 旋转验证码
        addImageCaptchaGeneratorProvider(new CommonImageCaptchaGeneratorProvider(CaptchaTypeConstant.ROTATE, StandardRotateImageCaptchaGenerator::new));
        // 拼接验证码
        addImageCaptchaGeneratorProvider(new CommonImageCaptchaGeneratorProvider(CaptchaTypeConstant.CONCAT, StandardConcatImageCaptchaGenerator::new));
        // 点选文字验证码
        addImageCaptchaGeneratorProvider(new CommonImageCaptchaGeneratorProvider(CaptchaTypeConstant.WORD_IMAGE_CLICK, (r, t, i) ->
                new StandardWordClickImageCaptchaGenerator(r, t, i, fontWrappers)));
    }

    public void addImageCaptchaGeneratorProvider(ImageCaptchaGeneratorProvider provider) {
        imageCaptchaGeneratorProviderMap.put(provider.getType(), provider);
    }

    public ImageCaptchaGeneratorProvider removeImageCaptchaGeneratorProvider(String type) {
        return imageCaptchaGeneratorProviderMap.remove(type);
    }

    public ImageCaptchaGeneratorProvider getImageCaptchaGeneratorProvider(String type) {
        return imageCaptchaGeneratorProviderMap.get(type);
    }

    public void addImageCaptchaGenerator(String key, ImageCaptchaGenerator captchaGenerator) {
        imageCaptchaGeneratorMap.put(key, captchaGenerator);
    }

    public ImageCaptchaGenerator removeImageCaptchaGenerator(String key) {
        return imageCaptchaGeneratorMap.remove(key);
    }

    public ImageCaptchaGenerator getImageCaptchaGenerator(String key) {
        return imageCaptchaGeneratorMap.get(key);
    }

    @Override
    public ImageCaptchaInfo generateCaptchaImage(GenerateParam param) {
        String type = param.getType();
        if (ObjectUtils.isEmpty(type)) {
            param.setType(defaultCaptcha);
            type = defaultCaptcha;
        }
        ImageCaptchaGenerator imageCaptchaGenerator = requireGetCaptchaGenerator(type);
        return imageCaptchaGenerator.generateCaptchaImage(param);
    }


    @Override
    protected void doGenerateCaptchaImage(CaptchaExchange captchaExchange) {

    }

    @Override
    protected ImageCaptchaInfo doWrapImageCaptchaInfo(CaptchaExchange captchaExchange) {
        return null;
    }

    public ImageCaptchaGenerator requireGetCaptchaGenerator(String type) {
        ImageCaptchaGenerator imageCaptchaGenerator = imageCaptchaGeneratorMap.computeIfAbsent(type, t -> {
            ImageCaptchaGeneratorProvider provider = imageCaptchaGeneratorProviderMap.get(t);
            if (provider == null) {
                throw new IllegalArgumentException("生成验证码失败，错误的type类型:" + t);
            }
            return provider.get(getImageResourceManager(), getImageTransform(), getInterceptor()).init();
        });
        return imageCaptchaGenerator;
    }

    @Override
    public void setImageResourceManager(ImageCaptchaResourceManager imageCaptchaResourceManager) {
        super.setImageResourceManager(imageCaptchaResourceManager);
        for (ImageCaptchaGenerator imageCaptchaGenerator : imageCaptchaGeneratorMap.values()) {
            imageCaptchaGenerator.setImageResourceManager(imageCaptchaResourceManager);
        }
    }

    @Override
    public void setImageTransform(ImageTransform imageTransform) {
        super.setImageTransform(imageTransform);
        for (ImageCaptchaGenerator imageCaptchaGenerator : imageCaptchaGeneratorMap.values()) {
            imageCaptchaGenerator.setImageTransform(imageTransform);
        }
    }
}
