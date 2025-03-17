package lpt.resource.common.model.dto;

import lombok.Data;
import lombok.NoArgsConstructor;
import lpt.common.util.UUIDUtils;
import lpt.resource.ResourceProvider;

/**
 * @Author: 天爱有情
 * @date 2021/8/7 15:15
 * @Description 资源对象
 */
@Data
@NoArgsConstructor
public class Resource {
    /** 唯一ID. */
    private String id;
    /** 类型. */
    private String type;
    /** 数据,传输给 {@link ResourceProvider} 的参数 */
    public String data;
    /** 标签. */
    private String tag;
    /** 提示. */
    private String tip;
    /** 扩展. */
    private Object extra;

    public Resource(String type, String data) {
        this(type, data, null);
    }

    public Resource(String type, String data, String tag) {
        this(type, data, tag, null);
    }

    public Resource(String type, String data, String tag, String tip) {
        this(UUIDUtils.getUUID(), type, data, tag, tip);
    }

    public Resource(String id, String type, String data, String tag, String tip) {
        this.id = id;
        this.type = type;
        this.data = data;
        this.tag = tag;
        this.tip = tip;
    }

}
