package lpt.resource.impl.provider;

import lpt.resource.AbstractResourceProvider;
import lpt.resource.common.model.dto.Resource;

import java.io.InputStream;

/**
 * @Author: 天爱有情
 * @date 2021/8/7 16:07
 * @Description classPath
 */
public class ClassPathResourceProvider extends AbstractResourceProvider {

    public static final String NAME = "classpath";

    @Override
    public InputStream doGetResourceInputStream(Resource data) {
        return getClassLoader().getResourceAsStream(data.getData());
    }

    @Override
    public boolean supported(String type) {
        return NAME.equalsIgnoreCase(type);
    }

    @Override
    public String getName() {
        return NAME;
    }

    private static ClassLoader getClassLoader() {
        ClassLoader classLoader = Thread.currentThread().getContextClassLoader();
        if (classLoader == null) {
            classLoader = ClassPathResourceProvider.getClassLoader();
        }
        if (classLoader == null) {
            classLoader = ClassLoader.getSystemClassLoader();
        }
        return classLoader;
    }
}
