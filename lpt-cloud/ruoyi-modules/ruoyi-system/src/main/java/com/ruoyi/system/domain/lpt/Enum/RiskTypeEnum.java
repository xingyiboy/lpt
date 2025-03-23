package com.ruoyi.system.domain.lpt.Enum;

public enum RiskTypeEnum {
    LOW(0, "低风险"),
    MEDIUM(1, "中风险"),
    HIGH(2, "高风险");

    private final int code;
    private final String description;

    // 构造方法
    RiskTypeEnum(int code, String description) {
        this.code = code;
        this.description = description;
    }

    // 获取风险级别的代码
    public int getCode() {
        return code;
    }

    // 获取风险级别的描述
    public String getDescription() {
        return description;
    }

    // 根据代码获取对应的枚举类型
    public static RiskTypeEnum fromCode(int code) {
        for (RiskTypeEnum level : RiskTypeEnum.values()) {
            if (level.getCode() == code) {
                return level;
            }
        }
        throw new IllegalArgumentException("未知的风险级别代码: " + code);
    }

    // 示例主方法
    public static void main(String[] args) {
        RiskTypeEnum lowRisk = RiskTypeEnum.LOW;
        System.out.println("代码: " + lowRisk.getCode() + ", 描述: " + lowRisk.getDescription());

        // 通过代码获取枚举
        RiskTypeEnum levelFromCode = RiskTypeEnum.fromCode(1);
        System.out.println("通过代码 1 获取的风险级别: " + levelFromCode.getDescription());
    }
}
