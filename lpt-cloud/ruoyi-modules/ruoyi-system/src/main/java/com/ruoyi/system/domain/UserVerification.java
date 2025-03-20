package com.ruoyi.system.domain;

import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;
import com.ruoyi.common.core.annotation.Excel;
import com.ruoyi.common.core.web.domain.BaseEntity;

/**
 * 用户验证模式对象 user_verification
 * 
 * @author ruoyi
 * @date 2025-03-14
 */
public class UserVerification extends BaseEntity
{
    private static final long serialVersionUID = 1L;

    /** 编号 */
    private Long id;

    /** 用户编号 */
    @Excel(name = "用户编号")
    private Long userId;

    /** 风险类型 */
    @Excel(name = "风险类型")
    private Integer riskType;

    /** 验证类型编号 */
    @Excel(name = "验证类型编号")
    private Integer verificationId;

    /** 排序 */
    @Excel(name = "排序")
    private Integer sort;

    public void setId(Long id) 
    {
        this.id = id;
    }

    public Long getId() 
    {
        return id;
    }
    public void setUserId(Long userId) 
    {
        this.userId = userId;
    }

    public Long getUserId() 
    {
        return userId;
    }
    public void setRiskType(Integer riskType) 
    {
        this.riskType = riskType;
    }

    public Integer getRiskType() 
    {
        return riskType;
    }
    public void setVerificationId(Integer verificationId) 
    {
        this.verificationId = verificationId;
    }

    public Integer getVerificationId() 
    {
        return verificationId;
    }
    public void setSort(Integer sort) 
    {
        this.sort = sort;
    }

    public Integer getSort() 
    {
        return sort;
    }

    @Override
    public String toString() {
        return new ToStringBuilder(this,ToStringStyle.MULTI_LINE_STYLE)
            .append("id", getId())
            .append("createBy", getCreateBy())
            .append("createTime", getCreateTime())
            .append("updateBy", getUpdateBy())
            .append("updateTime", getUpdateTime())
            .append("remark", getRemark())
            .append("userId", getUserId())
            .append("riskType", getRiskType())
            .append("verificationId", getVerificationId())
            .append("sort", getSort())
            .toString();
    }
}
