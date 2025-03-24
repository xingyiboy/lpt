package com.ruoyi.common.core.domain.model;


import lpt.validator.common.model.dto.LptImageCaptchaTrack;

/**
 * 用户登录对象
 *
 * @author ruoyi
 */
public class LoginBody
{
    /**
     * 用户名
     */
    private String username;

    /**
     * 系统用户id
     */
    private Long userId;

    /**
     * 用户密码
     */
    private String password;


    /**
     * 登录步骤
     */
    private Integer step;

    /**
     * uuid
     */
    private String uuid;

    /**
     * 校验id
     */
    private String id;

    /**
     * 校验数据
     */
    private LptImageCaptchaTrack data;

    /**
     * 人脸图片
     */
    private String faceBase64;

    /**
     * 验证码
     */
    private String code;

    /**
     * token
     */
    private String token;
    /**
     * ip
     */
    private String ip;
    /**
     * 设备
     */
    private String device;

    /**
     * 经度
     */
    private Double latitude;
    /**
     * 纬度
     */
    private Double longitude;

    public Double getLatitude() {
        return latitude;
    }

    public void setLatitude(Double latitude) {
        this.latitude = latitude;
    }

    public Double getLongitude() {
        return longitude;
    }

    public void setLongitude(Double longitude) {
        this.longitude = longitude;
    }

    public String getIp() {
        return ip;
    }

    public void setIp(String ip) {
        this.ip = ip;
    }

    public String getDevice() {
        return device;
    }

    public void setDevice(String device) {
        this.device = device;
    }

    public String getToken() {
        return token;
    }

    public void setToken(String token) {
        this.token = token;
    }

    public String getFaceBase64() {
        return faceBase64;
    }

    public void setFaceBase64(String faceBase64) {
        this.faceBase64 = faceBase64;
    }

    public String getUuid() {
        return uuid;
    }

    public void setUuid(String uuid) {
        this.uuid = uuid;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public LptImageCaptchaTrack getData() {
        return data;
    }

    public void setData(LptImageCaptchaTrack data) {
        this.data = data;
    }

    public String getCode() {
        return code;
    }

    public void setCode(String code) {
        this.code = code;
    }

    public Integer getStep() {
        return step;
    }

    public void setStep(Integer step) {
        this.step = step;
    }

    public Long getUserId() {
        return userId;
    }

    public void setUserId(Long userId) {
        this.userId = userId;
    }



    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }
}
