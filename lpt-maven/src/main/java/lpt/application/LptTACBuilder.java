package lpt.application;

import lpt.LptIpVerification;
import lpt.cache.CacheStore;
import lpt.cache.impl.LocalCacheStore;
import lpt.common.util.CollectionUtils;
import lpt.generator.ImageCaptchaGenerator;
import lpt.generator.ImageTransform;
import lpt.generator.common.FontWrapper;
import lpt.generator.impl.MultiImageCaptchaGenerator;
import lpt.interceptor.CaptchaInterceptor;
import lpt.interceptor.EmptyCaptchaInterceptor;
import lpt.resource.DefaultBuiltInResources;
import lpt.resource.ResourceStore;
import lpt.resource.common.model.dto.Resource;
import lpt.resource.common.model.dto.ResourceMap;
import lpt.resource.impl.DefaultImageCaptchaResourceManager;
import lpt.resource.impl.LocalMemoryResourceStore;
import lpt.resource.impl.provider.ClassPathResourceProvider;
import lpt.validator.ImageCaptchaValidator;
import lpt.validator.impl.SimpleImageCaptchaValidator;

import java.awt.*;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.List;

/**
 * @Author: 天爱有情
 * @date 2024/7/14 16:41
 * @Description 一个构建ImageCaptchaApplication的工具, 免去一些繁琐的配置，方便新手用户一键使用
 */
public class LptTACBuilder {

    private CacheStore cacheStore;
    private ImageCaptchaGenerator generator;
    private ImageCaptchaValidator validator;
    private CaptchaInterceptor interceptor = EmptyCaptchaInterceptor.INSTANCE;
    private ImageCaptchaProperties prop = new ImageCaptchaProperties();
    private ResourceStore resourceStore;
    private ImageTransform imageTransform;
    private List<FontWrapper> fontWrappers = new ArrayList<>();

    public static LptTACBuilder builder() throws Exception {
        LptIpVerification.isIp();
        LptTACBuilder builder = new LptTACBuilder();
        // 默认设置本地的
        LocalMemoryResourceStore resourceStore = new LocalMemoryResourceStore();
        builder.resourceStore = resourceStore;
        builder.prop = new ImageCaptchaProperties();
        return builder;
    }

    private LptTACBuilder() {
    }

    public LptTACBuilder addDefaultTemplate(String defaultPathPrefix) {
        DefaultBuiltInResources defaultBuiltInResources = new DefaultBuiltInResources(defaultPathPrefix);
        defaultBuiltInResources.addDefaultTemplate(resourceStore);
        return this;
    }

    public LptTACBuilder addDefaultTemplate() {
        return addDefaultTemplate(DefaultBuiltInResources.PATH_PREFIX);
    }

    public LptTACBuilder setCacheStore(CacheStore cacheStore) {
        this.cacheStore = cacheStore;
        return this;
    }

    public LptTACBuilder setGenerator(ImageCaptchaGenerator generator) {
        this.generator = generator;
        return this;
    }

    public LptTACBuilder setValidator(ImageCaptchaValidator validator) {
        this.validator = validator;
        return this;
    }

    public LptTACBuilder setInterceptor(CaptchaInterceptor interceptor) {
        this.interceptor = interceptor;
        return this;
    }

    public LptTACBuilder addFont(FontWrapper fontWrapper) {
        this.fontWrappers.add(fontWrapper);
        return this;
    }

    public LptTACBuilder addFont(Font font) {
        return addFont(new FontWrapper(font));
    }


    public LptTACBuilder cached(int size, int waitTime, int period, Long expireTime) {
        prop.setLocalCacheEnabled(true);
        prop.setLocalCacheSize(size);
        prop.setLocalCacheWaitTime(waitTime);
        prop.setLocalCachePeriod(period);
        prop.setLocalCacheExpireTime(expireTime);
        return this;
    }

    public LptTACBuilder prefix(String prefix) {
        this.prop.setPrefix(prefix);
        return this;
    }

    public LptTACBuilder expire(String captchaType, Long expireTime) {
        prop.getExpire().put(captchaType, expireTime);
        return this;
    }

    public LptTACBuilder setProp(ImageCaptchaProperties prop) {
        this.prop = prop;
        return this;
    }

    public LptTACBuilder setResourceStore(ResourceStore resourceStore) {
        this.resourceStore = resourceStore;
        return this;
    }


    public LptTACBuilder addResource(String captchaType, Resource imageResource) {
        this.resourceStore.addResource(captchaType, imageResource);
        return this;
    }

    public LptTACBuilder addTemplate(String captchaType, ResourceMap resourceMap) {
        this.resourceStore.addTemplate(captchaType, resourceMap);
        return this;
    }

    public LptTACBuilder setTransform(ImageTransform imageTransform) {
        this.imageTransform = imageTransform;
        return this;
    }

    public LptImageCaptchaApplication build() {
        if (cacheStore == null) {
            cacheStore = new LocalCacheStore();
        }
        if (generator == null) {
            DefaultImageCaptchaResourceManager resourceManager = new DefaultImageCaptchaResourceManager(resourceStore);
            generator = new MultiImageCaptchaGenerator(resourceManager, imageTransform);
        }
        if (generator instanceof MultiImageCaptchaGenerator) {
            if (CollectionUtils.isEmpty(fontWrappers)) {
                // 添加默认字体
                try {
                    ClassPathResourceProvider resourceProvider = new ClassPathResourceProvider();
                    InputStream stream = resourceProvider.getResourceInputStream(new Resource("classpath", "META-INF/fonts/SIMSUN.TTC"));
                    Font font = Font.createFont(Font.TRUETYPE_FONT, stream);
                    stream.close();
                    fontWrappers.add(new FontWrapper(font));
                } catch (Exception e) {
                    throw new RuntimeException("读取默认字体包报错",e);
                }
            }
            ((MultiImageCaptchaGenerator) generator).setFontWrappers(fontWrappers);
        }
        if (validator == null) {
            validator = new SimpleImageCaptchaValidator();
        }
        if (interceptor == null) {
            interceptor = EmptyCaptchaInterceptor.INSTANCE;
        }

        DefaultImageCaptchaApplication application = new DefaultImageCaptchaApplication(generator, validator, cacheStore, prop, interceptor);
        return application;
    }
}
