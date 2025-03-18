package lpt.common.response;

import lombok.Data;

import java.io.Serializable;

/**
 * @Author: 天爱有情
 * @date 2023/4/20 9:53
 * @Description 可能是最好用的API统一返回格式类
 */
@Data
@SuppressWarnings({"unchecked", "rawtypes"})
public class LptApiResponse<T> implements Serializable {

    public static final LptApiResponse<?> SUCCESS;

    static {
        CodeDefinition definition = ApiResponseStatusConstant.SUCCESS;
        SUCCESS = new LptApiResponse(definition.getCode(), definition.getMessage(), null);
    }

    /**
     * code码.
     */
    private Integer code;
    /**
     * 信息.
     */
    private String msg;
    /**
     * 成功时返回的数据.
     */
    private T data;

    public LptApiResponse(Integer code, String errMsg, T data) {
        this.code = code;
        this.msg = errMsg;
        this.data = data;
    }

    public LptApiResponse(CodeDefinition definition, T data) {
        this.code = definition.getCode();
        this.msg = definition.getMessage();
        this.data = data;
    }

    public LptApiResponse() {
        CodeDefinition definition = ApiResponseStatusConstant.SUCCESS;
        this.code = definition.getCode();
        this.msg = definition.getMessage();
    }

    public <R> LptApiResponse<R> convert() {
        LptApiResponse<R> result = new LptApiResponse<>();
        result.setCode(this.getCode());
        result.setMsg(this.getMsg());
        return result;
    }


    public boolean isSuccess() {
        return ApiResponseStatusConstant.SUCCESS.getCode().equals(getCode());
    }

    public static <T> LptApiResponse<T> of(Integer code, String msg, T data) {
        return new LptApiResponse(code, msg, data);
    }

    public static <T> LptApiResponse<T> of(CodeDefinition definition, T data) {
        return new LptApiResponse(definition.getCode(), definition.getMessage(), data);
    }

    public static <T> LptApiResponse<T> ofMessage(CodeDefinition definition) {
        return new LptApiResponse(definition.getCode(), definition.getMessage(), null);
    }

    public static <T> LptApiResponse<T> ofError(String message) {
        return new LptApiResponse(ApiResponseStatusConstant.INTERNAL_SERVER_ERROR.getCode(), message, null);
    }

    public static <T> LptApiResponse<T> ofError(String message, Object obj) {
        return new LptApiResponse(ApiResponseStatusConstant.INTERNAL_SERVER_ERROR.getCode(), message, obj);
    }

    public static <T> LptApiResponse<T> ofCheckError(String message) {
        return new LptApiResponse(ApiResponseStatusConstant.NOT_VALID_PARAM.getCode(), message, null);
    }

    public static <T> LptApiResponse<T> ofSuccess(T data) {
        CodeDefinition definition = ApiResponseStatusConstant.SUCCESS;
        return new LptApiResponse(definition.getCode(), definition.getMessage(), data);
    }

    public static <T> LptApiResponse<T> ofSuccess() {
        return (LptApiResponse<T>) SUCCESS;
    }

}
