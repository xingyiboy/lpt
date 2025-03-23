package com.ruoyi.system.domain.lpt.Enum;

public enum ValidationTypeEunm {
    CHARACTER_CHECK(0, "字符校验"),
    CALCULATION_CHECK(1, "计算校验"),
    EMAIL_CHECK(2, "邮件校验"),
    SLIDING_CHECK(3, "滑动校验"),
    ROTATION_CHECK(4, "旋转校验"),
    CLICK_CHECK(5, "点击校验"),
    SLIDING_RESTORE_CHECK(6, "滑动还原校验"),
    FACE_CHECK(7, "人脸校验");

    private final int code;
    private final String description;

    ValidationTypeEunm(int code, String description) {
        this.code = code;
        this.description = description;
    }

    public int getCode() {
        return code;
    }

    public String getDescription() {
        return description;
    }

    @Override
    public String toString() {
        return "ValidationTypeEunm{" +
                "code=" + code +
                ", description='" + description + '\'' +
                '}';
    }

    // 根据code值获取对应的枚举项
    public static ValidationTypeEunm fromCode(int code) {
        for (ValidationTypeEunm type : ValidationTypeEunm.values()) {
            if (type.getCode() == code) {
                return type;
            }
        }
        throw new IllegalArgumentException("Invalid code: " + code);
    }
}
