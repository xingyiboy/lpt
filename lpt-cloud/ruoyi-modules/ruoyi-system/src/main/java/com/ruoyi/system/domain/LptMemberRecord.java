package com.ruoyi.system.domain;

import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;
import com.ruoyi.common.core.annotation.Excel;
import com.ruoyi.common.core.web.domain.BaseEntity;

/**
 * 会员登录记录对象 lpt_member_record
 * 
 * @author ruoyi
 * @date 2025-03-24
 */
public class LptMemberRecord extends BaseEntity
{
    private static final long serialVersionUID = 1L;

    /** 编号 */
    private Long id;

    /** 会员编号 */
    @Excel(name = "会员编号")
    private Long memberId;

    /** 用户编号 */
    @Excel(name = "用户编号")
    private Long userId;

    /** 登录IP */
    @Excel(name = "登录IP")
    private String loginIp;

    /** 登录设备 */
    @Excel(name = "登录设备")
    private String decive;

    /** 经度 */
    @Excel(name = "经度")
    private Double latitude;

    /** 纬度 */
    @Excel(name = "纬度")
    private Double longitude;

    public void setId(Long id) 
    {
        this.id = id;
    }

    public Long getId() 
    {
        return id;
    }
    public void setMemberId(Long memberId) 
    {
        this.memberId = memberId;
    }

    public Long getMemberId() 
    {
        return memberId;
    }
    public void setUserId(Long userId) 
    {
        this.userId = userId;
    }

    public Long getUserId() 
    {
        return userId;
    }
    public void setLoginIp(String loginIp) 
    {
        this.loginIp = loginIp;
    }

    public String getLoginIp() 
    {
        return loginIp;
    }
    public void setDecive(String decive) 
    {
        this.decive = decive;
    }

    public String getDecive() 
    {
        return decive;
    }
    public void setLatitude(Double latitude) 
    {
        this.latitude = latitude;
    }

    public Double getLatitude() 
    {
        return latitude;
    }
    public void setLongitude(Double longitude) 
    {
        this.longitude = longitude;
    }

    public Double getLongitude() 
    {
        return longitude;
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
            .append("memberId", getMemberId())
            .append("userId", getUserId())
            .append("loginIp", getLoginIp())
            .append("decive", getDecive())
            .append("latitude", getLatitude())
            .append("longitude", getLongitude())
            .toString();
    }
}
