package lpt.resource;

import lpt.resource.common.model.dto.Resource;

import java.io.InputStream;

/**
 * @Author: 天爱有情
 * @date 2021/8/7 15:07
 * @Description 资源提供者
 */
public interface ResourceProvider {

    /**
     * 获取资源
     *
     * @param data data
     * @return InputStream
     */
    InputStream getResourceInputStream(Resource data);

    /**
     * 是否支持
     *
     * @param resource resource
     * @return boolean
     */
    boolean supported(Resource resource);

    /**
     * 放弃资源提供者名称
     *
     * @return String
     */
    String getName();
}
