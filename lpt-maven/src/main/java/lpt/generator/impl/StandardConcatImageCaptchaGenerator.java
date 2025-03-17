package lpt.generator.impl;

import lombok.SneakyThrows;
import lpt.common.constant.CaptchaTypeConstant;
import lpt.generator.AbstractImageCaptchaGenerator;
import lpt.generator.ImageTransform;
import lpt.generator.common.model.dto.*;
import lpt.generator.common.util.CaptchaImageUtils;
import lpt.interceptor.CaptchaInterceptor;
import lpt.resource.ImageCaptchaResourceManager;
import lpt.resource.common.model.dto.Resource;

import java.awt.image.BufferedImage;

/**
 * @Author: 天爱有情
 * @date 2022/4/25 15:44
 * @Description 图片拼接滑动验证码生成器
 */
public class StandardConcatImageCaptchaGenerator extends AbstractImageCaptchaGenerator {

    public StandardConcatImageCaptchaGenerator(ImageCaptchaResourceManager imageCaptchaResourceManager) {
        super(imageCaptchaResourceManager);
    }

    public StandardConcatImageCaptchaGenerator(ImageCaptchaResourceManager imageCaptchaResourceManager, ImageTransform imageTransform) {
        super(imageCaptchaResourceManager);
        setImageTransform(imageTransform);
    }

    public StandardConcatImageCaptchaGenerator(ImageCaptchaResourceManager imageCaptchaResourceManager, ImageTransform imageTransform, CaptchaInterceptor interceptor) {
        super(imageCaptchaResourceManager);
        setImageTransform(imageTransform);
        setInterceptor(interceptor);
    }

    @Override
    protected void doInit() {
    }


    @Override
    public void doGenerateCaptchaImage(CaptchaExchange captchaExchange) {
        GenerateParam param = captchaExchange.getParam();
        // 拼接验证码不需要模板 只需要背景图
        Resource resourceImage = requiredRandomGetResource(param.getType(), param.getBackgroundImageTag());
        BufferedImage bgImage = getResourceImage(resourceImage);
        int spacingY = bgImage.getHeight() / 4;
        int randomY = randomInt(spacingY, bgImage.getHeight() - spacingY);
        BufferedImage[] bgImageSplit = CaptchaImageUtils.splitImage(randomY, true, bgImage);
        int spacingX = bgImage.getWidth() / 8;
        int randomX = randomInt(spacingX, bgImage.getWidth() - bgImage.getWidth() / 5);
        BufferedImage[] bgImageTopSplit = CaptchaImageUtils.splitImage(randomX, false, bgImageSplit[0]);

        BufferedImage sliderImage = CaptchaImageUtils.concatImage(true,
                bgImageTopSplit[0].getWidth()
                        + bgImageTopSplit[1].getWidth(), bgImageTopSplit[0].getHeight(), bgImageTopSplit[1], bgImageTopSplit[0]);
        bgImage = CaptchaImageUtils.concatImage(false, bgImageSplit[1].getWidth(), sliderImage.getHeight() + bgImageSplit[1].getHeight(),
                sliderImage, bgImageSplit[1]);
        Data data = new Data();
        data.x = randomX;
        data.y = randomY;

        captchaExchange.setTransferData(data);
        captchaExchange.setBackgroundImage(bgImage);
        captchaExchange.setResourceImage(resourceImage);
    }

    public static class Data {
        int x;
        int y;
    }

    @SneakyThrows
    @Override
    public ImageCaptchaInfo doWrapImageCaptchaInfo(CaptchaExchange captchaExchange) {
        GenerateParam param = captchaExchange.getParam();
        BufferedImage bgImage = captchaExchange.getBackgroundImage();
        Resource resourceImage = captchaExchange.getResourceImage();
        CustomData customData = captchaExchange.getCustomData();
        ImageTransformData transform = getImageTransform().transform(param, bgImage, resourceImage, customData);
        Data data = (Data) captchaExchange.getTransferData();
        ImageCaptchaInfo imageCaptchaInfo = ImageCaptchaInfo.of(transform.getBackgroundImageUrl(),
                null,
                resourceImage.getTag(),
                null,
                bgImage.getWidth(),
                bgImage.getHeight(),
                null,
                null,
                data.x,
                CaptchaTypeConstant.CONCAT);
        customData.putViewData("randomY", data.y);
        imageCaptchaInfo.setTolerant(0.05F);
        return imageCaptchaInfo;
    }
}
