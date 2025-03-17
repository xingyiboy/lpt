package lpt.resource.impl.provider;

import lombok.SneakyThrows;
import lpt.resource.AbstractResourceProvider;
import lpt.resource.common.model.dto.Resource;

import java.io.FileInputStream;
import java.io.InputStream;

/**
 * @Author: 天爱有情
 * @date 2022/2/21 14:43
 * @Description file
 */
public class FileResourceProvider extends AbstractResourceProvider {

    public static final String NAME = "file";

    @SneakyThrows
    @Override
    public InputStream doGetResourceInputStream(Resource data) {
        FileInputStream fileInputStream = new FileInputStream(data.getData());
        return fileInputStream;
    }

    @Override
    public boolean supported(Resource resource) {
        return NAME.equalsIgnoreCase(resource.getType());
    }

    @Override
    public String getName() {
        return NAME;
    }
}
