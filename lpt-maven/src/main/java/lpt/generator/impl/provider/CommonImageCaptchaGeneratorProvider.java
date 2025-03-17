package lpt.generator.impl.provider;

import lpt.generator.ImageCaptchaGenerator;
import lpt.generator.ImageCaptchaGeneratorProvider;
import lpt.generator.ImageTransform;
import lpt.interceptor.CaptchaInterceptor;
import lpt.resource.ImageCaptchaResourceManager;

public class CommonImageCaptchaGeneratorProvider implements ImageCaptchaGeneratorProvider {

    private String type;
    private ImageCaptchaGeneratorProvider provider;

    public CommonImageCaptchaGeneratorProvider(String type, ImageCaptchaGeneratorProvider provider) {
        this.type = type;
        this.provider = provider;

    }

    @Override
    public ImageCaptchaGenerator get(ImageCaptchaResourceManager resourceManager, ImageTransform imageTransform, CaptchaInterceptor interceptor) {
        return provider.get(resourceManager, imageTransform,interceptor);
    }

    @Override
    public String getType() {
        return type;
    }
}
