package com.ruoyi.framework.web.Enum;

public enum VerificationTypeEnum {
    PASSWORD_VALIDATION(0, "密码校验"),
    CHARACTER_VALIDATION(1, "字符校验"),
    CALCULATION_VALIDATION(2, "计算校验"),
    EMAIL_VALIDATION(3, "邮箱校验"),
    SLIDING_VALIDATION(4, "滑动校验"),
    ROTATION_VALIDATION(5, "旋转校验"),
    CLICK_VALIDATION(6, "点击校验"),
    CONCAT_VALIDATION(7, "滑动还原校验");



    private final int code;
    private final String description;

    // 构造方法
    VerificationTypeEnum(int code, String description) {
        this.code = code;
        this.description = description;
    }

    // 获取code
    public int getCode() {
        return code;
    }

    // 获取描述
    public String getDescription() {
        return description;
    }

    // 根据code获取VerificationType
    public static VerificationTypeEnum fromCode(int code) {
        for (VerificationTypeEnum type : VerificationTypeEnum.values()) {
            if (type.getCode() == code) {
                return type;
            }
        }
        throw new IllegalArgumentException("Invalid code: " + code);
    }
}
