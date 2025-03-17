package lpt.generator;

import lpt.generator.common.model.dto.CustomData;
import lpt.generator.common.model.dto.GenerateParam;
import lpt.generator.common.model.dto.ImageTransformData;
import lpt.resource.common.model.dto.Resource;

import java.awt.image.BufferedImage;

/**
 * @Author: 天爱有情
 * @date 2022/8/25 10:21
 * @Description 图片转换为字符串， 扩展接口, 可以转换为文件地址等
 */
public interface ImageTransform {

    /**
     * 转换
     *
     * @param backgroundImage    背景图片
     * @param param              参数
     * @param backgroundResource 背景资源对象
     * @param data               自定义透传数据
     * @return ImageTransformData
     */
    default ImageTransformData transform(GenerateParam param, BufferedImage backgroundImage, Resource backgroundResource, CustomData data) {
        return transform(param, backgroundImage, null, backgroundResource, null, data);
    }

    /**
     * 转换
     *
     * @param backgroundImage    背景图片
     * @param templateImage      模板图片(可能为空)
     * @param param              参数
     * @param backgroundResource 背景资源对象
     * @param templateResource   模板资源对象(可能为空)
     * @param data               自定义透传数据
     * @return String
     */
    ImageTransformData transform(GenerateParam param,
                                 BufferedImage backgroundImage,
                                 BufferedImage templateImage,
                                 Object backgroundResource,
                                 Object templateResource,
                                 CustomData data);
}
