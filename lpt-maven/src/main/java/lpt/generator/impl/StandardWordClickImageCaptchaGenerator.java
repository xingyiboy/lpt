package lpt.generator.impl;

import lombok.Getter;
import lombok.Setter;
import lpt.common.constant.CaptchaTypeConstant;
import lpt.common.exception.ImageCaptchaException;
import lpt.common.util.CollectionUtils;
import lpt.common.util.FontUtils;
import lpt.generator.ImageTransform;
import lpt.generator.common.FontWrapper;
import lpt.generator.common.model.dto.*;
import lpt.generator.common.util.CaptchaImageUtils;
import lpt.interceptor.CaptchaInterceptor;
import lpt.resource.ImageCaptchaResourceManager;
import lpt.resource.common.model.dto.Resource;

import java.awt.*;
import java.awt.image.BufferedImage;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;
import java.util.concurrent.ThreadLocalRandom;
import java.util.stream.Collectors;

/**
 * @Author: 天爱有情
 * @date 2022/4/27 11:46
 * @Description 点选验证码
 */
public class StandardWordClickImageCaptchaGenerator extends AbstractClickImageCaptchaGenerator {

    /** 字体包. */
    @Getter
    @Setter
    protected List<FontWrapper> fonts = new ArrayList<>();
    @Getter
    @Setter
    protected Integer clickImgWidth = 100;
    @Getter
    @Setter
    protected Integer clickImgHeight = 100;
    @Getter
    @Setter
    protected int tipImageInterferenceLineNum = 2;
    @Getter
    @Setter
    protected int tipImageInterferencePointNum = 5;
    /** 参与校验的数量. */
    @Getter
    @Setter
    protected Integer checkClickCount = 4;
    /** 干扰数量. */
    @Getter
    @Setter
    protected Integer interferenceCount = 2;

    /**
     * 因为在画文字图形的时候 y 值不能准确通过 除法计算得出， 字体大小不一致中间的容错值算不准确
     * 方案: 通过 线性回归模型 计算出  intercept和coef 用于计算 容错值
     * 训练数据为 宋体 字体大小为 30~150 随机选择7组数据进行训练， 训练后r2结果为 0.9967106324620846
     */
//    protected float intercept = 0.39583333f;
//    protected float coef = 0.14645833f;
//
//    protected float currentFontTopCoef = 0.0f;
    public StandardWordClickImageCaptchaGenerator(ImageCaptchaResourceManager imageCaptchaResourceManager) {
        super(imageCaptchaResourceManager);
    }

    public StandardWordClickImageCaptchaGenerator(ImageCaptchaResourceManager imageCaptchaResourceManager, ImageTransform imageTransform) {
        super(imageCaptchaResourceManager);
        setImageTransform(imageTransform);
    }


    public StandardWordClickImageCaptchaGenerator(ImageCaptchaResourceManager imageCaptchaResourceManager, ImageTransform imageTransform, CaptchaInterceptor interceptor) {
        super(imageCaptchaResourceManager);
        setImageTransform(imageTransform);
        setInterceptor(interceptor);
    }

    public StandardWordClickImageCaptchaGenerator(ImageCaptchaResourceManager imageCaptchaResourceManager, ImageTransform imageTransform, CaptchaInterceptor interceptor, List<FontWrapper> fonts) {
        super(imageCaptchaResourceManager);
        setImageTransform(imageTransform);
        setInterceptor(interceptor);
        this.fonts = fonts;
    }


    @Override
    protected List<Resource> randomGetClickImgTips(GenerateParam param) {
        int tipSize = interferenceCount + checkClickCount;
        ThreadLocalRandom random = ThreadLocalRandom.current();
        List<Resource> tipList = new ArrayList<>(tipSize);
        for (int i = 0; i < tipSize; i++) {
            String randomWord = FontUtils.getRandomChar(random);
            tipList.add(new Resource(null, randomWord));
        }
        // 随机文字
        return tipList;
    }

    @Override
    protected void doInit() {
        if (CollectionUtils.isEmpty(fonts)) {
            throw new ImageCaptchaException("初始化文字点选验证码失败，请设置字体包后再调用init()");
        }

    }

    public ImgWrapper genTipImage(List<ClickImageCheckDefinition> imageCheckDefinitions) {
        FontWrapper fontWrapper = fonts.get(randomInt(fonts.size()));
        Font font = fontWrapper.getFont();
        float currentFontTopCoef = fontWrapper.getCurrentFontTopCoef();
        String tips = imageCheckDefinitions.stream().map(c -> c.getTip().getData()).collect(Collectors.joining());
        // 生成随机颜色
        int fontWidth = tips.length() * font.getSize();
        int width = fontWidth + 6;
        int height = font.getSize() + 6;
        float left = (width - fontWidth) / 2f;
        float top = 6 / 2f + font.getSize() - currentFontTopCoef;
        BufferedImage bufferedImage = CaptchaImageUtils.genSimpleImgCaptcha(tips,
                font, width, height, left, top, tipImageInterferenceLineNum, tipImageInterferencePointNum);
        return new ImgWrapper(bufferedImage, new Resource(null, tips), null);
    }

    @Override
    public ImgWrapper getClickImg(Resource tip) {
        ThreadLocalRandom random = ThreadLocalRandom.current();
        // 随机颜色
        Color randomColor = CaptchaImageUtils.getRandomColor(random);
        // 随机角度
        int randomDeg = randomInt(0, 85);
        FontWrapper fontWrapper = fonts.get(randomInt(fonts.size()));
        Font font = fontWrapper.getFont();
        float currentFontTopCoef = fontWrapper.getCurrentFontTopCoef();
        BufferedImage fontImage = CaptchaImageUtils.drawWordImg(randomColor,
                tip.getData(),
                font,
                currentFontTopCoef,
                clickImgWidth,
                clickImgHeight,
                randomDeg);
        return new ImgWrapper(fontImage, tip, randomColor);
    }

    @Override
    protected List<ClickImageCheckDefinition> filterAndSortClickImageCheckDefinition(List<ClickImageCheckDefinition> allCheckDefinitionList) {
        // 打乱
        Collections.shuffle(allCheckDefinitionList);
        // 拿出参与校验的数据
        List<ClickImageCheckDefinition> checkClickImageCheckDefinitionList = new ArrayList<>(checkClickCount);
        for (int i = 0; i < checkClickCount; i++) {
            ClickImageCheckDefinition clickImageCheckDefinition = allCheckDefinitionList.get(i);
            checkClickImageCheckDefinitionList.add(clickImageCheckDefinition);
        }
        return checkClickImageCheckDefinitionList;
    }

    @Override
    public ImageCaptchaInfo doWrapImageCaptchaInfo(CaptchaExchange captchaExchange) {
        List<ClickImageCheckDefinition> checkClickImageCheckDefinitionList = (List<ClickImageCheckDefinition>) captchaExchange.getTransferData();
        BufferedImage bgImage = captchaExchange.getBackgroundImage();
        GenerateParam param = captchaExchange.getParam();
        Resource resourceImage = captchaExchange.getResourceImage();
        CustomData data = captchaExchange.getCustomData();
        // 提示图片
        BufferedImage tipImage = genTipImage(checkClickImageCheckDefinitionList).getImage();
        ImageTransformData transform = getImageTransform().transform(param, bgImage, tipImage, resourceImage, checkClickImageCheckDefinitionList, data);
        ImageCaptchaInfo clickImageCaptchaInfo = new ImageCaptchaInfo();
        clickImageCaptchaInfo.setBackgroundImage(transform.getBackgroundImageUrl());
        clickImageCaptchaInfo.setBackgroundImageTag(resourceImage.getTag());
        clickImageCaptchaInfo.setTemplateImage(transform.getTemplateImageUrl());
        clickImageCaptchaInfo.setBackgroundImageWidth(bgImage.getWidth());
        clickImageCaptchaInfo.setBackgroundImageHeight(bgImage.getHeight());
        clickImageCaptchaInfo.setTemplateImageWidth(tipImage.getWidth());
        clickImageCaptchaInfo.setTemplateImageHeight(tipImage.getHeight());
        clickImageCaptchaInfo.setRandomX(null);
        clickImageCaptchaInfo.setTolerant(null);
        clickImageCaptchaInfo.setType(CaptchaTypeConstant.WORD_IMAGE_CLICK);
        data.setExpand(checkClickImageCheckDefinitionList);
        return clickImageCaptchaInfo;
    }


}
