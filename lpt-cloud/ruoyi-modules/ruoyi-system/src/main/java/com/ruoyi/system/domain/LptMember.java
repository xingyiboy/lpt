package com.ruoyi.system.domain;

import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;
import com.ruoyi.common.core.annotation.Excel;
import com.ruoyi.common.core.web.domain.BaseEntity;

/**
 * 成员对象 lpt_member
 *
 * @author xingyi
 * @date 2025-03-14
 */
public class LptMember extends BaseEntity
{
    private static final long serialVersionUID = 1L;

    /** 编号 */
    private Long id;

    /** 用户编号 */
    @Excel(name = "用户编号")
    private Long userId;

    /** 用户名 */
    @Excel(name = "用户名")
    private String username;

    /** 密码 */
    @Excel(name = "密码")
    private String password;

    /** 盐值 */
    @Excel(name = "盐值")
    private String salt;

    /** 是否放通 */
    @Excel(name = "是否放通")
    private Integer isRelease;

    /** 邮箱 */
    @Excel(name = "邮箱")
    private String mailbox;

    /** 用户登录IP */
    @Excel(name = "用户登录IP")
    private String loginIp;

    /** 登录设备 */
    @Excel(name = "登录设备")
    private String facility;

    /** 风险因子 */
    @Excel(name = "风险因子")
    private Long riskNumber;

    /** 人脸图片Base64 */
    @Excel(name = "人脸图片Base64")
    private String faceBase64;

    public String getFaceBase64() {
        return faceBase64;
    }

    public void setFaceBase64(String faceBase64) {
        this.faceBase64 = faceBase64;
    }

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
    public void setUsername(String username)
    {
        this.username = username;
    }

    public String getUsername()
    {
        return username;
    }
    public void setPassword(String password)
    {
        this.password = password;
    }

    public String getPassword()
    {
        return password;
    }
    public void setSalt(String salt)
    {
        this.salt = salt;
    }

    public String getSalt()
    {
        return salt;
    }
    public void setIsRelease(Integer isRelease)
    {
        this.isRelease = isRelease;
    }

    public Integer getIsRelease()
    {
        return isRelease;
    }
    public void setMailbox(String mailbox)
    {
        this.mailbox = mailbox;
    }

    public String getMailbox()
    {
        return mailbox;
    }
    public void setLoginIp(String loginIp)
    {
        this.loginIp = loginIp;
    }

    public String getLoginIp()
    {
        return loginIp;
    }
    public void setFacility(String facility)
    {
        this.facility = facility;
    }

    public String getFacility()
    {
        return facility;
    }
    public void setRiskNumber(Long riskNumber)
    {
        this.riskNumber = riskNumber;
    }

    public Long getRiskNumber()
    {
        return riskNumber;
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
            .append("username", getUsername())
            .append("password", getPassword())
            .append("salt", getSalt())
            .append("isRelease", getIsRelease())
            .append("mailbox", getMailbox())
            .append("loginIp", getLoginIp())
            .append("facility", getFacility())
            .append("riskNumber", getRiskNumber())
            .toString();
    }
}
